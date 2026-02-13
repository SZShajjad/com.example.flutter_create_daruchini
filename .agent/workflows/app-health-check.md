---
description: Quick health check workflow to assess app status — reports in plain English
---

# 🏥 App Health Check Workflow

A quick audit to assess the overall health of your app. Reports status in language anyone can understand.

## 1. Static Analysis

// turbo
Run `dart analyze` on the entire project.

- **Healthy**: "Zero issues found. Your code is clean." ✅
- **Warning**: "Found X minor issues. None will crash the app, but I recommend fixing them."
- **Error**: "Found X problems that need fixing before the app can work properly."

## 2. Dependency Check

// turbo
Run `flutter pub outdated` to check for stale packages.

- Report how many packages are outdated
- Flag any with **known security issues**
- Recommend updates only for critical packages

## 3. Build Test

// turbo
Run `flutter build apk --debug` to verify the app compiles.

- **Pass**: "The app builds successfully." ✅
- **Fail**: Diagnose the error and report what broke and how to fix it

## 4. Security Quick-Scan

Check for common security anti-patterns:

- [ ] All `mounted` checks present after async gaps
- [ ] All controllers disposed
- [ ] No hardcoded API keys in source code
- [ ] `google-services.json` is in `.gitignore`
- [ ] Anti-enumeration applied to auth error messages

## 5. Health Report

Generate a plain-English summary:

```
📊 App Health Report — [Date]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ Code Quality: Clean (0 errors)
✅ Dependencies: Up to date
✅ Build: Successful
✅ Security: Hardened
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Overall: HEALTHY 💚
```

## // turbo-all
