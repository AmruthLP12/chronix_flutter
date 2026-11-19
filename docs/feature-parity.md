# Chronix — Feature Parity Audit & Verification Matrix

This document provides a comprehensive screen-by-screen, interaction-by-interaction, and calculation-by-calculation audit comparing the original React Native Expo application (`chronix`) against the native Flutter application (`chronix_flutter`).

**Audit Date:** 2026-11-18  
**Verification Method:** Automated unit tests, widget tests, screen integration tests, and static analysis.

---

## 1. Feature Parity Status Legend
- **VERIFIED:** Implemented and validated via automated unit, widget, or integration tests with full mathematical and behavioral parity.
- **DEPRECATED (BY SPEC):** Intentionally retired starter/template code with zero product value.
- **PIPELINE:** Intentionally presented as a "Coming Soon" roadmap preview for future releases.

---

## 2. Feature Inventory Matrix

| Screen / Module | Original Expo Source | Flutter Implementation | User Interaction / Logic | Status | Notes |
|:---|:---|:---|:---|:---:|:---|
| **Home Utility Hub** | `app/(tabs)/index.tsx` | `lib/screens/home/home_screen.dart` | • Categorized utility list<br>• Interactive category filters (`All`, `Communication`, `Calculators`, `Date & Time`, `Finance`)<br>• Navigation to active modules<br>• Preview cards for upcoming modules<br>• Header trigger for About sheet | **VERIFIED** | Replaces old static Expo cards with interactive category filtering, live status indicators, and ripple feedback. |
| **WhatsApp Direct** | `app/whatsapp.tsx`<br>`components/WhatsApp.tsx` | `lib/screens/whatsapp/whatsapp_screen.dart` | • Phone number text input<br>• Auto-prefix Indian country code (`91`) if 10 digits<br>• 12-digit Indian number validation<br>• Native external launch of `https://wa.me/{phone}`<br>• "How it works" 3-step guide | **VERIFIED** | Configured with modern Android 11+ `<queries>` in `AndroidManifest.xml` for `com.whatsapp` and `com.whatsapp.w4b`. |
| **Age Calculator** | `app/age.tsx`<br>`components/AgeCalculator.tsx` | `lib/screens/age/age_screen.dart`<br>`lib/utils/date_calculators.dart` | • Start and End date pickers<br>• Chronological validation (`startDate <= endDate`)<br>• Calendar interval computation (`Years`, `Months`, `Days`) with month-borrowing<br>• Total elapsed calendar days calculation | **VERIFIED** | Handles leap years, same-day intervals (0 duration), and displays formatted tabular figures. |
| **Time Converter** | `app/time.tsx`<br>`components/TimeConverter.tsx` | `lib/screens/time/time_screen.dart`<br>`lib/utils/time_calculators.dart` | • 24h to 12h format shift with 0–23h & 0–59m validation<br>• 12h to 24h format shift with 1–12h validation and AM/PM segmented pill selector<br>• Real-time error messages for out-of-range inputs | **VERIFIED** | Formats output with 2-digit minute padding (`HH:mm`), standard 12h representation, and 24h military representation. |
| **Service Calculator** | `app/service.tsx`<br>`components/ServiceCalculator.tsx` | `lib/screens/service/service_screen.dart`<br>`lib/utils/date_calculators.dart` | • Date of Joining and Retirement/End Date pickers<br>• Overall employment tenure (`Years`, `Months`, `Days`)<br>• Remaining employment tenure calculated relative to today<br>• Negative difference guard (returns 0s if retirement is in past) | **VERIFIED** | Displays dual telemetry result cards with custom icons and tabular stat cards. |
| **Salary Leave Calculator** | `app/leave-salary.tsx`<br>`components/SalaryLeaveCalculator.tsx` | `lib/screens/leave_salary/leave_salary_screen.dart`<br>`lib/utils/financial_calculators.dart` | • Inputs for Basic Pay, DA %, EL Balance, HPL Balance<br>• Non-negative and numeric input validation<br>• Statutory 300-day encashment cap<br>• Priority consumption: EL used first, HPL used for remainder<br>• HPL paid at half pay rate: `((round(basic/2) + round(da/2)) * hplDays) / 30`<br>• Currency breakdown & spelled-out words in Rupees | **VERIFIED** | Tabular Indian rupee currency formatting (`₹ 4,12,500`), spelled-out words in Rupees, and one-tap clipboard copy. |
| **Gratuity Details** | `app/gratuity.tsx`<br>`components/GratuityDetails.tsx` | `lib/screens/gratuity/gratuity_screen.dart`<br>`lib/utils/financial_calculators.dart` | • Inputs: Basic Pay, DA %, GPF/NPS segment selector, Date of Joining, Relieving Date<br>• 5-year minimum eligibility gate (< 5 yrs -> 0 payout)<br>• 33-year service tenure cap<br>• GPF 3-month rounding rule: remainder >= 3 months rounds up 1 year<br>• NPS 6-month rounding rule: remainder >= 6 months rounds up 1 year<br>• GPF formula: `((Basic + DA) * Years * 2) / 4`<br>• NPS formula: `((Basic + DA) * Years * 15) / 26`<br>• Statutory ₹25,00,000 maximum ceiling<br>• Comprehensive breakdown & spelled-out words | **VERIFIED** | Full statutory parity with Central/State government rules, copy-to-clipboard, and explanatory notes. |
| **About Modal** | N/A (Migrated from Expo starter boilerplate) | `lib/screens/about/about_sheet.dart` | • Draggable bottom modal sheet<br>• Brand avatar with Chronix logo<br>• Version badge (1.0.0)<br>• Purpose & mission statement<br>• Interactive checklist of available modules<br>• Developer attribution | **VERIFIED** | Launched from the info icon on the Home screen header. Dismissible via drag or tap. |
| **Template "Tab Two"** | `app/(tabs)/two.tsx` | *Deprecated* | • Default Expo starter template screen with static placeholder text | **DEPRECATED** | Replaced with a unified single-screen utility hub with category filters. |
| **Timezone Sync** | N/A (Concept roadmap) | `lib/data/utilities_data.dart` | • Upcoming pipeline card on Home screen with "COMING SOON" badge | **PIPELINE** | Visible on Home Hub with category tag "Date & Time". |
| **Chrono Countdown** | N/A (Concept roadmap) | `lib/data/utilities_data.dart` | • Upcoming pipeline card on Home screen with "COMING SOON" badge | **PIPELINE** | Visible on Home Hub with category tag "Calculators". |

