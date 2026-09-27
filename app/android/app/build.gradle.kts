plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// `cargo-ndk` packages the official Anki Rust backend as JNI libraries.

val repoRoot = rootProject.projectDir.parentFile.parentFile
val rustBridgeManifest = repoRoot.resolve("native/anki_bridge/Cargo.toml")
val rustBridgeLockfile = repoRoot.resolve("native/anki_bridge/Cargo.lock")
val rustAndroidLibraries = projectDir.resolve("src/main/jniLibs")
val buildAnkiRustBridge by tasks.registering(Exec::class) {
    group = "build"
    description = "Builds the Anki Rust bridge for Android arm64 and x86_64."
    // cargo-ndk runs `cargo metadata` before processing the manifest flag, so
    // start in the bridge crate instead of the repository root (which has no
    // workspace Cargo.toml).
    workingDir = rustBridgeManifest.parentFile
    commandLine(
        "cargo", "ndk", "-t", "arm64-v8a", "-t", "x86_64",
        "-o", rustAndroidLibraries.absolutePath,
        "build", "--release", "--locked", "--manifest-path", rustBridgeManifest.absolutePath
    )
    inputs.file(rustBridgeManifest)
    inputs.file(rustBridgeLockfile)
    inputs.dir(repoRoot.resolve("native/anki_bridge/src"))
    inputs.dir(repoRoot.resolve("third_party/anki/rslib/src"))
    outputs.dir(rustAndroidLibraries)
}

tasks.named("preBuild").configure {
    dependsOn(buildAnkiRustBridge)
}

android {
    namespace = "dev.persie0.anki_flutter"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "dev.persie0.anki_flutter"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        // Uses the version code from pubspec.yaml. When using split APKs, 1000 * ABI_VERSION
        // is added automatically by Flutter. (https://developer.android.com/studio/build/configure-apk-splits#configure-APK-versions)
        // You can force using the value of versionCode by specifying the `-P force-version-code-ignoring-abi=true`
        // flag during build.
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
