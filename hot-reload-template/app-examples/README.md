# App Examples

This folder contains working sample applications that demonstrate how to use the `hot-reload-template` for hot-reload development on DigitalOcean App Platform.

## What This Folder Does

Each subfolder contains a complete, working sample application that:
- Uses the enhanced `dev_startup.sh` scripts from `hot-reload-template/examples/`
- Demonstrates hot-reload setup for a specific framework (Go, Python/FastAPI, Next.js)
- Includes a complete `appspec.yaml` configuration for **testing/hot-reload** environment

## Quick Deploy

Deploy any example app to DigitalOcean App Platform with one click:

### Go Sample App
[![Deploy to DO](https://www.deploytodo.com/do-btn-blue.svg)](https://cloud.digitalocean.com/apps/new?repo=https://github.com/bikram20/do-app-platform-ai-dev-workflow&appspec=https://raw.githubusercontent.com/bikram20/do-app-platform-ai-dev-workflow/main/hot-reload-template/app-examples/go-sample-app/appspec.yaml)

**What gets deployed**:
- Hot-reload development environment (NOT production)
- Syncs code from `hot-reload-template/app-examples/go-sample-app/`
- Changes sync every 30 seconds
- Uses Air for Go hot-reload

**Configuration**: See [appspec.yaml](go-sample-app/appspec.yaml)

---

### Python FastAPI Sample
[![Deploy to DO](https://www.deploytodo.com/do-btn-blue.svg)](https://cloud.digitalocean.com/apps/new?repo=https://github.com/bikram20/do-app-platform-ai-dev-workflow&appspec=https://raw.githubusercontent.com/bikram20/do-app-platform-ai-dev-workflow/main/hot-reload-template/app-examples/python-fastapi-sample/appspec.yaml)

**What gets deployed**:
- Hot-reload development environment (NOT production)
- Syncs code from `hot-reload-template/app-examples/python-fastapi-sample/`
- Changes sync every 30 seconds
- Uses uvicorn with reload flag

**Configuration**: See [appspec.yaml](python-fastapi-sample/appspec.yaml)

---

### Next.js Sample App
[![Deploy to DO](https://www.deploytodo.com/do-btn-blue.svg)](https://cloud.digitalocean.com/apps/new?repo=https://github.com/bikram20/do-app-platform-ai-dev-workflow&appspec=https://raw.githubusercontent.com/bikram20/do-app-platform-ai-dev-workflow/main/hot-reload-template/app-examples/nextjs-sample-app/appspec.yaml)

**What gets deployed**:
- Hot-reload development environment (NOT production)
- Syncs code from `hot-reload-template/app-examples/nextjs-sample-app/`
- Changes sync every 30 seconds
- Uses Next.js dev server with hot-reload

**Configuration**: See [appspec.yaml](nextjs-sample-app/appspec.yaml)

---

**Important Notes**:
- These buttons deploy **TESTING/HOT-RELOAD** environments, NOT production
- `deploy_on_push: true` triggers rebuilds when the hot-reload-template changes
- Application code syncs via `github-sync.sh` daemon (no full rebuild needed)
- For production deployment, use separate appspec.yaml with buildpack or your Dockerfile

## Sample Applications

- **go-sample-app/** - Go application with hot-reload
- **python-fastapi-sample/** - Python FastAPI application with hot-reload
- **nextjs-sample-app/** - Next.js application with hot-reload

## Important Notes

### dev_startup.sh Source

The `dev_startup.sh` scripts in these sample apps are copied from `hot-reload-template/examples/` and include:
- Automatic lock file conflict resolution
- Hard rebuild logic on dependency errors
- Framework-specific optimizations (e.g., `.npmrc` for Next.js)

### appspec.yaml is Critical for Hot Reload

The `appspec.yaml` file in each sample is essential for hot-reload functionality:

1. **Health Check Configuration** - Points to your app's health endpoint (not the dev health server)
2. **Environment Variables** - Sets `ENABLE_DEV_HEALTH=false` once your app is ready
3. **Build Arguments** - Enables only the runtimes you need (faster builds)
4. **Port Configuration** - Ensures your app listens on port 8080
5. **Dockerfile Path** - Points to `hot-reload-template/Dockerfile` for the dev container

Without proper `appspec.yaml` configuration, the container may not route traffic correctly or health checks may fail, preventing hot-reload from working.

### Production Deployment is Different

**Important:** The `appspec.yaml` in these examples is configured for **testing/hot-reload** environments. For **production deployment**, you need a separate `appspec.yaml` that:

- **Does NOT use** the `hot-reload-template/Dockerfile`
- **Uses either:**
  - **Buildpack-based build** (default for most frameworks) - App Platform automatically detects and builds
  - **Your own Dockerfile** - If you have custom build requirements

**Key Point:** If you have your own Dockerfile for production, you don't need to replace it. The `hot-reload-template/Dockerfile` is only for the hot-reload testing environment. For production:
- Keep your existing Dockerfile
- Use `dev_startup.sh` from `hot-reload-template/examples/` (if you want hot-reload in testing)
- Create separate `appspec.yaml` files: one for testing (uses hot-reload-template), one for production (uses your Dockerfile or buildpack)

## Usage

These samples serve as reference implementations. Copy the `dev_startup.sh` and adapt the `appspec.yaml` for your own applications. Remember to create separate configurations for testing (hot-reload) and production (optimized build).

