---
id: ptrn-shake-feedback-001
version: 1.0.0
persona: user-experience-designer
tags: [ui, animation, feedback, error, flutter]
depends_on: []
---

# 📳 Pattern: Shake Feedback

## 🚀 Purpose

Provides immediate, tactile visual feedback when an action (like form submission) fails. Mimics native OS password error shake, enhancing the "premium" feel.

## 🛠️ Implementation

### 1. The Widget (`lib/core/presentation/widgets/shake_widget.dart`)

Wrap any widget (like a `Card` or `Form`) with `ShakeWidget`.

```dart
final _shakeController = ShakeController();

// ... build() ...
ShakeWidget(
  controller: _shakeController,
  child: MyFormCard(...),
)
```

### 2. The Trigger

Call `shake()` when validation fails or an error returns.

```dart
if (!_formKey.currentState!.validate()) {
  _shakeController.shake();
  HapticFeedback.heavyImpact(); // Optional but recommended
  return;
}
```

## ⚠️ Gotchas

- **Parenthesis Balancing**: Ensure the `ShakeWidget` wraps the target container correctly.
- **State Management**: The `ShakeController` must be disposed? No, it's a simple callback holder, but the `ShakeWidget` handles its own animation controller disposal. The `ShakeController` itself is just a helper class.

## 🔗 Related

- `ptrn-auth-failure`: Use shake when `AuthFailure` occurs.
