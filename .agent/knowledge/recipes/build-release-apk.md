---
id: recipe-build-001
version: 1.0.0
persona: staff_developer
tags: [recipe, build, apk, release]
---

# 📦 Recipe: Build a Release APK

## What You'll Get

A production-ready APK file you can share with testers or upload to the Play Store.

## Prerequisites

- A **keystore** file (your digital signature). If you don't have one, tell the agent: "Create a keystore for me."
- A `key.properties` file with your keystore credentials

## Steps

### Step 1: Create a Keystore (First Time Only)

The agent runs:

```bash
keytool -genkey -v -keystore daruchini-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias daruchini
```

You'll be asked for a password. **Remember it and NEVER lose the keystore file.**

### Step 2: Configure Signing

The agent creates `android/key.properties`:

```properties
storePassword=YOUR_PASSWORD
keyPassword=YOUR_PASSWORD
keyAlias=daruchini
storeFile=../daruchini-release-key.jks
```

And updates `android/app/build.gradle` to use it for release builds.

### Step 3: Build the APK

```bash
flutter build apk --release
```

The APK will be at: `build/app/outputs/flutter-apk/app-release.apk`

### Step 4: Test the Release APK

Install it on a real device:

```bash
flutter install --release
```

**Important**: Test ALL features in release mode. Some things that work in debug mode fail in release.

## ⚠️ Common Issues

| Problem | Solution |
| --- | --- |
| App crashes on launch in release | Add ProGuard/R8 keep rules (see `proguard-rules.pro`) |
| Google Sign-In fails in release | Add the release SHA-1 to Firebase Console |
| App is very large | Use `flutter build appbundle` instead for Play Store |
| Build fails with "signing" error | Check `key.properties` paths and passwords |

## 🛡️ Security Rules

- **NEVER** commit `key.properties` or `.jks` files to Git
- Add them to `.gitignore`
- Store backups in a secure location (not Google Drive in plain sight)

## // RAG-TAGS

`#recipe` `#build` `#apk` `#release`
