# Chronix — Product Specification & Feature Inventory

## 1. Product Overview

Chronix is a focused, high-precision personal utility workspace for Android. It brings together temporal calculations, administrative employment metrics, government financial formulas, and direct messaging utilities into a single, cohesive, offline workspace.

- **Product Name:** Chronix
- **Target Platform:** Android (Flutter 3.x, Dart 3.x)
- **Creator:** Amruth L P
- **Version:** 1.0.0
- **Operational Model:** 100% Offline, Client-Side, Stateless

---

## 2. Target Audience & Core Value Proposition

Chronix is engineered primarily for government, public sector, and institutional employees in India who regularly compute or verify:
- Employment milestones and remaining tenure till superannuation.
- Gratuity entitlements under GPF (General Provident Fund) and NPS (National Pension System) rules.
- Encashment calculations for Earned Leave (EL) and Half Pay Leave (HPL).
- Precise date intervals spanning calendar years and leap years.
- Quick direct WhatsApp messaging without saving one-time contacts to personal address books.

---

## 3. Screen & Feature Inventory

### 3.1 Home Screen (`/`)
- **Purpose:** Central workspace launcher and categorized directory of all utility modules.
- **Header:** Brand title `CHRONIX`, subtitle *"Personal Helper Workspace"*, trailing info button opening the About sheet.
- **Active Section:** Header with count badge (`6 Active`).
- **Category Filter Chips:** Horizontal scrolling pill filters (`All`, `Communication`, `Calculators`, `Date & Time`, `Finance`).
- **Utility Cards:** 6 primary cards, each displaying:
  - Icon avatar in themed container.
  - Title and 2-line description.
  - Green active telemetry dot.
  - Trailing "Open Utility" chevron indicator.
  - Tappable with ripple feedback, navigating directly to the selected utility.
- **Pipeline Section:** Header with badge (`Future Growth`).
- **Upcoming Cards:** 2 placeholder cards (`Timezone Sync`, `Chrono Countdown`) with muted styling, `COMING SOON` badge, non-interactive.
- **Acceptance Criteria:**
  - Category filter immediately updates visible active utility cards without page reload.
  - "All" displays all 6 active cards.
  - Tapping an active card pushes the corresponding route onto the Navigator stack.

### 3.2 Age Calculator Screen (`/age`)
- **Purpose:** Compute exact elapsed time intervals between two dates.
- **Inputs:**
  - Start Date picker (Default: `Jan 01, 2000`).
  - End Date picker (Default: Current date).
- **Action:** `Calculate Age` CTA button.
- **Validation Rules:**
  - `startDate <= endDate`. If `startDate > endDate`, show alert: *"Start Date cannot be greater than End Date"*.
- **Calculation Formula:**
  - Calendar differences:
    $$\Delta \text{years} = \text{end.year} - \text{start.year}$$
    $$\Delta \text{months} = \text{end.month} - \text{start.month}$$
    $$\Delta \text{days} = \text{end.day} - \text{start.day}$$
  - If $\Delta \text{days} < 0$: Decrement $\Delta \text{months}$, add days of previous month.
  - If $\Delta \text{months} < 0$: Decrement $\Delta \text{years}$, add 12 to $\Delta \text{months}$.
  - Total days elapsed: $\lfloor (\text{end\_ms} - \text{start\_ms}) / 86400000 \rfloor$.
- **Outputs:**
  - 3-card stat grid: `Years`, `Months`, `Days`.
  - Detail card: `Total Duration` in days with thousands separator.
- **Acceptance Criteria:**
  - Form smoothly resets or updates when either date is modified.
  - Leap year boundaries handled accurately.

### 3.3 Time Converter Screen (`/time`)
- **Purpose:** Bidirectional conversion between standard 12-hour AM/PM cycles and 24-hour military/system time.
- **Section A: 24-Hour to 12-Hour:**
  - Inputs: Hours (0–23), Minutes (0–59, defaults to "00" if blank).
  - Validation: Integer in range `0 <= hour <= 23`. Out-of-bounds displays red *"Invalid Hour"*.
  - Formula:
    - Period: $\text{hour} \ge 12 \rightarrow \text{"PM"}$, else $\text{"AM"}$.
    - Display Hour: $\text{hour} \pmod{12}$, where $0 \rightarrow 12$.
    - Result: `h:mm A` (e.g., `14:05` $\rightarrow$ `2:05 PM`, `0:00` $\rightarrow$ `12:00 AM`).
