import java.io.FileInputStream
import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()
var releaseSigningConfigured = false

if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))

    val requiredProperties = listOf("storePassword", "keyPassword", "keyAlias", "storeFile")
    val missingProperties = requiredProperties.filter {
        keystoreProperties.getProperty(it)?.isNotBlank() != true
    }
    if (missingProperties.isNotEmpty()) {
        throw GradleException(
            "Invalid key.properties: missing ${missingProperties.joinToString(", ")}"
        )
    }

    val configuredStoreFile = rootProject.file(
        keystoreProperties.getProperty("storeFile")
    )
    if (!configuredStoreFile.exists()) {
        throw GradleException(
            "Release keystore not found: ${configuredStoreFile.absolutePath}"
        )
    }
    releaseSigningConfigured = true
} else {
    releaseSigningConfigured = false
}

android {
    namespace = "com.amruthlp12.chronix_flutter"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.amruthlp12.chronix_flutter"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            if (releaseSigningConfigured) {
                keyAlias = keystoreProperties.getProperty("keyAlias")
                keyPassword = keystoreProperties.getProperty("keyPassword")
                storeFile = rootProject.file(keystoreProperties.getProperty("storeFile"))
                storePassword = keystoreProperties.getProperty("storePassword")
            }
        }
    }

    buildTypes {
        release {
            signingConfig = if (releaseSigningConfigured) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
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
