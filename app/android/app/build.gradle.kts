import java.io.FileInputStream
import java.util.Properties

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

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    FileInputStream(keystorePropertiesFile).use { stream ->
        keystoreProperties.load(stream)
    }
}

fun releaseSigningValue(environmentName: String, propertyName: String): String? =
    System.getenv(environmentName)?.takeIf { it.isNotBlank() }
        ?: keystoreProperties.getProperty(propertyName)?.takeIf { it.isNotBlank() }

val releaseStoreFile = releaseSigningValue("ANKIFLUTTER_KEYSTORE_PATH", "storeFile")
val releaseStorePassword = releaseSigningValue(
    "ANKIFLUTTER_KEYSTORE_PASSWORD",
    "storePassword",
)
val releaseKeyAlias = releaseSigningValue("ANKIFLUTTER_KEY_ALIAS", "keyAlias")
val releaseKeyPassword = releaseSigningValue("ANKIFLUTTER_KEY_PASSWORD", "keyPassword")
val releaseSigningReady = listOf(
    releaseStoreFile,
    releaseStorePassword,
    releaseKeyAlias,
    releaseKeyPassword,
).all { !it.isNullOrBlank() }

if (
    gradle.startParameter.taskNames.any { it.contains("release", ignoreCase = true) } &&
    !releaseSigningReady
) {
    throw GradleException(
        "Android release signing is not configured. Provide android/key.properties " +
            "or ANKIFLUTTER_KEYSTORE_PATH, ANKIFLUTTER_KEYSTORE_PASSWORD, " +
            "ANKIFLUTTER_KEY_ALIAS, and ANKIFLUTTER_KEY_PASSWORD."
    )
}

android {
    namespace = "dev.persie0.anki_flutter"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    signingConfigs {
        if (releaseSigningReady) {
            create("release") {
                storeFile = file(releaseStoreFile!!)
                storePassword = releaseStorePassword
                keyAlias = releaseKeyAlias
                keyPassword = releaseKeyPassword
            }
        }
    }

    defaultConfig {
        applicationId = "dev.persie0.anki_flutter"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            if (releaseSigningReady) {
                signingConfig = signingConfigs.getByName("release")
            }
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
