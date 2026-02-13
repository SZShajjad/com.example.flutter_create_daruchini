---
name: mobile-flutter
router_kit: FullStackKit
description: Flutter/Dart best practices and architecture.
---
# 🐦 Mobile Flutter

## 📁 Project Structure (Feature-First)

- `lib/core/`: Common utilities, themes, and base classes.
- `lib/features/`: Domain-specific modules (e.g., `auth`, `profile`).
- `lib/services/`: External API or infrastructure wrappers.

## 🧩 Widget Best Practices

- **Const Constructors**: Use them wherever possible to minimize rebuild cycles.
- **Granular Widgets**: Break down large build methods into smaller, reusable widgets.

## ⚡ Performance

- **ListView.builder**: Use for long or infinite lists.
- **Isolates**: Offload CPU-heavy computation (like heavy image processing) from the UI thread.

## 🔄 Workflow

1. **Architecture**: Initialize a standard Feature-First directory structure.
2. **Implementation**: Use persistent state management (like `Provider` or `Riverpod`).
3. **Quality**: Write tests and perform regular static analysis with `flutter analyze`.
4. **Hardening**: Configure `proguard-rules.pro` and `build.gradle` for R8/ProGuard to prevent class obfuscation crashes in release builds.

## 🧠 Session Learnings

- **Async Gap Guards**: Always wrap `Navigator` or `context` operations in `if (mounted)` after an `await` to prevent "use_build_context_synchronously" errors.
- **Dependency Audit**: Be wary of `^` (caret) in `pubspec.yaml` for critical plugins like `google_sign_in`. A minor update in the registry can break local builds if the Gradle environment isn't strictly aligned.
- **Branding Integration**: When removing features (e.g., Phone Auth), ensure all branding assets and navigation links are purged to maintain a consistent "premium" look.
- **Release Shrinking**: If `firebase_auth` or `google_sign_in` methods fail in release mode but work in debug, it's likely an R8 shrinking issue. Add `-keep` rules for the specific plugins.
- **Controller Disposal Mandate**: Every `TextEditingController`, `FocusNode`, `AnimationController`, and `ScrollController` MUST be `.dispose()`-d. Audit every screen for this after implementation.
- **Form Validation Pattern**: Always use `Form` + `GlobalKey<FormState>` with per-field `validator` functions. Never submit raw `TextEditingController.text` without validation.
- **Pre-Capture Pattern**: For complex async-then-navigate chains, capture `Navigator.of(context)` or `ScaffoldMessenger.of(context)` BEFORE the `await` to avoid stale context issues.
