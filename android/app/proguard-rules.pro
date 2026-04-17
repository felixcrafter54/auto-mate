# Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# flutter_local_notifications — plugin uses Gson to serialize scheduled
# notifications. R8 strips generic signatures by default, which breaks
# TypeToken and causes `Missing type parameter` at runtime.
-keep class com.dexterous.** { *; }
-dontwarn com.dexterous.**

-keepattributes Signature
-keepattributes *Annotation*
-keepattributes EnclosingMethod
-keepattributes InnerClasses

-keep class com.google.gson.reflect.TypeToken { *; }
-keep class * extends com.google.gson.reflect.TypeToken
-keep public class com.google.gson.** { *; }

# Flutter Play Store split (not used — we ship a single APK)
-dontwarn com.google.android.play.core.**

# Keep classes with @Keep annotation
-keep @androidx.annotation.Keep class * { *; }
-keepclassmembers class * {
    @androidx.annotation.Keep *;
}
