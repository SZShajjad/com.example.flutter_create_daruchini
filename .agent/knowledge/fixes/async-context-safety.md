---
id: fix-async-001
version: 2.0.0
persona: staff_developer
tags: [fix, async, context, safety]
---

# ⚡ Fix: Async Context Safety

## 🚀 Concept

In Flutter, using `BuildContext` after an `await` can crash the app if the widget has been removed from the tree during the async operation. This is the #1 source of production crashes in auth flows.

## ✨ The Golden Rule

> **Never use `BuildContext` after an `await` without a `mounted` check.**

## 🛠️ Technical Patterns

### Pattern 1: State's `mounted` Check

Use when inside a `State<T>` class method:

```dart
await someAsyncOperation();
if (!mounted) return;
Navigator.of(context).push(...);
```

### Pattern 2: `context.mounted` Check

Use when inside a callback that captures `context` (like `onPressed`):

```dart
onPressed: () async {
  await someAsyncOperation();
  if (!context.mounted) return;
  Navigator.of(context).push(...);
}
```

### Pattern 3: Pre-Capture Navigator

The safest approach — capture the navigator BEFORE the await:

```dart
onPressed: () async {
  final navigator = Navigator.of(context);
  await someAsyncOperation();
  if (!context.mounted) return;
  navigator.pushReplacement(...);
}
```

## ⚠️ Common Mistake: Wrong `mounted` Reference

```dart
// ❌ WRONG: Using State's `mounted` for a context captured in a callback
onPressed: () async {
  await auth.signOut();
  if (!mounted) return; // This checks State, but context might be stale!
  Navigator.of(context).push(...); // LINT: use_build_context_synchronously
}

// ✅ CORRECT: Use context.mounted for context-based operations
onPressed: () async {
  await auth.signOut();
  if (!context.mounted) return;
  Navigator.of(context).push(...);
}
```

## 🛡️ Hardening

- Apply to EVERY screen with async operations (login, signup, verify, forgot password)
- Use `final navigator = Navigator.of(context)` pre-capture for complex chains
- `dart analyze` catches this as `use_build_context_synchronously`

## // RAG-TAGS

`#fix` `#async` `#context` `#safety`
