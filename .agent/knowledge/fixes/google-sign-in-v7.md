---
id: fix-google-sign-in-v7
version: 1.0.0
persona: developer
tags: [flutter, auth, google-sign-in, breaking-changes, v7]
title: Fix Google Sign-In v7 Missing Access Token
summary: How to resolve the 'undefined getter accessToken' error in google_sign_in v7+.
---

# 🔧 Fix: Google Sign-In v7 Missing Access Token

## Problem

After upgrading `google_sign_in` to v7.0.0+, you encounter this error:
`The getter 'accessToken' isn't defined for the class 'GoogleSignInAuthentication'.`

This occurs because `accessToken` (and `idToken` in some contexts) was removed from the `GoogleSignInAuthentication` class to improve security and platform compliance.

## Solution

### 1. Update Dependencies

Ensure you are using compatible versions of `firebase_auth` (v5.x+) and `google_sign_in` (v7.x+).

```yaml
dependencies:
  firebase_auth: ^5.0.0
  google_sign_in: ^7.0.0
```

### 2. Remove `accessToken` Usage

When creating credentials for Firebase, **remove the `accessToken` parameter**. Firebase Auth now supports authentication using only the `idToken` for Google Sign-In.

**Before (v6):**

```dart
final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
final credential = GoogleAuthProvider.credential(
  accessToken: googleAuth.accessToken, // REMOVE THIS
  idToken: googleAuth.idToken,
);
```

**After (v7):**

```dart
final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
final credential = GoogleAuthProvider.credential(
  idToken: googleAuth.idToken, // sufficient for Firebase
);
```

## Explanation

The `accessToken` is primarily used for accessing authorized Google APIs (like Drive or Calendar) on behalf of the user. For simple **authentication** (proving who the user is), the `idToken` (Identity Token) is sufficient and more secure. Firebase Auth validates the `idToken`.

If you *need* an access token for API calls, you must request specific scopes and handle token retrieval differently (refer to `google_sign_in` documentation for platform-specific flows).
