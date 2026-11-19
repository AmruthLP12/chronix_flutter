# Chronix — Android Release Engineering & Signing Guide

This guide details the release configuration, keystore management, versioning, and build commands for Chronix.

---

## 1. Application Identification & Build Configuration

- **Application ID:** `com.amruthlp12.chronix_flutter`  
  *(Note: Original Expo package was `com.amruthlp12.chronix`. If replacing an existing app on Google Play, update `applicationId = "com.amruthlp12.chronix"` in `android/app/build.gradle.kts` prior to final upload)*.
- **Android Namespace:** `com.amruthlp12.chronix_flutter`
- **Application Name:** Chronix
- **Version:** `1.0.0`
- **Build Number:** `1`
- **Minimum Android SDK:** 21 (Android 5.0 Lollipop - 99.8% market coverage)
- **Target Android SDK:** 34+ (Android 14)
- **Compile Android SDK:** 36 (Android 15 preview/latest Flutter SDK)

---

## 2. Release Signing Procedure

### 2.1 Generating a Production Keystore
To sign Chronix for Google Play Store upload, generate a secure Java Keystore using `keytool`:

```bash
keytool -genkey -v -keystore ~/chronix-upload-keystore.jks \
        -keyalg RSA -keysize 2048 -validity 10000 \
        -alias chronix_release_key
```

### 2.2 Configuring `key.properties`
1. Duplicate `android/key.properties.example` to `android/key.properties`:
   ```bash
   cp android/key.properties.example android/key.properties
   ```
2. Populate the properties:
   ```properties
   storePassword=YOUR_ACTUAL_STORE_PASSWORD
   keyPassword=YOUR_ACTUAL_KEY_PASSWORD
   keyAlias=chronix_release_key
   storeFile=/home/username/chronix-upload-keystore.jks
   ```
> [!CAUTION]
> Never commit `key.properties` or `*.jks` / `*.keystore` files to version control. Both are strictly blocked by `.gitignore`.

### 2.3 Automatic Fallback
In `android/app/build.gradle.kts`:
- If `key.properties` **exists**: The build pipeline signs artifacts with the production release key.
- If `key.properties` **does not exist**: The release build automatically signs using the local debug certificate so that release compilation (`flutter build apk --release` and `flutter build appbundle --release`) succeeds immediately without errors.

---

## 3. Verified Build Commands

| Target | Command | Verified Output Path | Verified Size |
|:---|:---|:---|:---:|
| **Debug APK** | `flutter build apk --debug` | `build/app/outputs/flutter-apk/app-debug.apk` | ~58 MB |
| **Release APK** | `flutter build apk --release` | `build/app/outputs/flutter-apk/app-release.apk` | 50.9 MB |
| **Release App Bundle (AAB)** | `flutter build appbundle --release` | `build/app/outputs/bundle/release/app-release.aab` | 49.9 MB |

---

## 4. Version Management Protocol

Chronix adheres to Semantic Versioning (`MAJOR.MINOR.PATCH+BUILD`):
- Format in `pubspec.yaml`:
  ```yaml
  version: 1.0.0+1
  ```
- **When to increment `PATCH` (e.g., 1.0.1+2):**
  - Bug fixes, mathematical edge case corrections, minor UI/spacing adjustments.
- **When to increment `MINOR` (e.g., 1.1.0+3):**
  - Activating a roadmap module ("Timezone Sync" or "Chrono Countdown") or adding a new utility.
- **When to increment `MAJOR` (e.g., 2.0.0+4):**
  - Major architectural evolution (e.g., multi-platform desktop/web migration).
- **Build Number Rule:** Every build uploaded to Google Play Console must strictly increment the build number integer (`+1`, `+2`, `+3`, etc.).
