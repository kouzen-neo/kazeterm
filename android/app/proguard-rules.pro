# Keep the complete app JNI interface, including console methods used only by instrumentation.
-keepclasseswithmembers,includedescriptorclasses class com.kazeterm.* {
    native <methods>;
}

# The native terminal pump looks these up by name and JVM descriptor (hosts/android/src/vt.rs).
-keepclassmembers class com.kazeterm.VtSession {
    public void on*(...);
}
