---
id: fix-android-fragment-activity
version: 1.0.0
persona: developer
tags: [flutter, android, local_auth, fragment-activity, crash]
title: Fix Android Crash with local_auth Plugin
summary: Why local_auth requires FlutterFragmentActivity and how to fix it.
---

# 🔧 Fix: Android Crash with local_auth Plugin

## Problem

When using the `local_auth` plugin (or other plugins requiring Fragments) on Android, the app crashes immediately on launch or when invoking authentication, often with an error like:

`java.lang.ClassCastException: MainActivity cannot be cast to androidx.fragment.app.FragmentActivity`

## Cause

By default, Flutter creates `MainActivity.kt` extending `FlutterActivity`. However, `local_auth` relies on the legacy `FragmentActivity` to show biometric prompts.

## Solution

Change `MainActivity.kt` to extend `FlutterFragmentActivity`.

### Steps

1. Open `android/app/src/main/kotlin/.../MainActivity.kt`.
2. Change the import and class definition:

```kotlin
// OLD
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
}

// NEW
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity() {
}
```

## Verification

Rebuild the app (`flutter clean && flutter build apk`). The crash should be resolved.