- **Section B: 12-Hour to 24-Hour:**
  - Inputs: Hours (1–12), Minutes (0–59, defaults to "00"), Period segment toggle (`AM` / `PM`).
  - Validation: Integer in range `1 <= hour <= 12`. Out-of-bounds displays red *"Invalid Hour"*.
  - Formula:
    - If `PM` and $\text{hour} \ne 12$: $\text{hour} = \text{hour} + 12$.
    - If `AM` and $\text{hour} == 12$: $\text{hour} = 0$.
    - Result: `HH:mm` (e.g., `12:00 AM` $\rightarrow$ `00:00`, `11:45 PM` $\rightarrow$ `23:45`).
- **Acceptance Criteria:**
  - Zero-padded minute output in all conversions.
  - Midnight (12 AM $\rightarrow$ 00:00) and Noon (12 PM $\rightarrow$ 12:00) handled without error.

### 3.4 Service Calculator Screen (`/service`)
- **Purpose:** Track overall employment service duration and remaining tenure until retirement.
- **Inputs:**
  - Date of Joining picker (Default: Current date).
  - Retirement / End Date picker (Default: Current date).
- **Action:** `Calculate Service` CTA button.
- **Calculations:**
  - `Overall Service`: Time difference from Joining Date to Retirement Date (Years, Months, Days).
  - `Remaining Service`: Time difference from Today (00:00:00) to Retirement Date.
- **Display:**
  - Overall Service Card (Years, Months, Days).
  - Remaining Service Card (Years, Months, Days) — conditionally displayed if remaining tenure is distinct from overall tenure.
- **Acceptance Criteria:**
  - Handles past retirement dates gracefully (zero or negative duration handled cleanly).

### 3.5 Leave Salary Calculator Screen (`/leave_salary`)
- **Purpose:** Calculate cash encashment value for accumulated Earned Leave (EL) and Half Pay Leave (HPL) upon retirement or exit.
- **Inputs:**
  - Basic Pay (numeric, e.g. `44900`).
  - DA Percentage (numeric, e.g. `55`).
  - EL Balance (integer, e.g. `300`).
  - HPL Balance (integer, e.g. `180`).
- **Validation Rules:**
  - All four fields required, non-empty, non-negative numbers.
- **Calculation Rules:**
  - DA Amount: $\text{daAmount} = (\text{basic} \times \text{da}) / 100$.
  - Full Salary with DA: $\text{salaryWithDA} = \text{basic} + \text{daAmount}$.
  - Maximum encashment ceiling: $\text{MAX\_LEAVE\_DAYS} = 300$.
  - EL Consumption: $\text{elUsed} = \min(\text{elBalance}, 300)$.
  - Remaining encashment slots: $\text{remainingSlots} = \max(0, 300 - \text{elUsed})$.
  - HPL Consumption: $\text{hplUsed} = \min(\text{hplBalance}, \text{remainingSlots})$.
  - Total days encashed: $\text{totalDays} = \text{elUsed} + \text{hplUsed}$.
  - EL Encashment Salary: $(\text{salaryWithDA} \times \text{elUsed}) / 30$.
  - HPL Encashment Salary: Half-pay basis:
    $$\text{hplSalary} = \left(\left(\lfloor \text{basic} / 2 \rceil + \lfloor \text{daAmount} / 2 \rceil\right) \times \text{hplUsed}\right) / 30$$
  - Total Leave Salary: $\text{total} = \text{elSalary} + \text{hplSalary}$.
- **Outputs:**
  - Stat cards: `EL Used`, `HPL Used`, `Total Days`.
  - Detailed breakdown rows: DA Amount, Salary + DA, EL Leave Salary, HPL Leave Salary.
  - Total Leave Encashment card: `₹ {round(total)}` + Spelled out in words: *"X Rupees Only"*.
  - Informational notes explaining 300-day limit and EL priority.
- **Acceptance Criteria:**
  - EL prioritised first; HPL only fills remainder up to 300 days total.
  - Formula matches the exact rounding and half-pay division of the original app.

### 3.6 Gratuity Details Screen (`/gratuity`)
- **Purpose:** Calculate statutory terminal gratuity benefits under Indian Central/State Government rules.
- **Inputs:**
  - Basic Pay (numeric, e.g. `44900`).
  - DA Percentage (numeric, e.g. `55`).
  - Gratuity Category toggle: `GPF` (Old Pension) vs `NPS` (National Pension System).
  - Date of Joining (Default: `Mar 14, 2014`).
  - Relieving / Retirement Date (Default: Current date).
- **Validation Rules:**
  - Basic Pay & DA required, positive numbers.
  - Relieving Date $\ge$ Joining Date.
