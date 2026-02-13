---
id: fix-sec-001
version: 2.0.0
persona: staff_developer
tags: [fix, security, privacy]
---

# 🛡️ Fix: Account Enumeration Prevention

## 🚀 Concept

Ensuring that authentication error messages do not leak information about whether an account exists in the system.

## ✨ Principles

- **Opaque Feedback**: Avoid "User not found" or "Account exists". Use "Incorrect email or password".
- **Ambiguity as Defense**: Provide the same amount of information regardless of whether the identifier exists or not.

## 🛠️ Technical Pattern

### Login (Opaque Errors)

```dart
String _getErrorMessage(String code) {
  switch (code) {
    case 'user-not-found':
    case 'wrong-password':
    case 'invalid-credential':
      return 'Incorrect email or password.';
    // ...
  }
}
```

### Password Reset (Always-Success)

```dart
Future<String?> sendPasswordResetEmail(String email) async {
  try {
    await _auth.sendPasswordResetEmail(email: email.trim());
    return null;
  } on FirebaseAuthException catch (_) {
    // Always return success to prevent account enumeration
    return null;
  }
}
```

UI always shows: "If an account exists for this email, a reset link has been sent."

## 🛡️ Hardening (Bulletproof)

- Apply to Login, Sign-Up, and Password Reset.
- On Sign-Up, if an account exists, consider sending a "Login instead" email rather than showing an error.
- Password Reset: never reveal whether the email exists; always show the same success message.
- Rate-limit password reset requests (60s cooldown) to prevent abuse.

## // RAG-TAGS

`#fix` `#security` `#privacy`
