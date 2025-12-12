# Hot Reload Performance Analysis

This document explains why hot reload takes the time it does and how to optimize it.

## TL;DR

| App Type | Code-Only | Dep+Code | Key Factor |
|----------|-----------|----------|------------|
| Python (uvicorn/uv) | ~62s | ~76s (+14s) | uv is extremely fast |
| Node.js (nodemon/npm) | ~53-69s | ~69-113s (+16-60s) | npm install is slow |
| Go (Air) | ~146s | ~182s (+36s) | Compilation takes ~2 min |
| Ruby (Rails) | ~40s | N/A* | Rails auto-reloads controllers |

*Rails dependency hot-reload requires committing Gemfile.lock

---

## Understanding Hot Reload Timing

### The Hot Reload Pipeline

When you `git push`, the following sequence occurs:

```
[Git Push]
    ↓
[Wait 0-15s for sync cycle]  ← SYNC_INTERVAL sleep
    ↓
[Git fetch + pull: ~2-5s]
    ↓
[Rsync to workspace: ~2-5s]   ← For monorepo mode
    ↓
[Dev server detects change]
    ↓
[Dependency install: VARIES]   ← Only if deps changed
    ↓
[App restart/reload: VARIES]
    ↓
[Change visible]
```

### Key Configuration: GITHUB_SYNC_INTERVAL

The sync daemon (github-sync.sh) sleeps between checks:

```bash
# Line 19 in github-sync.sh
SYNC_INTERVAL="${GITHUB_SYNC_INTERVAL:-15}"

# Line 407
sleep "$SYNC_INTERVAL"
```

**Default: 15 seconds**

This means after `git push`, you wait **0-15 seconds** (random) before the sync daemon even checks for changes.

---

## Timing Breakdown by Language

### Python (FastAPI with uvicorn)

**Code-Only: ~62 seconds**
- 0-15s: Sync interval wait
- ~5s: Git fetch/pull + rsync
- ~42s: uvicorn --reload detecting and restarting

**Dep+Code: ~76 seconds (+14s)**
- Same as above, plus
- +14s: `uv pip install` (extremely fast!)

**Why Python is fast:** The `uv` package manager is written in Rust and installs dependencies ~10-100x faster than pip.

---

### Node.js (Express with nodemon)

**Code-Only: ~53-69 seconds**
- 0-15s: Sync interval wait
- ~5s: Git fetch/pull + rsync
- ~33-49s: nodemon detecting change and restarting

**Dep+Code: ~69-113 seconds (+16-60s)**
- Same as above, plus
- +16-60s: `npm install` (varies by package count/size)

**Why Node.js varies:** npm install time depends heavily on:
- Number of new packages
- Package sizes
- Network speed to npm registry
- Whether packages have native bindings

---

### Go (with Air hot reloader)

**Code-Only: ~146 seconds (2m 26s)**
- 0-15s: Sync interval wait
- ~5s: Git fetch/pull + rsync
- ~126s: Go compilation (building binary)

**Dep+Code: ~182 seconds (3m 2s)**
- Same as above, plus
- +36s: `go mod tidy` + download + recompile

**Why Go is slowest:** Go is a compiled language. Every code change requires:
1. Dependency resolution (`go mod tidy`)
2. Full binary compilation
3. Binary restart

**Expected behavior:** Brief 503 errors during binary rebuild are normal.

---

### Ruby on Rails

**Code-Only: ~40 seconds** (fastest!)
- 0-15s: Sync interval wait
- ~5s: Git fetch/pull + rsync
- ~20s: Rails development mode auto-reload

**Dep+Code: Requires Gemfile.lock**

**Why Rails is fastest for code changes:** Rails development mode auto-reloads controllers/models on each request. No server restart needed!

**Dependency caveat:** The `dev_startup.sh` checks `Gemfile.lock` hash, not `Gemfile`:
```bash
# Hash-based dependency change detection
GEMFILE_HASH_FILE="/tmp/gemfile_hash.txt"
if [ -f "Gemfile.lock" ]; then
    CURRENT_HASH=$(md5sum Gemfile.lock | cut -d' ' -f1)
    ...
```

**For Rails dependency hot-reload:** Always commit BOTH `Gemfile` AND `Gemfile.lock`.

---

## Optimization Tips

### 1. Reduce Sync Interval (Trade-off: More Git Operations)

```yaml
envs:
  - key: GITHUB_SYNC_INTERVAL
    value: "5"  # 5 seconds instead of 15
```

**Impact:** Reduces wait time from 0-15s to 0-5s
**Trade-off:** More frequent git fetch operations

### 2. Use Faster Package Managers

| Language | Slow | Fast |
|----------|------|------|
| Python | pip | **uv** (10-100x faster) |
| Node.js | npm | **pnpm** or **bun** |
| Ruby | bundler | bundler (no alternative) |

### 3. Minimize Dependencies

Fewer dependencies = faster installs. For hot-reload testing:
- Add only one dependency at a time
- Use lightweight packages when possible

### 4. Pre-install Common Dependencies

If you frequently add the same dependencies, include them in your base `package.json`/`requirements.txt` from the start.

---

## Test Results Summary (2025-12-12)

All tests performed on DigitalOcean App Platform in region **syd1**.

### First Deploy Times

| App | Duration | Notes |
|-----|----------|-------|
| Python FastAPI | 5m 42s | Fastest first deploy |
| Blank NodeJS | ~5m | Simple Express app |
| Next.js | 6m 6s | Next.js build step |
| Node.js Job | 6m 23s | Standard Node.js |
| Go | 6m 47s | Go compilation |
| Ruby Rails | ~12m | Full Rails asset pipeline |

### Hot Reload Performance

| App | Code-Only | Dep+Code | Status |
|-----|-----------|----------|--------|
| Python FastAPI | 62s | 76s | ✅ |
| Next.js | 62s | 113s | ✅ |
| Node.js | 53s | - | ✅ (partial test) |
| Go | 146s | 182s | ✅ |
| Ruby Rails | 40s | - | ⚠️ (needs Gemfile.lock) |
| Blank NodeJS | 69s | 69s | ✅ |

---

## Key Findings

1. **Python (uv) is fastest** for dependency hot-reload (+14s)
2. **Rails is fastest** for code-only changes (40s) due to auto-reload
3. **Go is slowest** due to compilation (~2-3 min for any change)
4. **Brief 503 errors** during Go rebuilds are expected
5. **Rails dependency hot-reload** requires committing `Gemfile.lock`
6. **Sync interval (15s)** adds randomness to all timings

---

## Recommendations

1. **For rapid iteration:** Use Python with uv
2. **For frontend work:** Use Next.js with npm (or faster with pnpm)
3. **For compiled languages:** Accept longer reload times or use interpreted alternatives during development
4. **For Rails:** Commit lock files, leverage auto-reload for controller changes
