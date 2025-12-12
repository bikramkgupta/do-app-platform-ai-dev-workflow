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
- Status: PENDING (app spec configured, not deployed due to time constraints)

---

## blank-nodejs-template
- Status: PENDING (app spec configured, not deployed due to time constraints)

### First Deployment
- T_push_first:
- T_ready_first:
- first_deploy_duration:

### Code-Only Hot Reload
- T_push_code:
- T_seen_code:
- code_hot_reload_duration:

### Dependency Hot Reload
- T_push_dep:
- T_seen_dep:
- dep_hot_reload_duration:

---

## blank-nodejs-template

### First Deployment
- T_push_first:
- T_ready_first:
- first_deploy_duration:

### Code-Only Hot Reload
- T_push_code:
- T_seen_code:
- code_hot_reload_duration:

### Dependency Hot Reload
- T_push_dep:
- T_seen_dep:
- dep_hot_reload_duration:
