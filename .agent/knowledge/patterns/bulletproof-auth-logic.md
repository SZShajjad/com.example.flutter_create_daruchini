---
id: ptrn-auth-001
version: 2.0.0
persona: staff_developer
tags: [pattern, auth, security]
---

# 🛡️ Bulletproof Auth Logic

## 🔑 Core Integrity

The `daruchini_auth` system implements several layers of security and resilience:

1. **State Persistence**: Uses Firebase Auth's native persistence to keep users signed in across restarts.
2. **Email Verification**: Mandates email verification before allowing access to internal features.
3. **Atomic Operations**: All auth methods (Sign In, Sign Up, Google) return a nullable `String`. A `null` return indicates success, while a `String` contains a human-readable, specific error message.
4. **Subscription Lifecycle**: Auth state `StreamSubscription` is stored and cancelled in `dispose()` to prevent memory leaks.
5. **Input Sanitization**: All email inputs are `.trim()`-ed before submission to Firebase.
6. **Google Sign-Out**: `signOut()` calls both `GoogleSignIn().signOut()` and `_auth.signOut()` to fully disconnect.

## 🚀 The Launch Flow (Industry-Standard)

1. **SplashScreen**: Loads immediately to prevent the "Auth Flicker" (where a user sees the login screen briefly before the app realizes they are authenticated).
2. **Auth Guard**: The Splash screen checks `isAuthenticated` and `isEmailVerified` before routing.
3. **Biometric Gate**: If available, biometric auth is required before proceeding. Fallback to password login on failure.
4. **Graceful Redirects**: Users are sent to the correct stage (Verify Email, Login, or Home) based on their real-time state.
5. **`mounted` Checks**: Every async gap is followed by a `if (!mounted) return;` guard.

## 🔐 Password Validation (Signup)

- **Regex**: `^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$`
- **Strength Indicator**: Visual linear progress bar with labels (Weak/Fair/Strong/Excellent).
- **Confirm Password**: Second field must match, validated by `FormState`.

## 🛠️ Error Resilience

- **Google Cancellation**: Handled as a specific return message, not a crash.
- **Network loss**: Handled via `FirebaseAuthException` mapping.
- **Context Safety**: All navigation is protected by `mounted` checks to prevent crashes on slow connections.
- **Opaque Errors (Privacy)**: Mismatch errors (Not Found vs. Wrong Password) are collapsed into a single generic message to prevent account enumeration.
- **Password Reset Anti-Enumeration**: Always returns success regardless of whether the account exists.

## 🕐 Rate Limiting

- **Verify Email Resend**: 30-second cooldown timer between resend requests.
- **Forgot Password**: 60-second cooldown timer between reset link requests.

## 🧹 Resource Management

- **TextEditingController disposal**: All controllers are disposed in `dispose()`.
- **Timer disposal**: Cooldown timers are cancelled in `dispose()`.
- **StreamSubscription cancellation**: Auth listener is cancelled in `AuthProvider.dispose()`.
