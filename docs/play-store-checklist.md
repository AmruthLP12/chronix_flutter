# Chronix — Google Play Store Release & Submission Checklist

This document contains all metadata, regulatory declarations, and store asset specifications required for submitting Chronix to the Google Play Console.

---

## 1. Store Listing Metadata

### 1.1 App Title
```
Chronix - Daily Utility Suite
```
*(Character count: 29 / 30 limit)*

### 1.2 Short Description
```
Fast, offline calculators for service, gratuity, leave salary, age, and time.
```
*(Character count: 77 / 80 limit)*

### 1.3 Full Description
```
Chronix is an all-in-one personal productivity and calculation suite tailored for daily professional, temporal, and financial calculations. Designed with an ultra-clean, modern interface, Chronix provides instant answers with zero clutter, zero ads, and zero unnecessary permissions.

KEY FEATURES:

• Leave Salary Calculator:
Accurately calculate Earned Leave (EL) and Half Pay Leave (HPL) encashment benefits. Automatically adheres to the statutory 300-day encashment ceiling, prioritizes EL consumption, and computes half-pay HPL rates with full breakdown in Indian Rupees and spelled-out words.

• Gratuity Details Calculator:
Calculate terminal retirement gratuity under both GPF and NPS rules. Enforces statutory 5-year eligibility criteria, 33-year service cap, GPF 3-month vs. NPS 6-month rounding rules, and the statutory ₹25,00,000 maximum ceiling.

• Service Calculator:
Easily calculate exact employment tenure between Date of Joining and Retirement. Displays both overall career service and remaining service tenure in years, months, and days.

• Age & Interval Calculator:
Compute precise chronological differences between any two dates, with exact breakdown of years, months, days, and total elapsed calendar days.

• Time Converter:
Effortlessly shift time formats between 24-hour military notation and 12-hour standard notation with AM/PM indicators in real-time.

• WhatsApp Direct Chat:
Initiate a direct WhatsApp conversation without saving the contact number to your phonebook. Supports automatic Indian country code (+91) detection.

PRIVACY FIRST:
Chronix is 100% offline. None of your calculations, dates, or salary figures ever leave your device. No analytics, no tracking, and no third-party data sharing.
```

---

## 2. Google Play Data Safety Declaration

Based on actual codebase inspection:

| Section | Declaration | Evidence / Technical Detail |
|:---|:---:|:---|
| **Data Collection** | **No data collected** | Chronix does not collect any user data, device identifiers, or usage telemetry. |
| **Data Sharing** | **No data shared** | Zero external analytics, tracking SDKs, or cloud backends. |
| **Security Practices** | **No network storage** | All calculations run purely in device memory and are destroyed when navigating away. |
| **Account Deletion** | **Not applicable** | Chronix does not require user accounts, logins, or authentication. |

---

## 3. Permissions & Privacy Justification

- **Internet Access:** Minimal. Used solely via `url_launcher` when the user explicitly taps "Open WhatsApp" to open `https://wa.me/` via the official WhatsApp application or web fallback.
- **Package Visibility (`<queries>`):**
  - Declared for `com.whatsapp` and `com.whatsapp.w4b` in `AndroidManifest.xml` to allow checking whether WhatsApp is installed on Android 11+ devices.
- **Storage / Photos / Contacts:** **None requested**.
- **Location:** **None requested**.
- **Camera / Microphone:** **None requested**.

---

## 4. Visual Store Assets Required

| Asset | Specifications | Source in Repository | Status |
|:---|:---|:---|:---:|
| **App Icon** | 512 × 512 px, 32-bit PNG, alpha, max 1MB | `assets/images/logo.png` (512×512) | **Ready** |
| **Feature Graphic** | 1024 × 500 px, JPEG or 24-bit PNG, no alpha | Propose creating via Canva/Figma with Chronix brand mark | Planned |
| **Phone Screenshots** | Minimum 4 screenshots (1080×1920 or 1080×2400) | Capture from physical device running `app-debug.apk` | User to capture |

---

## 5. Google Play Release Steps

1. **Create App in Google Play Console:**
   - App Name: `Chronix - Daily Utility Suite`
   - Default Language: `English (India) - en-IN`
   - App or Game: `App`
   - Free or Paid: `Free`
2. **Complete Content Rating Questionnaire:**
   - Classification: Utilities / Tools
   - Rating: Everyone (No violence, no objectionable content, no user-generated content).
3. **Complete Target Audience:**
   - Age group: 18 and older (or all ages).
4. **Upload Android App Bundle:**
   - Artifact: `build/app/outputs/bundle/release/app-release.aab`
   - Signing: Enable Google Play App Signing with your upload keystore.
5. **Internal / Closed Testing Track:**
   - Release to Internal Testing track first with 1–2 test devices.
   - Verify WhatsApp launch, calculator calculations, and system dark theme transitions.
6. **Promote to Production:**
   - Once verified, promote from Internal Testing to Production release.
