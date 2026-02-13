---
id: kotlin-daemon-connection-failure
title: Fix Kotlin Daemon Connection Failure (Gradle Build Hang)
type: fix
version: 1.0.0
last_updated: 2026-02-13
tags: [build, gradle, kotlin, performance, jvm]
related: [gradle-configuration, android-build-system]
complexity: high
---

# 🔴 Problem: Kotlin Daemon Connection Failure

During Flutter builds (`flutter build apk`), the process hangs or fails with:

```
e: Failed connecting to the daemon in 4 retries
e: Daemon compilation failed: Could not connect to Kotlin compile daemon
java.lang.RuntimeException: Could not connect to Kotlin compile daemon
```

This typically occurs when the Gradle daemon has insufficient memory to spawn or communicate with the Kotlin compiler daemon, especially with **Kotlin 2.x** and **AGP 8.x**.

# 🟢 Solution: Increase JVM Heap Size

The default 2048MB heap is often insufficient for modern Android builds. Increasing to **4096MB** resolves the connection stability issues.

## 1. Edit `android/gradle.properties`

```properties
# OLD (Insufficient)
# org.gradle.jvmargs=-Xmx2048m -Dfile.encoding=UTF-8

# NEW (Recommended)
org.gradle.jvmargs=-Xmx4096m -Dfile.encoding=UTF-8

# Kotlin Daemon Specifics (Optional but Recommended)
kotlin.daemon.jvmargs=-Xmx2048m
```

## 2. Enable Parallel Builds & Caching

To further stabilize the build and improve performance:

```properties
org.gradle.daemon=true
org.gradle.parallel=true
org.gradle.caching=true
```

## 3. Restart Gradle Daemons

After applying changes, kill existing daemons to force a restart with new settings:

```powershell
# Windows
.\gradlew --stop
```

# Verification

Run a clean build:

```bash
flutter clean
flutter build apk --debug
```

Expected result: The build should complete successfully (even if warnings persist, the artifact is created).
