---
id: ptrn-auth-failure-001
version: 1.0.0
persona: security-engineer
tags: [auth, error-handling, firebase, security]
depends_on: []
---

# 🛡️ Pattern: Robust Auth Failure

## 🚀 Purpose

Decouple business logic errors (from Firebase) from UI strings using a standardized `Failure` class to ensure consistent, secure, and user-friendly error handling.

## 🛠️ Implementation

### 1. `Failure` Base Class

Abstract class with a `message` getter.

### 2. `AuthFailure` Subclass

Handles specific auth errors (e.g., `user-not-found`, `wrong-password`). Use `fromCode(code)` factory.

```dart
// Provider returns Failure?
Future<Failure?> signIn(...) async {
  try {
    await _auth.signIn(...);
    return null;
  } on FirebaseAuthException catch (e) {
    return AuthFailure.fromCode(e.code);
  }
}
```

### 3. UI Consumption

```dart
final failure = await auth.signIn(...);
if (failure != null) {
  _shakeController.shake(); // Provide premium feedback
  setState(() => _errorMessage = failure.message);
}
```

## ⚠️ Security Notes

- **Account Enumeration**: For password reset, ALWAYS return success (null) or suppress `user-not-found` errors.
- **Generic Server Errors**: Catch generic exceptions and return a `ServerFailure` to avoid leaking stack traces.

## 🔗 Related

- `ptrn-shake-feedback`: Recommended for `AuthFailure` visualization.