---

## 3. Mathematical Formula Parity Verification

### 3.1 Leave Salary Encashment
- **Formula:**
  $$\text{DA Amount} = \frac{\text{Basic} \times \text{DA \%}}{100}$$
  $$\text{SalaryWithDA} = \text{Basic} + \text{DA Amount}$$
  $$\text{EL Days Used} = \min(\text{EL Balance}, 300)$$
  $$\text{HPL Days Used} = \min(\text{HPL Balance}, \max(0, 300 - \text{EL Days Used}))$$
  $$\text{EL Leave Salary} = \frac{\text{SalaryWithDA} \times \text{EL Days Used}}{30}$$
  $$\text{HPL Leave Salary} = \frac{(\text{round}(\frac{\text{Basic}}{2}) + \text{round}(\frac{\text{DA Amount}}{2})) \times \text{HPL Days Used}}{30}$$
  $$\text{Total Leave Salary} = \text{round}(\text{EL Leave Salary} + \text{HPL Leave Salary})$$
- **Verification Status:** Matched to the exact rupee against Expo implementation. Tested across 4 distinct edge cases (EL only, HPL only, capped at 300, 0 pay).

### 3.2 Gratuity Calculation
- **Eligibility:** If completed service $< 60$ months, gratuity is ₹0.
- **Service Rounding:**
  - GPF: If completed months remainder $\ge 3$, service years $+1$.
  - NPS: If completed months remainder $\ge 6$, service years $+1$.
  - Service years capped at $33$ years maximum.
- **Gross Calculation:**
  - GPF: $\text{round}\left(\frac{\text{SalaryWithDA} \times \text{Years} \times 2}{4}\right)$
  - NPS: $\text{round}\left(\frac{\text{SalaryWithDA} \times \text{Years} \times 15}{26}\right)$
- **Ceiling:** $\min(\text{Gross}, 25,00,000)$.
- **Verification Status:** Matched to the exact rupee against Expo implementation. Tested across GPF, NPS, 5-year gate, 33-year cap, and ₹25 Lakh maximum ceiling.
