# Chronix — Precision Utility Suite (Flutter Android)

[![Flutter](https://img.shields.io/badge/Flutter-3.47.5-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.13.4-blue.svg)](https://dart.dev)
[![Platform](https://img.shields.io/badge/Platform-Android-green.svg)](https://www.android.com)
[![License](https://img.shields.io/badge/License-Proprietary-red.svg)](LICENSE)
[![Tests](https://img.shields.io/badge/Tests-31%20Passed-brightgreen.svg)](test/)

Chronix is a high-performance, offline personal helper and calculation suite built with Flutter. Migrated from React Native Expo into a native Android architecture, Chronix provides mathematical accuracy, modern Material 3 design, instant cold-start execution, and privacy-first calculation engines.

---

## Features

### Active Utility Modules
1. **Leave Salary Calculator:** Computes Earned Leave (EL) and Half Pay Leave (HPL) encashment benefits with the statutory 300-day ceiling, EL prioritization, half-pay HPL calculation, Indian currency formatting, and spelled-out words in Rupees.
2. **Gratuity Details:** Full terminal gratuity calculator adhering to Central/State rules for GPF and NPS employees. Includes statutory 5-year eligibility gates, 33-year tenure caps, GPF 3-month vs. NPS 6-month rounding rules, and the ₹25,00,000 maximum statutory ceiling.
3. **Service Calculator:** Computes career duration from Date of Joining to Retirement, with separate telemetry for total completed service and remaining tenure.
4. **Age Calculator:** Precise date difference calculator computing exact years, months, days, and total elapsed calendar days.
5. **Time Converter:** Two-way format shifting between 24-hour military time and 12-hour standard time with AM/PM pill selectors and input validation.
6. **WhatsApp Direct Chat:** Initiate direct WhatsApp chats without saving numbers to device contacts, with automatic Indian country code (+91) handling.

### Roadmap (Pipeline Modules)
- **Timezone Sync:** Multi-region temporal coordination tool.
- **Chrono Countdown:** Milestone and target event tracking.

---

## Architecture & Technology Stack

- **Stateless On-Demand Architecture:** Chronix employs `StatefulWidget` and local `setState` for reactive screen updates, paired with pure Dart calculation modules in `lib/utils/` that import zero Flutter UI packages. No heavy state management bloat (no Riverpod, Bloc, or Redux).
- **Design System ("Chronix Precision Utility System"):** Material 3 theming with full Light (`#F8FAFC`) and Dark (`#090D16`) modes, Cobalt blue accent (`#2563EB` / `#3B82F6`), slate neutrals, and tabular numbers (`FontFeature.tabularFigures()`) for jitter-free calculations.
- **Dependencies (`pubspec.yaml`):**
  - `intl: ^0.19.0`: Date formatting and Indian decimal groupings.
  - `url_launcher: ^6.3.0`: Android intent launching for WhatsApp links.

```
chronix_flutter/
├── android/                  # Android Native config, Manifest, adaptive icons & splash
├── assets/images/logo.png    # Brand mark
├── docs/                     # Full architectural specs, feature parity & release guides
│   ├── feature-parity.md     # Expo vs. Flutter feature comparison
│   ├── testing-report.md     # QA test suite execution report
│   ├── android-release.md    # Keystore signing and build instructions
│   └── play-store-checklist.md # Google Play Store submission metadata
├── lib/
│   ├── app.dart              # Root MaterialApp
│   ├── main.dart             # App entry, portrait lock, transparent system UI
│   ├── config/               # Routes and M3 themes
│   ├── data/                 # Static utility registries
│   ├── models/               # Strongly-typed domain models
│   ├── screens/              # 8 migrated screen modules
│   ├── utils/                # Pure Dart calculation engines (0 UI dependencies)
│   └── widgets/              # 11 reusable design-system UI components
└── test/                     # 31 unit, widget, and integration tests
```

---

## Getting Started & Development

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.24.0 or higher)
- [Android SDK / Platform Tools](https://developer.android.com/studio)

### Installation
```bash
# Navigate to the Flutter project
cd chronix_flutter

# Fetch dependencies
flutter pub get

# Run static analysis
flutter analyze

# Run complete test suite (31 tests)
flutter test
```

### Running on a Device
```bash
# List available Android devices
flutter devices

# Launch application on connected device
flutter run
```

---

## Build Commands

| Target | Command | Output Artifact |
|:---|:---|:---|
| **Debug APK** | `flutter build apk --debug` | `build/app/outputs/flutter-apk/app-debug.apk` |
| **Release APK** | `flutter build apk --release` | `build/app/outputs/flutter-apk/app-release.apk` |
| **App Bundle (AAB)** | `flutter build appbundle --release` | `build/app/outputs/bundle/release/app-release.aab` |

---

## Release Signing & Keystore Configuration

To sign builds with your production key:
1. Duplicate `android/key.properties.example` to `android/key.properties`.
2. Put `finbalance.keystore` in `android/`, or set `storeFile` to its location.
3. Fill in the keystore alias and passwords in `key.properties`.
4. Run `flutter build appbundle --release`.

*See [docs/android-release.md](docs/android-release.md) for full instructions.*

---

## GitHub Setup Instructions

*(Note: Per development protocol, Git has not been initialized yet. When ready to publish to your new independent GitHub repository, run the following commands:)*

```bash
cd /home/amruth/Documents/personal/Amruth/pro/flutter/chronix/chronix_flutter

# Initialize new Git repository
git init -b main

# Add all files (secrets and build artifacts are strictly protected by .gitignore)
git add .

# Create initial commit
git commit -m "feat: complete chronix flutter migration v1.0.0"

# Link to your new remote repository
git remote add origin https://github.com/<your-username>/<your-new-repo>.git

# Push to main branch
git push -u origin main
```

---

## Author & Attribution
- **Creator:** Amruth L P
- **Version:** 1.0.0 (Build 1)
- **Migration:** Completed from React Native Expo to Flutter Android
