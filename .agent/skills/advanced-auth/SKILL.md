---
name: advanced-auth
description: Best practices for implementing secure authentication in Flutter (fluter_firebase_auth).
---

# Advanced Authentication Skill

## 1. Google Sign-In Pattern

**Principle**: Use `GoogleSignIn` to retrieve tokens, then exchange them for a `FirebaseCredential`.

### Google Sign-In Implementation

```dart
Future<User?> signInWithGoogle() async {
  // 1. Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  if (googleUser == null) return null; // User cancelled

  // 2. Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // 3. Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // 4. Sign in to Firebase with the new credential
  final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
  return userCredential.user;
}
```

## 2. Email Verification Pattern

**Principle**: Never trust a user until they verify their email. Gate access to the main app.

### Verification Implementation

- **Sign Up**: Call `user.sendEmailVerification()` immediately after `createUserWithEmailAndPassword`.
- **Auth State Change**: Check `if (!user.emailVerified)`. If true, redirect to `VerificationPendingScreen`.
- **Reload**: You MUST call `await user.reload()` to update the `emailVerified` status after the user clicks the link.

## 3. Security Hardening

- **Error Handling**: NEVER show raw exceptions. Use `_getErrorMessage(e.code)`.
- **Scopes**: Only request the scopes you need (default is usually sufficient for identity).
- **Platform**: Ensure `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) are current.

## 4. Session Learnings

- **Manual State Refresh**: Firebase Auth is a client-side listener. When a user verifies their email via a link, the local `User` object doesn't update automatically. You MUST call `await user.reload()` before checking `user.emailVerified`.
- **Dependency Management**: When using `google_sign_in`, avoid the latest version if the project's Gradle or Kotlin version is lagging. Reverting to a stable, slightly older version (e.g., `6.2.1` over `7.2.0`) can resolve opaque build failures.
- **Async Navigation**: In auth screens, asynchronous operations (like `signInWithGoogle`) often lead to navigation. Always guard these with `if (!mounted) return;` to avoid context errors on high-latency operations.
- **Google Disconnect on Sign-Out**: Calling `FirebaseAuth.signOut()` alone doesn't disconnect Google. You MUST also call `GoogleSignIn().signOut()` or the user will be auto-logged-in on next attempt without consent.
- **Input Trimming**: Always `.trim()` email inputs before sending to Firebase. A trailing space causes "user-not-found" errors that are invisible to the user.
- **Anti-Enumeration**: Password reset must ALWAYS return success, regardless of whether the account exists. Firebase only sends the email if the account is real — the client should never reveal this.
- **Subscription Lifecycle**: Store `authStateChanges().listen()` as a `StreamSubscription` and cancel it in `dispose()`. Without this, the listener leaks and fires on disposed providers.
