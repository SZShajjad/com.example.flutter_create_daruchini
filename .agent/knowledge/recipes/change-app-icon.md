---
id: recipe-icon-001
version: 1.0.0
persona: staff_designer
tags: [recipe, icon, branding]
---

# 🎨 Recipe: Change the App Icon

## What You'll Get

A custom icon for your app on the Android home screen and Play Store listing.

## What You Need

- A square image (1024×1024 pixels recommended)
- PNG format, no transparency for the foreground
- The image should look good when cropped into a circle (Android adaptive icon)

## Steps

### Step 1: Prepare Your Icon

Make sure your icon is:

- **1024×1024 px** or larger
- **Square** (not rectangular)
- Important content in the **center 66%** (Android crops the edges into a circle)

### Step 2: Use the flutter_launcher_icons Package

The agent adds this to `pubspec.yaml`:

```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.14.3

flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icon/app_icon.png"
  adaptive_icon_background: "#1A237E"   # Your brand color
  adaptive_icon_foreground: "assets/icon/app_icon_foreground.png"
```

### Step 3: Place the Icon File

Put your icon image at:

```
assets/icon/app_icon.png
```

### Step 4: Generate the Icons

The agent runs:

```bash
dart run flutter_launcher_icons
```

This automatically generates all the different sizes Android and iOS need.

### Step 5: Verify

Build and install the app. The new icon should appear on the home screen.

## ⚠️ Common Mistakes

- Icon looks blurry → Use a higher resolution source image
- Icon is cropped weirdly → Keep important content in the center
- Old icon still showing → Uninstall the app first, then reinstall

## // RAG-TAGS

`#recipe` `#icon` `#branding`
