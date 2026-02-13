---
id: gloss-android-001
version: 1.0.0
persona: staff_pm
tags: [glossary, android, non-tech]
---

# 📱 Android Glossary — Plain English

A lookup table for every Android term you might encounter. Written for humans, not engineers.

| Term | What It Actually Means | Why You Should Care |
| --- | --- | --- |
| **APK** | The file you install on your phone. Think of it like a `.exe` on Windows. | This is what you share or upload to the Play Store. |
| **AAB** | A smarter version of APK that Google Play prefers. It makes the download smaller for users. | Google Play Store requires this format now. |
| **Gradle** | The machine that builds your app. Like a factory that takes your code and produces an APK. | When Gradle breaks, your app can't be built. It's the #1 source of build errors. |
| **SDK** | A toolbox. The Android SDK is the set of tools needed to build Android apps. | You need it installed, but you rarely touch it directly. |
| **R8 / ProGuard** | A shredder that removes unused code to make your app smaller and harder to reverse-engineer. | Sometimes it shreds code you actually need, causing crashes in release builds only. |
| **ADB** | A cable between your computer and your phone. Lets you install apps and see logs. | Useful for testing, but the agent handles it for you. |
| **Debug Mode** | A test version of your app with extra logging and slower performance. | Use this while developing. Never ship this to users. |
| **Release Mode** | The real, optimized version of your app. Fast, small, no debug info. | This is what goes to the Play Store. |
| **Manifest** | A file that tells Android what your app needs — permissions, screens, etc. | Think of it as the app's passport. |
| **Keystore** | A digital signature file. Like a wax seal that proves the app is from you. | You need this to publish. **NEVER lose it** — you can't update your app without it. |
| **Emulator** | A fake phone on your computer for testing. | Slower than a real phone, but handy when you don't have a device nearby. |
| **Permissions** | Things your app asks the user for — camera, location, storage, etc. | Only ask for what you need. Too many permissions scare users away. |
| **minSdkVersion** | The oldest Android version your app supports. | Lower = more users, but fewer features available. |
| **targetSdkVersion** | The Android version your app is optimized for. | Google requires you to keep this updated for Play Store listing. |

## // RAG-TAGS

`#glossary` `#android` `#non-tech`
