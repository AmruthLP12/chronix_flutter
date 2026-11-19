# Chronix — Migration Roadmap & Execution Plan

This roadmap defines the sequential, verifiable stages for migrating Chronix from React Native Expo to Flutter Android. Each stage specifies required tasks, explicit dependencies, concrete deliverables, acceptance criteria, and testing requirements.

---

## Stage 1: Foundation, Design Tokens & Core Assets

### Objective
Establish the core design token system, light/dark themes, mathematical & text utilities, and visual assets without building application screens.

### Tasks
1. Import `logo.png` from original `chronix/assets/images/logo.png` into `chronix_flutter/assets/images/`.
2. Configure `pubspec.yaml` with required dependencies:
   - `intl: ^0.19.0` (for locale-aware currency and date formatting)
   - `url_launcher: ^6.3.0` (for WhatsApp deep linking)
3. Implement `lib/config/theme/app_colors.dart` defining all light, dark, and semantic tokens from `design-system.md`.
4. Implement `lib/config/theme/app_text_styles.dart` with complete Material 3 typography scale and tabular figure support.
5. Implement `lib/config/theme/app_theme.dart` exporting complete `lightTheme` and `darkTheme` `ThemeData` definitions.
6. Implement `lib/utils/number_to_words.dart` — pure Dart utility converting integer currency amounts to English words (with Indian numbering context and "Rupees Only" suffix).
7. Implement `lib/utils/date_calculators.dart` — pure Dart calendar difference calculations (years, months, days, total days, month-borrowing logic).
8. Implement `lib/utils/financial_calculators.dart` — pure Dart gratuity and leave salary calculation formulas.
9. Implement comprehensive unit tests for all mathematical and formatting utilities.

### Dependencies
- Clean Flutter environment (Flutter 3.47+, Dart 3.13+).

### Expected Deliverables
- `assets/images/logo.png` registered in `pubspec.yaml`.
- `lib/config/theme/` (colors, text styles, ThemeData).
- `lib/utils/` (number-to-words, date difference, gratuity, leave salary).
- `test/utils/` unit test suites.

### Acceptance Criteria
- `flutter test test/utils/` passes with 100% test pass rate covering:
  - Leap year date differences and month-end borrowing.
  - Gratuity formulas (GPF vs NPS, 3-month vs 6-month crediting rules, ₹25 Lakh cap, under-5-year zero rule).
  - Leave salary calculations (EL priority, 300-day cap, half-pay HPL formula).
  - Number-to-words conversion across diverse ranges (0, 44900, 250000, 2500000).
- `flutter analyze` reports zero warnings and zero errors.

---

## Stage 2: Core Application Architecture & Navigation

### Objective
Construct the core application shell, named routing table, predictive back support, and static data catalogs.

### Tasks
1. Define utility data model in `lib/models/utility.dart` (title, description, route, icon, category, isActive, isComingSoon).
2. Populate `lib/data/utilities_data.dart` with all 6 active utilities and 2 upcoming pipeline modules.
3. Configure `lib/config/routes.dart` defining all named route constants:
   - `/` (Home)
   - `/whatsapp`
   - `/age`
   - `/time`
   - `/service`
   - `/leave_salary`
   - `/gratuity`
   - `/about`
4. Setup `lib/app.dart` with `MaterialApp`:
   - Configured with `lightTheme` and `darkTheme`.
   - `themeMode: ThemeMode.system`.
   - Clean route generator with standard Android slide/fade page transitions.
   - Global keyboard unfocus listener.
5. Update `lib/main.dart` with proper system overlay styles (`SystemChrome.setSystemUIOverlayStyle`) and portrait orientation lock (`SystemChrome.setPreferredOrientations`).

### Dependencies
- Stage 1 completed and verified.

### Expected Deliverables
- `lib/models/utility.dart`
- `lib/data/utilities_data.dart`
- `lib/config/routes.dart`
- `lib/app.dart`
- `lib/main.dart`

### Acceptance Criteria
- App compiles and runs without error on Android.
- Theme responds dynamically to Android system dark/light mode toggle.
- Route table resolves cleanly; unknown routes navigate gracefully to a fallback screen.

---

## Stage 3: Shared Reusable UI Components

### Objective
Construct the 11 design-system-compliant reusable widgets in `lib/widgets/` before building any individual screens.

### Tasks
1. `ChronixAppBar`: Top app bar with back button, brand typography, and optional action buttons.
2. `ChronixCard`: Container card with 16dp radius, hairline border, and theme-aware surface coloring.
3. `ChronixButton`: 52dp height tactile CTA button with light haptics and ripple.
4. `ChronixInputField`: Standard labeled input field with clear action, keyboard type support, and error state.
5. `ChronixNumericInput`: Centered numerical input box with min/max length (used for time conversion).
6. `ChronixDateField`: Tappable date picker selector with calendar icon and `showDatePicker` integration.
7. `ChronixSegmentedControl`: Animated sliding pill toggle for GPF/NPS and AM/PM selection.
8. `ChronixStatCard` & `ChronixStatGrid`: Metric presentation widget with large tabular numbers and labels.
9. `ChronixResultCard`: Output container featuring bold totals, spelled-out currency text, and copy button.
10. `ChronixSectionHeader`: Section title with optional status pill badge.
11. `ChronixUtilityCard`: Home screen launcher card with icon avatar, category badge, and tap interaction.

