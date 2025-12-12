# Hot Reload Timing Log

## Test Environment
- Branch: claude-hotreloadtesting-1
- Region: syd1
- Test Date: 2025-12-12

---

## nextjs-sample-app

### First Deployment
- T_push_first: 2025-12-12T09:18:30-08:00
- T_ready_first: 2025-12-12T09:24:36-08:00
- first_deploy_duration: 366s (6m 6s)
- App ID: b5641bee-f56e-47c7-8440-ebc9212bb0ec
- URL: https://nextjs-hotreload-test-claude-ej2oy.ondigitalocean.app

### Code-Only Hot Reload
- T_push_code: 2025-12-12T09:25:12-08:00
- T_seen_code: 2025-12-12T09:26:14-08:00
- code_hot_reload_duration: 62s
- Change: Added "HOT RELOAD TEST: Code-only change successful!" message

### Dependency Hot Reload
- T_push_dep: 2025-12-12T09:27:03-08:00
- T_seen_dep: 2025-12-12T09:28:56-08:00
- dep_hot_reload_duration: 113s (1m 53s)
- Change: Added dayjs dependency and displayed formatted current time
- Notes: Hot reload handled dependency install via npm - no full rebuild required

---

## go-sample-app

### First Deployment
- T_push_first: 2025-12-12T09:30:00-08:00
- T_ready_first: 2025-12-12T09:36:47-08:00
- first_deploy_duration: 407s (6m 47s)
- App ID: b93583bc-3bf4-4041-8a68-9678c6981b0b
- URL: https://go-hotreload-test-claude-mftlz.ondigitalocean.app

### Code-Only Hot Reload
- T_push_code: 2025-12-12T09:37:19-08:00
- T_seen_code: 2025-12-12T09:39:45-08:00
- code_hot_reload_duration: 146s (2m 26s)
- Change: Added hot_reload field to root handler response
- Notes: App briefly showed 503 during Go binary rebuild

### Dependency Hot Reload
- T_push_dep: 2025-12-12T09:40:32-08:00
- T_seen_dep: 2025-12-12T09:43:34-08:00
- dep_hot_reload_duration: 182s (3m 2s)
- Change: Added go-humanize dependency and display human-readable time
- Notes: Hot reload handled go mod tidy and rebuild - no full App Platform rebuild

---

## python-fastapi-sample

### First Deployment
- T_push_first: 2025-12-12T09:44:28-08:00
- T_ready_first: 2025-12-12T09:50:10-08:00
- first_deploy_duration: 342s (5m 42s)
- App ID: 0d1a8bc2-cc20-4343-a303-28d253062a17
- URL: https://python-hotreload-test-claude-rna7d.ondigitalocean.app

### Code-Only Hot Reload
- T_push_code: 2025-12-12T09:50:46-08:00
- T_seen_code: 2025-12-12T09:51:48-08:00
- code_hot_reload_duration: 62s
- Change: Added hot_reload field to root endpoint response
- Notes: uvicorn --reload handled changes seamlessly

### Dependency Hot Reload
- T_push_dep: 2025-12-12T09:52:30-08:00
- T_seen_dep: 2025-12-12T09:53:46-08:00
- dep_hot_reload_duration: 76s
- Change: Added arrow dependency for human-readable time
- Notes: uv handled dependency install seamlessly with hot reload

---

## nodejs-job-test

### First Deployment
- T_push_first: 2025-12-12T09:55:02-08:00
- T_ready_first: 2025-12-12T10:01:25-08:00
- first_deploy_duration: 383s (6m 23s)
- App ID: 203c36d2-8c79-4f38-b697-a762a25b5726
- URL: https://nodejs-hotreload-test-claude-8efh9.ondigitalocean.app

### Code-Only Hot Reload
- T_push_code: 2025-12-12T10:01:55-08:00
- T_seen_code: 2025-12-12T10:02:48-08:00
- code_hot_reload_duration: 53s
- Change: Added hot_reload field to health endpoint
- Notes: nodemon handled changes seamlessly

### Dependency Hot Reload
- Status: PENDING (not tested due to time constraints)

---

## ruby-rails-sample

### First Deployment
- T_push_first: 2025-12-12T10:37:45-08:00 (estimated from app creation)
- T_ready_first: 2025-12-12T10:49:37-08:00
- first_deploy_duration: ~12 minutes (Rails builds are longer)
- App ID: b54e729d-8de3-48ff-b15a-a658e0cb813d
- URL: https://rails-hotreload-test-claude-osv2k.ondigitalocean.app

### Code-Only Hot Reload
- T_push_code: 2025-12-12T10:57:35-08:00
- T_seen_code: 2025-12-12T10:58:15-08:00
- code_hot_reload_duration: 40s
- Change: Added hot_reload field to health endpoint
- Notes: Rails development mode auto-reloads controllers on each request

### Dependency Hot Reload
- T_push_dep: 2025-12-12T10:59:22-08:00
- Status: ⚠️ PARTIAL - Gemfile synced but bundle install didn't run
- Notes: Rails dev_startup.sh checks Gemfile.lock hash, not Gemfile. To trigger bundle install, Gemfile.lock must also be committed.
- Finding: For Rails dependency hot-reload, always commit both Gemfile AND Gemfile.lock

---

## blank-nodejs-template

### First Deployment
- T_push_first: 2025-12-12T10:47:47-08:00 (estimated from app creation)
- T_ready_first: 2025-12-12T10:52:28-08:00
- first_deploy_duration: ~5 minutes
- App ID: 9649898b-804c-4f90-b8eb-34cffdfeaadd
- URL: https://blank-hotreload-test-claude-7o5tj.ondigitalocean.app

### Code-Only Hot Reload
- T_push_code: 2025-12-12T10:57:35-08:00
- T_seen_code: 2025-12-12T10:58:44-08:00
- code_hot_reload_duration: 69s
- Change: Added hot_reload field to health endpoint
- Notes: Brief 503 during nodemon restart, then recovered

### Dependency Hot Reload
- T_push_dep: 2025-12-12T10:59:22-08:00
- T_seen_dep: 2025-12-12T11:00:31-08:00
- dep_hot_reload_duration: 69s
- Change: Added dayjs dependency and formatted_time field
- Notes: npm install handled by nodemon detecting package.json changes
