---
id: recipe-screen-001
version: 1.0.0
persona: staff_developer
tags: [recipe, screen, navigation]
---

# 📱 Recipe: Add a New Screen

## What You'll Get

A new page in your app that users can navigate to. Like adding a new room to a house.

## Steps

### Step 1: Create the File

Create a new Dart file in the right feature folder:

```
lib/features/[feature_name]/presentation/screens/[screen_name]_screen.dart
```

**Example**: `lib/features/profile/presentation/screens/profile_screen.dart`

### Step 2: Write the Screen Skeleton

```dart
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}
```

### Step 3: Wire the Navigation

From the screen you want to navigate FROM:

```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => const ProfileScreen()),
);
```

### Step 4: Make It Interactive (Optional)

If the screen needs to remember things (like form inputs), change `StatelessWidget` to `StatefulWidget`.

## 🛡️ Bulletproof Checklist

- [ ] File is in the correct feature folder
- [ ] Class name matches file name (`profile_screen.dart` → `ProfileScreen`)
- [ ] Navigation is wired from at least one other screen
- [ ] If it has controllers, they're disposed in `dispose()`
- [ ] If it has async operations, they have `mounted` checks

## // RAG-TAGS

`#recipe` `#screen` `#navigation`
