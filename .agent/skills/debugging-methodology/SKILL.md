---
name: debugging-methodology
router_kit: FullStackKit
description: Systematic debugging loop and patterns.
---
# 🔍 Debugging Methodology

## 🔄 Debugging Loop

REPRODUCE → UNDERSTAND → ISOLATE → HYPOTHESIZE → TEST → FIX → REFLECT

## 1️⃣ Reproduce

Define clear steps and environment variables. If it only happens in `release` build, assume R8/ProGuard or configuration mismatch.

## 2️⃣ 5 Whys

Ask "Why?" until the root cause is uncovered (e.g., "Why did the APK fail?" -> "Missing class" -> "Class obfuscated" -> "Missing -keep rule").

## 🔄 Workflow

1. **Triage**: Record exact error messages and full stack traces.
2. **Isolation**: Comment out parts of the system or use mock data to narrow down the fault.
3. **Parallel Auditing**: When stuck, use sub-agents or alternate analysis tools (like `dart analyze` vs `grep_search`) to verify code path assumptions.
4. **Automated Fix Cycles**: Propose a fix, run a build, analyze logs, and iterate without manual user intervention until stable.
5. **Resolution**: Apply the fix with minimal required changes to avoid side effects.

## 🧠 Session Learnings

- **Syntax Precision**: A single missing closing parenthesis in a nested `BackdropFilter` or `Stack` can lead to generic build errors that are hard to trace. Always format and lint before building.
- **Linter as a Guard**: Tools like `flutter analyze` are essential for catching `use_build_context_synchronously`. This prevents "context used across async gap" crashes in production.
- **Flutter Deprecations**: Always check for `.withOpacity()` usage and migrate to `.withValues(alpha: ...)` to stay current with the Flutter SDK.
- **Parallel Context**: Always cross-reference `analysis.txt` with build logs; often the linter catches what the compiler only cryptically fails on.