- **Calculation Rules:**
  - DA Amount: $\text{daAmount} = \lfloor (\text{basic} \times \text{da}) / 100 \rceil$.
  - Salary with DA: $\text{salaryWithDA} = \text{basic} + \text{daAmount}$.
  - Completed Service Months: Difference between Joining and Relieving dates (with day-borrowing).
  - Completed Years: $\lfloor \text{months} / 12 \rfloor$.
  - Completed Remaining Months: $\text{months} \pmod{12}$.
  - Minimum Qualifying Service: $5 \text{ years}$ ($60 \text{ months}$). If completed months $< 60$, gratuity units = $0$.
  - Service Years Rounding:
    - If $\text{category} == \text{"GPF"}$: If remaining months $\ge 3$, round up (+1 year).
    - If $\text{category} == \text{"NPS"}$: If remaining months $\ge 6$, round up (+1 year).
  - Maximum Qualifying Service: $\min(\text{serviceYears}, 33)$.
  - Gratuity Formula:
    - **GPF:** $\lfloor (\text{salaryWithDA} \times \text{serviceYears} \times 2) / 4 \rceil$
    - **NPS:** $\lfloor (\text{salaryWithDA} \times \text{serviceYears} \times 15) / 26 \rceil$
  - Statutory Ceiling: $\text{MAX\_GRATUITY\_AMOUNT} = ₹ 25,00,000$.
  - Final Amount: $\min(\text{gratuityBeforeLimit}, 2500000)$.
- **Outputs:**
  - Stat cards: Completed Years, Completed Months, Gratuity Units (Service Years).
  - Salary Details: Basic Pay, DA Amount, Basic + DA.
  - Gratuity Details: Service Completed, Category, Gratuity Service Years, Calculated Amount, Maximum Limit.
  - Total Gratuity Card: `₹ {amount}` + Amount in words: *"X Rupees Only"*.
  - Explanatory footnotes (GPF 3-mo rule vs NPS 6-mo rule, 33-year cap, ₹25L limit).
- **Acceptance Criteria:**
  - Service under 5 years yields ₹0 gratuity.
  - NPS and GPF produce distinct results for identical inputs due to $15/26$ vs $2/4$ formulas.
  - Capped strictly at ₹25,00,000.

### 3.7 WhatsApp Quick Chat Screen (`/whatsapp`)
- **Purpose:** Open a direct WhatsApp conversation with any phone number without adding it to personal contacts.
- **Inputs:**
  - Phone Number text field (phone keypad, e.g. `+91 98765 43210`).
- **Validation & Sanitization:**
  - Strip all non-digits: `phone.replaceAll(RegExp(r'\D'), '')`.
  - If sanitized length is 10: Prepend country code `91` $\rightarrow$ `91XXXXXXXXXX`.
  - Validation check: Must be exactly 12 digits and begin with `91`. If invalid, show alert: *"Please enter a valid 10-digit Indian phone number."*
- **Action:**
  - Launch URL `https://wa.me/{phone}` using `LaunchMode.externalApplication`.
  - Fallback error dialog if WhatsApp application or web cannot be opened.
- **Education Section:** "How It Works" 3-step guide card.
- **Acceptance Criteria:**
  - 10-digit input `9876543210` correctly opens `https://wa.me/919876543210`.
  - Invalid numbers produce clear dialog feedback.

### 3.8 About Chronix Modal Sheet (`/about`)
- **Purpose:** Application information, architectural transparency, and developer attribution.
- **Components:**
  - Brand section: Chronix logo avatar, title `CHRONIX`, version `1.0.0`.
  - Mission statement: *"A premium, high-tech temporal utility workspace providing modern calculation and format conversion tools with extreme precision."*
  - Available Modules checklist with emerald verified icons.
  - Active Pipeline preview with lock icons.
  - Credits: *"Created by Amruth L P"*.
- **Acceptance Criteria:**
  - Opens as a modern draggable bottom sheet or dialog.
  - Dismisses cleanly on tap-outside, drag-down, or back gesture.

---

## 4. Removed Legacy Components

| Component / Route | Original Location | Migration Action | Rationale |
|-------------------|-------------------|------------------|-----------|
| **Tab Two** | `app/(tabs)/two.tsx` | **Excluded** | Legacy template boilerplate containing `EditScreenInfo`. Has zero production functionality. |
| **EditScreenInfo** | `components/EditScreenInfo.tsx` | **Excluded** | Template development documentation. |
| **Themed.tsx** | `components/Themed.tsx` | **Replaced** | Replaced with idiomatic Flutter `Theme.of(context)`. |
| **ExternalLink.tsx**| `components/ExternalLink.tsx` | **Replaced** | Replaced with `url_launcher`. |
| **+html.tsx** | `app/+html.tsx` | **Excluded** | Web-only HTML wrapper. Chronix Flutter targets Android natively. |
