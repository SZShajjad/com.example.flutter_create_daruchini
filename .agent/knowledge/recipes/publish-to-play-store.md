---
id: recipe-publish-001
version: 1.0.0
persona: staff_pm
tags: [recipe, publish, play-store]
---

# 🚀 Recipe: Publish to the Google Play Store

## What You'll Get

Your app live on the Google Play Store, available for anyone to download.

## Prerequisites

- A [Google Play Developer account](https://play.google.com/console) ($25 one-time fee)
- A signed release AAB (not APK — use `flutter build appbundle`)
- App icon (512×512 for store listing)
- Feature graphic (1024×500)
- At least 2 screenshots of your app
- A privacy policy URL (required by Google)

## Steps

### Step 1: Build the App Bundle

```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

### Step 2: Create Your App on Play Console

1. Go to [play.google.com/console](https://play.google.com/console)
2. Click **Create app**
3. Fill in: App name, language, app type (App vs Game), free vs paid
4. Accept the policies

### Step 3: Set Up Your Store Listing

Fill in these sections:

- **App details**: Title, short description, full description
- **Graphics**: Icon, feature graphic, screenshots
- **Categorization**: Category (e.g., Productivity), content rating
- **Contact details**: Email, website (optional), phone (optional)

### Step 4: Upload the AAB

1. Go to **Release** → **Production** → **Create new release**
2. Upload the `.aab` file
3. Write release notes (e.g., "Initial release with secure authentication")
4. Click **Review release**

### Step 5: Content Rating Questionnaire

Google requires a content rating questionnaire. Answer honestly — it takes about 5 minutes.

### Step 6: Privacy Policy

1. Create a privacy policy (use a generator if needed)
2. Host it on a website or GitHub Pages
3. Add the URL in the app settings

### Step 7: Submit for Review

Click **Start rollout to Production**. Google reviews the app (usually 1-3 days for new apps).

## 📋 Complete Checklist

- [ ] Google Play Developer account created
- [ ] App bundle built and signed
- [ ] Store listing complete (title, description, icon, screenshots)
- [ ] Content rating questionnaire filled out
- [ ] Privacy policy URL added
- [ ] Target audience and content set (if applicable)
- [ ] App submitted for review

## ⚠️ Common Rejection Reasons

- Missing privacy policy
- Screenshots that don't match the actual app
- Requesting permissions you don't explain in the description
- App crashes during Google's automated testing

## // RAG-TAGS

`#recipe` `#publish` `#play-store`
