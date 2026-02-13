---
id: recipe-firebase-001
version: 1.0.0
persona: staff_developer
tags: [recipe, firebase, backend]
---

# 🔥 Recipe: Add a Firebase Feature

## What You'll Get

Connect a new Firebase service (Firestore, Cloud Storage, etc.) to your app.

## Steps

### Step 1: Add the Package

Tell the agent which Firebase service you want:

| You Say | The Agent Adds |
| --- | --- |
| "I want a database" | `cloud_firestore` |
| "I want to store files/images" | `firebase_storage` |
| "I want push notifications" | `firebase_messaging` |
| "I want crash reports" | `firebase_crashlytics` |
| "I want analytics" | `firebase_analytics` |

The agent runs: `flutter pub add [package_name]`

### Step 2: Enable in Firebase Console

1. Go to [console.firebase.google.com](https://console.firebase.google.com)
2. Select your project
3. Click the service you want (e.g., "Firestore Database")
4. Click **Create database** or **Get started**
5. Choose "Start in test mode" for development

### Step 3: Initialize in Code

The agent adds initialization in `main.dart`:

```dart
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

> This is already done for Daruchini Auth. No extra setup needed.

### Step 4: Use the Service

The agent creates a service class in `lib/services/` to interact with the Firebase feature.

## 🛡️ Bulletproof Checklist

- [ ] Package added to `pubspec.yaml`
- [ ] Service enabled in Firebase Console
- [ ] `google-services.json` is up to date
- [ ] Service class created with proper error handling
- [ ] Security rules configured (not left open in production)

## // RAG-TAGS

`#recipe` `#firebase` `#backend`
