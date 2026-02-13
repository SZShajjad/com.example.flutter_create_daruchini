---
id: gloss-firebase-001
version: 1.0.0
persona: staff_pm
tags: [glossary, firebase, non-tech]
---

# 🔥 Firebase Glossary — Plain English

Firebase is Google's backend-as-a-service. Here's what each piece does, in human words.

| Term | What It Actually Means | Why You Should Care |
| --- | --- | --- |
| **Firebase** | A set of cloud services from Google that powers your app's backend (login, database, storage, etc.) | It's the invisible engine behind your app. |
| **Firebase Auth** | The login system. Handles email/password, Google Sign-In, phone verification, etc. | This is what lets users create accounts and sign in securely. |
| **Firestore** | A cloud database that stores your app's data (user profiles, settings, orders, etc.) | Think of it as a smart filing cabinet in the cloud. |
| **Cloud Storage** | A place to store files — photos, videos, documents. | When users upload a profile picture, it goes here. |
| **Cloud Functions** | Code that runs on Google's servers, triggered by events (like "when a new user signs up, send a welcome email"). | You write it once, and it runs automatically forever. |
| **Firebase Console** | The website where you manage your Firebase project — see users, read data, check errors. | Your mission control for the app's backend. |
| **google-services.json** | A config file that connects YOUR app to YOUR Firebase project. | Without it, the app can't talk to Firebase. **Keep it private.** |
| **FirebaseAuthException** | An error from the login system. Every error has a code like `user-not-found` or `wrong-password`. | The agent translates these into friendly messages for your users. |
| **Email Verification** | A security step where the user clicks a link in their email to prove they own the address. | Prevents fake accounts and improves trust. |
| **OAuth** | A secure login protocol. When you "Sign in with Google", that's OAuth. | Users don't need to create a new password — they use their existing Google account. |
| **Firebase Hosting** | A way to put a website on the internet using Firebase. | Not relevant for mobile apps, but useful if you want a landing page. |
| **Crashlytics** | A tool that catches and reports app crashes in real-time. | You'll know when something breaks — even if the user doesn't tell you. |
| **Analytics** | Tracks how users use your app — which screens they visit, how long they stay, etc. | Helps you understand what's working and what's not. |
| **Remote Config** | Lets you change app behavior without publishing an update. Like a remote control for your app. | Want to change a color or toggle a feature? Do it from the console. |

## // RAG-TAGS

`#glossary` `#firebase` `#non-tech`