### Dependencies
- Stage 1 (Tokens) and Stage 2 (Models & Routes) completed.

### Expected Deliverables
- 11 dedicated widget files in `lib/widgets/`.
- Widget test suite in `test/widgets/` verifying rendering, dark mode adaptation, and user tap interactions.

### Acceptance Criteria
- Every widget satisfies touch target size (≥ 48x48dp) and contrast standards (≥ 4.5:1).
- `flutter test test/widgets/` passes with zero failures.
- No hardcoded colors or styles in any widget file.

---

## Stage 4: Core Utility Implementations — Group A (Quick & Temporal)

### Objective
Implement and verify the first three self-contained utilities: WhatsApp, Age Calculator, and Time Converter.

### Tasks
1. **WhatsApp Screen (`lib/screens/whatsapp/whatsapp_screen.dart`):**
   - Clean Indian phone number input with numeric/phone keypad.
   - Validation logic (10-digit check, auto 91 prefixing, 12-digit total check).
   - `url_launcher` intent handling for `https://wa.me/{phone}` with friendly error fallback if WhatsApp is not installed.
   - "How it works" guidance section.
2. **Age Calculator Screen (`lib/screens/age/age_screen.dart`):**
   - Start Date and End Date pickers (defaults: Jan 1, 2000 and today).
   - Calculate action with validation (`startDate <= endDate`).
   - Stat grid output (Years, Months, Days) + Total Days card.
   - Smooth reveal animation on calculation.
3. **Time Converter Screen (`lib/screens/time/time_screen.dart`):**
   - 24h to 12h conversion card (Hour 0-23, Minute 0-59 inputs -> 12h AM/PM output).
   - 12h to 24h conversion card (Hour 1-12, Minute 0-59 inputs, AM/PM toggle -> 24h output).
   - Real-time or button-triggered calculation with invalid range detection.

### Dependencies
- Stage 3 completed (reusable widgets ready).

### Expected Deliverables
- `lib/screens/whatsapp/whatsapp_screen.dart`
- `lib/screens/age/age_screen.dart`
- `lib/screens/time/time_screen.dart`
- Screen-level widget tests and validation tests.

### Acceptance Criteria
- All 3 screens produce mathematical and behavioral outputs identical to original Expo app.
- Phone number formatting and launching verified against Android intent standards.
- Form inputs automatically dismiss keyboard on background tap or scroll.

---

## Stage 5: Core Utility Implementations — Group B (Administrative & Financial)

### Objective
Implement the complex administrative calculation utilities: Service Calculator, Leave Salary Calculator, and Gratuity Details.

### Tasks
1. **Service Calculator Screen (`lib/screens/service/service_screen.dart`):**
   - Date of Joining and Retirement/End Date selectors.
   - Dual telemetry calculation: Overall Service and Remaining Service tenure.
   - Edge case handling: When remaining service equals overall service, or when retirement is in the past.
2. **Leave Salary Calculator Screen (`lib/screens/leave_salary/leave_salary_screen.dart`):**
   - Basic Pay, DA %, EL Balance, and HPL Balance inputs with numeric keyboards.
   - Form validation ensuring all fields are filled with positive values.
   - Computation breakdown: DA amount, Salary with DA, EL Leave Salary, HPL Leave Salary (half-pay).
   - Max 300 days leave rule (EL consumed first, remainder to HPL).
   - Total Leave Encashment display with currency formatting and amount in words.
3. **Gratuity Details Screen (`lib/screens/gratuity/gratuity_screen.dart`):**
   - Basic Pay, DA %, GPF/NPS category selector, Joining Date, Relieving Date.
   - Full service months computation with day-borrowing logic.
   - Service years rounding rules (GPF ≥ 3 months remainder -> +1 yr; NPS ≥ 6 months -> +1 yr).
   - Minimum 5-year eligibility gate and maximum 33-year service cap.
   - Formula application: GPF `(Basic+DA)*years*2/4`; NPS `(Basic+DA)*years*15/26`.
   - Statutory ₹25,00,000 maximum ceiling enforcement.
   - Complete breakdown card + total gratuity payable card with amount in words.

### Dependencies
- Stage 3 and Stage 1 utilities completed.

### Expected Deliverables
- `lib/screens/service/service_screen.dart`
- `lib/screens/leave_salary/leave_salary_screen.dart`
- `lib/screens/gratuity/gratuity_screen.dart`
- Full calculation verification test suites.

