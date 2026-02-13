---
id: fix-res-001
version: 1.0.0
persona: staff_developer
tags: [fix, memory, lifecycle]
---

# 🧹 Fix: Resource Management & Disposal

## 🚀 Concept

Every resource created in `initState()` or a constructor MUST be disposed in `dispose()`. Leaks cause memory bloat, phantom listeners, and crashes.

## ✨ The Golden Rule

> **"Every `init` must have a matching `dispose`."**

## 🛠️ Technical Patterns

### TextEditingController

```dart
class _MyScreenState extends State<MyScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
```

### Timer

```dart
Timer? _cooldownTimer;

void _startCooldown() {
  _cooldownTimer?.cancel(); // Cancel any existing timer first
  _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
    if (!mounted) { timer.cancel(); return; }
    setState(() { /* update countdown */ });
  });
}

@override
void dispose() {
  _cooldownTimer?.cancel();
  super.dispose();
}
```

### StreamSubscription

```dart
StreamSubscription<User?>? _authSub;

void _listenToAuth() {
  _authSub = _auth.authStateChanges().listen((user) { /* ... */ });
}

@override
void dispose() {
  _authSub?.cancel();
  super.dispose();
}
```

## 🛡️ Checklist

- [ ] All `TextEditingController`s have matching `.dispose()`
- [ ] All `Timer`/`Timer.periodic` have matching `.cancel()`
- [ ] All `StreamSubscription`s have matching `.cancel()`
- [ ] All `AnimationController`s have matching `.dispose()`
- [ ] All `FocusNode`s have matching `.dispose()`
- [ ] All `ScrollController`s have matching `.dispose()`

## // RAG-TAGS

`#fix` `#memory` `#lifecycle` `#disposal`
