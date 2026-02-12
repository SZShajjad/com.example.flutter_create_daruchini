# Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Firebase Keep Rules
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# Prevent shrinking of critical auth classes
-keep class com.daruchini.auth.** { *; }

# Fix for Missing class com.google.android.play.core
-dontwarn com.google.android.play.core.**
-keep class com.google.android.play.core.** { *; }
