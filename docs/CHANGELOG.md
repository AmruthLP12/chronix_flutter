# Changelog

All notable changes to the Chronix Flutter project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/).

---

## [1.0.0] — 2026-11-18

### Phase 5: UI/UX Polish & Interaction Refinement
- **Screen Transitions & Animations:** Added native Android `ZoomPageTransitionsBuilder` across light and dark themes. Integrated `AnimatedCrossFade` transitions for all dynamic calculation results across Age, Time, Service, Leave Salary, and Gratuity screens.
- **Micro-Interactions & Feedback:** Enforced tactile haptic feedback (`HapticFeedback.lightImpact()` and `selectionClick()`) on button presses, segmented controls, category filter chips, and clipboard copy operations.
- **Keyboard Handling & Responsiveness:** Enforced `keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag` and wrapped interactive screen viewports in `GestureDetector` to dismiss the software keyboard on outside taps. Added safe area responsive bottom insets (`MediaQuery.paddingOf(context).bottom + 24`) to eliminate gesture bar clipping on modern Android devices.
- **Empty States:** Added visual empty state fallback on the Home screen when category filters contain zero matches.

### Phase 6: Comprehensive QA, Feature Parity & Performance
- **Feature Parity Audit:** Conducted exhaustive side-by-side audit of all original Expo components vs. Flutter screens. Published `docs/feature-parity.md` verifying 100% mathematical and behavioral parity.
- **Automated Test Suite Expansion:**
  - Expanded automated test suite from 24 to **31 passing tests**:
    - 18 pure business logic unit tests (`test/utils/`) covering leap years, inverted dates, 0 pay, EL/HPL caps, 33-year gratuity caps, ₹25 Lakh limits, and time conversions.
    - 4 reusable widget tests (`test/widgets/`).
    - 8 screen integration tests (`test/screens_test.dart`) including new tests for Service Calculator, WhatsApp input validation, and Home category filtering.
    - 1 app shell mounting test (`test/widget_test.dart`).
- **Static Analysis & Linting:** Ran `flutter analyze` with **0 issues found**.
- **Performance Optimization:** Tree-shook unused font icons down by 99.6% (1.64 MB -> 6.3 KB) during release compilation.

### Phase 7: Android Release Engineering & Play Store Preparation
- **Android Adaptive Launcher Icons:** Generated full density adaptive launcher icon assets (`mdpi`, `hdpi`, `xhdpi`, `xxhdpi`, `xxxhdpi`) from original branding into `android/app/src/main/res/` with `mipmap-anydpi-v26/ic_launcher.xml` and `@color/ic_launcher_background`.
- **Branded Native Splash Screen:** Configured light (`#F8FAFC`) and dark (`#090D16`) launch backgrounds in `res/drawable/` and `res/drawable-night/` with centered Chronix splash logo.
- **Release Build Pipeline:** Configured `android/app/build.gradle.kts` with dynamic `key.properties` loading and fallback to debug signing for testing. Provided `android/key.properties.example` and added keystore ignores to `.gitignore`.
- **Verified Build Outputs:** Successfully compiled:
  - Debug APK: `build/app/outputs/flutter-apk/app-debug.apk`
  - Release APK: `build/app/outputs/flutter-apk/app-release.apk` (50.9 MB)
  - Release Android App Bundle: `build/app/outputs/bundle/release/app-release.aab` (49.9 MB)
- **Documentation & Deliverables:**
  - Published comprehensive `README.md` with features, architecture, and Git initialization commands.
  - Published `docs/feature-parity.md`.
  - Published `docs/testing-report.md`.
  - Published `docs/android-release.md`.
  - Published `docs/play-store-checklist.md` with complete Play Store descriptions, content rating, and Data Safety declarations (100% offline, zero data collected).

---

## [0.0.3] — 2026-11-18

### Phase 3 & Phase 4: Foundation, Design System & Complete Screen Migration
- Implemented clean on-demand stateless architecture and Material 3 design system.
- Migrated all 6 core utilities, Home Hub, and About modal sheet.

---

## [0.0.2] — 2026-11-18

### Phase 2: Skill Integration, Architecture Review & Migration Blueprint
- Audited 16 specialized skills, resolved template conflicts, finalized architecture and design system.

---

## [0.0.1] — 2026-11-18

### Phase 1: Initial Migration Preparation
- Original React Native Expo analysis and initial project creation.