### Acceptance Criteria
- Gratuity and Leave Salary mathematical results match the original Expo implementation down to the exact rupee for identical inputs.
- All boundary conditions tested: exactly 5 years, 4 years 11 months, 33 years, salary exceeding limit.

---

## Stage 6: Main Home Screen, Category Filtering & About Sheet

### Objective
Implement the central workspace hub (Home screen), dynamic category filtering, pipeline placeholder modules, and the About Chronix modal sheet.

### Tasks
1. **Home Screen (`lib/screens/home/home_screen.dart`):**
   - Header with app title, personal workspace subtitle, and About info action icon.
   - Horizontal category filter chips: "All", "Communication", "Calculators", "Date & Time", "Finance".
   - Active utility cards list dynamically filtered by selected category chip.
   - "Pipeline Modules" section displaying "Timezone Sync" and "Chrono Countdown" with "COMING SOON" badges.
   - Smooth card press navigation to target utility screens.
2. **About Chronix Modal (`lib/screens/about/about_sheet.dart`):**
   - Implemented as a modern draggable modal bottom sheet or modal route.
   - Brand logo avatar, version badge ("1.0.0"), mission statement.
   - Checklist directory of all available active utilities with status indicators.
   - Pipeline preview section.
   - Creator attribution ("Created by Amruth L P").

### Dependencies
- Stages 4 and 5 completed (all utility routes active).

### Expected Deliverables
- `lib/screens/home/home_screen.dart`
- `lib/screens/about/about_sheet.dart`
- Home screen navigation and filtering tests.

### Acceptance Criteria
- Category chip selection instantly and correctly filters the displayed utility cards.
- Tapping any utility card cleanly pushes the corresponding screen onto the Navigator stack.
- About sheet opens smoothly and dismisses via swipe-down or close action.

---

## Stage 7: Interaction Polish, Micro-animations & Android Refinements

### Objective
Polish touch feedback, transitions, accessibility semantics, and Android-specific platform conventions.

### Tasks
1. Implement light haptic feedback (`HapticFeedback.lightImpact()`) on button clicks, segment toggles, and calculation triggers.
2. Implement clipboard copy functionality on result cards with feedback toast / snackbar.
3. Integrate `PopScope` across all screens for Android 14+ predictive back gesture support.
4. Add implicit animated reveals (`AnimatedCrossFade` / `AnimatedSize`, 200ms) for calculation result containers.
5. Review and annotate all interactive elements with explicit `Semantics` (labels, buttons, tooltips).
6. Verify keyboard avoidance behavior across all input screens on compact and standard Android viewports.

### Dependencies
- Stages 1–6 completed.

### Expected Deliverables
- Polished interactions across all screens.
- Clipboard copy utilities.
- Enhanced semantic annotations.

### Acceptance Criteria
- No UI overflows when keyboard is displayed on any screen.
- Back gestures pop screens predictably without accidental app exit.
- Accessibility audit passes with all interactive controls labeled for TalkBack.

---

## Stage 8: Feature Parity & Rigorous Regression Verification

### Objective
Execute a comprehensive side-by-side audit against the original Expo codebase to verify 100% feature and mathematical parity.

### Tasks
1. Execute full unit test suite: `flutter test test/utils/`.
2. Execute full widget test suite: `flutter test test/widgets/`.
3. Side-by-side calculation parity check:
   - Run identical input vectors on both original Expo app and Flutter app across all 6 calculators.
   - Verify matching outputs for: Age, Time conversion, Service duration, Leave Salary, Gratuity.
4. Dark / Light theme visual audit across every screen.
5. Run static analysis: `flutter analyze` ensuring 0 issues.
6. Format all code: `dart format --set-exit-if-changed lib test`.

### Dependencies
- Stages 1–7 completed.

### Expected Deliverables
- Comprehensive verification test log.
- Zero analysis issues.
- Documented feature parity audit report.

### Acceptance Criteria
- 100% test pass rate across all suites.
- Strict mathematical equality between Expo and Flutter calculation engines.
- Zero lint or static analysis warnings.

---

## Stage 9: Android Release Readiness & Build Verification

### Objective
Configure Android build settings, splash screen, launcher icons, and verify debug and release builds.

### Tasks
1. Configure Android application label, package name, and permissions in `android/app/src/main/AndroidManifest.xml`.
2. Verify Android launcher icon setup.
3. Verify `build.gradle` configurations (minSdk, targetSdk, compileSdk).
4. Build and verify Debug APK: `flutter build apk --debug`.
5. Build and verify Release APK: `flutter build apk --release`.
6. Inspect generated APK size and startup characteristics.
7. Prepare final release notes in `docs/CHANGELOG.md`.

### Dependencies
- Stage 8 verification passed.

### Expected Deliverables
- Verified release-ready Android APK.
- Updated documentation.

### Acceptance Criteria
- `flutter build apk --release` completes successfully with zero errors.
- Resulting APK installs and launches cleanly on Android emulator/device.
