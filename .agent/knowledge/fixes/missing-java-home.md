---
id: fix-missing-java-home
version: 1.0.0
persona: developer
tags: [flutter, gradle, java-home, setup, environment]
title: Fix Gradle Build Failure: JAVA_HOME Not Set
summary: Resolve "ERROR: JAVA_HOME is not set" when running Gradle manually.
---

# 🔧 Fix: Gradle Build Failure - JAVA_HOME Not Set

## Problem

When running `./gradlew` commands directly (e.g., to debug build failures), you encounter:

`ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.`

This happens because the Gradle wrapper (`gradlew`) relies on the system's Java environment, whereas `flutter build` commands often use a bundled JDK that isn't fully exposed to the shell.

## Solution

### 1. Identify Java Location

Run `flutter doctor -v` to see where Flutter's bundled Java is located. Or locate your Android Studio JDK.

Example path: `C:\Program Files\Android\Android Studio\jbr`

### 2. Set JAVA_HOME Temporary (PowerShell)

```powershell
$env:JAVA_HOME = "C:\Program Files\Android\Android Studio\jbr"
```

### 3. Run Gradle Wrapper

Now `./gradlew assembleDebug` should work.

### Alternatives

- **Use `flutter build`:** Whenever possible, prefer `flutter build apk` (possibly with `-v` for verbose output) as it sets up the environment correctly for you.
- **Set Permanent variable:** Add `JAVA_HOME` to your system environment variables.
