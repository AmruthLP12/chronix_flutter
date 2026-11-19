# Chronix — Design System Specification

## 1. Design Philosophy & Visual Identity

Chronix is an engineered, high-precision personal utility workspace. It is neither a generic corporate SaaS dashboard nor a gamified toy. Its visual identity reflects **tactile precision, quiet authority, and effortless utility** — drawing inspiration from luxury chronometer interfaces, precision laboratory instruments, and modernist Swiss graphic design.

### Brand Personality
- **Utilitarian Precision:** Every pixel, margin, and character serves a functional purpose. Mathematical outputs are presented with scientific clarity.
- **Calm & Focused:** Zero advertisements, zero notifications spam, zero social clutter. The user arrives with a question, receives an accurate answer instantly, and exits.
- **Tactile Materiality:** Subtle hairline borders, purposeful surface elevations, crisp ink ripples, and gentle haptic responses make interactions feel physical and grounded.
- **Visual Hierarchy Over Decoration:** No meaningless gradient blobs, no bloated drop shadows, no generic AI-templated card clutter. Structure and typography communicate hierarchy.

---

## 2. Color Palette & Theming

The color architecture is built on a high-contrast Slate and Midnight neutral foundation, paired with an authoritative Cobalt Blue primary accent and semantic status accents.

### Light Theme

| Role | Token Name | Hex Value | Semantic Purpose |
|------|------------|-----------|------------------|
| Background | `lightBackground` | `#F8FAFC` | App canvas (Slate 50) |
| Surface Primary | `lightSurface` | `#FFFFFF` | Cards, input fields, modal sheets |
| Surface Secondary | `lightSurfaceSubtle` | `#F1F5F9` | Category chips, inactive segment pills (Slate 100) |
| Border / Divider | `lightBorder` | `#E2E8F0` | Structural dividers, hairline card borders (Slate 200) |
| Border Focused | `lightBorderFocus` | `#2563EB` | Active input outline, selected borders |
| Text Primary | `lightTextPrimary` | `#0F172A` | Primary headers, values, prominent labels (Slate 900) |
| Text Secondary | `lightTextSecondary` | `#475569` | Subtitles, field labels, descriptions (Slate 600) |
| Text Muted | `lightTextMuted` | `#94A3B8` | Placeholders, inactive icons, timestamps (Slate 400) |
| Primary Accent | `lightPrimary` | `#2563EB` | Action buttons, active tabs, primary CTAs (Blue 600) |
| Primary Hover/Pressed | `lightPrimaryDark` | `#1D4ED8` | Pressed state for primary buttons (Blue 700) |
| Primary Container | `lightPrimaryContainer`| `#EFF6FF` | Highlight badges, active filter chip background (Blue 50) |

### Dark Theme

| Role | Token Name | Hex Value | Semantic Purpose |
|------|------------|-----------|------------------|
| Background | `darkBackground` | `#0B0F19` | Deep charcoal canvas |
| Surface Primary | `darkSurface` | `#161E2E` | Elevated cards, dialogs, sheet surfaces |
| Surface Secondary | `darkSurfaceSubtle` | `#1E293B` | Inactive segment pills, input backgrounds (Slate 800) |
| Border / Divider | `darkBorder` | `rgba(255, 255, 255, 0.08)` | Hairline dividers, subtle card boundaries |
| Border Focused | `darkBorderFocus` | `#60A5FA` | Active input outline, focused elements |
| Text Primary | `darkTextPrimary` | `#F8FAFC` | Primary headers, data outputs (Slate 50) |
| Text Secondary | `darkTextSecondary` | `#94A3B8` | Subtitles, field labels (Slate 400) |
| Text Muted | `darkTextMuted` | `#64748B` | Inactive icons, subtle hints (Slate 500) |
| Primary Accent | `darkPrimary` | `#3B82F6` | Action buttons, prominent interactive controls (Blue 500) |
| Primary Hover/Pressed | `darkPrimaryLight` | `#60A5FA` | Pressed state in dark mode (Blue 400) |
| Primary Container | `darkPrimaryContainer`| `rgba(59, 130, 246, 0.15)` | Active filter chips, badge backdrops |

### Semantic Accents (Both Themes)

| Role | Light Hex | Dark Hex | Purpose |
|------|-----------|----------|---------|
| Success / Verified | `#10B981` | `#34D399` | Active utility indicator, valid calculations |
| Warning / Attention | `#F59E0B` | `#FBBF24` | Threshold notices, statutory caps (₹25L gratuity limit) |
| Error / Destructive | `#EF4444` | `#F87171` | Input validation errors, invalid dates |
| Neutral Badge | `#64748B` | `#94A3B8` | "Coming Soon" badges, version pills |

---

## 3. Typography & Numerical Representation

### Type Scale

| Role | Weight | Size | Line Height | Letter Spacing | Context |
|------|--------|------|-------------|----------------|---------|
| Display Large | Bold (700) | 32sp | 38sp | -0.5sp | Large calculation totals (e.g. ₹ 25,00,000) |
| Headline Large | Bold (700) | 22sp | 28sp | -0.2sp | Screen titles, app bar brand |
| Headline Medium | SemiBold (600)| 18sp | 24sp | 0.0sp | Section card titles, modal headings |
| Title Medium | SemiBold (600)| 15sp | 20sp | 0.1sp | Utility card titles, field group titles |
| Body Large | Regular (400) | 15sp | 22sp | 0.2sp | Input text, dialog content |
| Body Medium | Regular (400) | 13sp | 18sp | 0.2sp | Utility card descriptions, helper text |
| Label Large | SemiBold (600)| 14sp | 18sp | 0.3sp | Button titles, segment options |
| Label Small | Medium (500) | 11sp | 14sp | 0.5sp | Stat card labels, category chips |
| Overline / Eyebrow | Bold (700) | 10sp | 12sp | 1.0sp | Uppercase section badges, telemetry headers |

### Numerical Precision & Tabular Figures
Financial amounts, time values, and duration counts must always be rendered with:
- `FontFeature.tabularFigures()` to prevent jitter when values update.
- Indian numbering system format for currency (`₹ 25,00,000`).
- Two-digit padded numbers for time representation (`08:05 AM`).
- Spelled-out English words for financial totals (e.g., *"Twenty-Five Lakh Rupees Only"*).

---

## 4. Spacing, Elevation & Layout Grid

### Spatial Scale (8dp Grid Base)
- `4dp`: Micro-gap, badge internal padding, icon-text gap.
- `8dp`: Compact spacing, chip gap, input vertical padding.
- `12dp`: Medium spacing, stat card gap, section item gap.
- `16dp`: Standard card internal padding, screen horizontal edge padding.
- `20dp`: Standard vertical section spacing.
- `24dp`: Modal header padding, top screen margin.
- `32dp`: Major section breaks.

### Corner Radii
- `8dp`: Badges, category filter chips, small buttons.
- `12dp`: Input fields, date picker triggers, stat cards.
- `16dp`: Primary content cards, utility cards.
- `24dp`: Modal bottom sheets, hero cards.
- `999dp`: Full pill buttons and segmented controls.

### Elevation & Borders
Instead of heavy, blurry shadows, Chronix uses **hairline structural borders** with subtle surface contrast:
- Light Mode: `1dp` solid border with `#E2E8F0`, optional `BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 2))`.
- Dark Mode: `1dp` solid border with `rgba(255, 255, 255, 0.08)`, zero blur shadow (true flat dark surface elevation).

---

## 5. Component System Specifications

### 1. App Bar (`ChronixAppBar`)
- Height: `56dp`.
- Leading: Clean back arrow icon button with minimum `48x48dp` touch target.
- Title: Centered or left-aligned bold title in `HeadlineLarge`.
- Trailing: Optional action icon button (e.g., Info icon on Home screen leading to About sheet).
- Surface: Transparent or matching canvas background; flat without drop shadow.

### 2. Primary Button (`ChronixButton`)
- Height: `52dp` (comfortable thumb reach).
- Background: `lightPrimary` / `darkPrimary`.
- Content: Centered bold label in high-contrast white text (`#FFFFFF`).
- Corner Radius: `12dp`.
- Feedback: Android ripple splash effect (`InkWell`), accompanied by subtle light haptic feedback.
- Disabled State: 50% opacity, non-interactive.

### 3. Content Card (`ChronixCard`)
- Container wrapping related fields or results.
- Padding: `16dp` or `20dp`.
- Border: `1dp` hairline border matching theme border tokens.
- Background: `lightSurface` / `darkSurface`.

### 4. Input Field (`ChronixInputField`)
- Minimum Height: `56dp`.
- Label: Distinct text above the field or floating Material 3 label.
- Background: Slightly indented surface (`lightSurfaceSubtle` / `darkSurfaceSubtle`).
- Border: 1dp border, smoothly transitioning to 2dp primary color upon focus.
- Keyboard: Custom input type per field (`TextInputType.number`, `TextInputType.phone`).
- Validation Feedback: Clear inline error message in Crimson Red below the field.

### 5. Date Field Selector (`ChronixDateField`)
- Displays: Calendar icon, field label, and currently selected date formatted as `dd MMM yyyy` (e.g. `14 Mar 2024`).
- Trailing: Subtle dropdown chevron.
- Action: Tapping opens native Android `showDatePicker()`.

### 6. Segmented Control (`ChronixSegmentedControl`)
- Pill-shaped container containing 2–3 options (e.g., `GPF` vs `NPS`, `AM` vs `PM`).
- Selected item highlighted with active pill background and primary contrast text.
- Animated smooth transition (`AnimatedContainer` / `AnimatedAlign`, 200ms ease-out).

### 7. Result Display Card (`ChronixResultCard`)
- The focal point of every calculator screen.
- Header: Eyebrow label (e.g., `TOTAL GRATUITY PAYABLE` or `TOTAL LEAVE ENCASHMENT`).
- Primary Value: Large bold display text (`DisplayLarge`, 32sp) in Primary Accent color.
- Spelled-out Value: Natural language text (e.g. *"Two Lakh Fifty Thousand Rupees Only"*).
- Breakdown Rows: Clear key-value rows with hairline divider separators.
- Quick Action: Subtle "Copy Result" button with clipboard feedback toast.

### 8. Stat Grid (`ChronixStatCard`)
- Horizontal row of 3 stat cards (e.g., Years, Months, Days).
- Value: Large bold number (`24sp`).
- Label: Small uppercase subtitle (`11sp`, muted text).
- Responsive: Equal width distribution using `Expanded`.

### 9. Utility Card (`ChronixUtilityCard`)
- Home screen launcher cards.
- Layout: Icon avatar in rounded container + Title + 2-line description + "Open" indicator chevron.
- Status Indicator: Small Emerald green dot for Active utilities; subtle muted "COMING SOON" pill for Pipeline modules.
- Active states: Tappable with ripple. Disabled pipeline cards have 60% opacity and no tap response.

---

## 6. Interaction & Motion Design

### Motion Principles
1. **Purposeful:** Animations only happen in response to user actions or state transitions (revealing calculation results). No gratuitous background animations.
2. **Snappy & Natural:** Durations between `150ms` and `250ms` with `Curves.easeOutCubic`.
3. **Respect Reduced Motion:** Query `MediaQuery.of(context).disableAnimations` and skip transitions if enabled.

### Key Interaction Micro-flows
- **Calculation Reveal:** When the user taps "Calculate", the result card appears using an implicit `AnimatedCrossFade` or `AnimatedSize` with a subtle fade-in.
- **Form Change Invalidation:** When the user modifies any input field after calculating, the previous result smoothly clears or dims to prevent misleading stale data.
- **Haptic Touch:** Android `HapticFeedback.lightImpact()` fires upon:
  - Tapping "Calculate"
  - Tapping a Segmented button option
  - Copying results to clipboard

---

## 7. Android Usability & Accessibility Specifications

- **Touch Targets:** Every interactive element has an effective touch target of at least `48x48dp` per Material 3 guidelines.
- **Contrast Ratios:**
  - Body text to background: Minimum `7:1` (exceeds WCAG AAA).
  - Secondary text to background: Minimum `4.5:1` (WCAG AA).
  - Large display headings: Minimum `3:1`.
- **TalkBack Semantics:**
  - Every icon button has an explicit `tooltip` or `Semantics(label: ...)`.
  - Result cards grouped with `Semantics(container: true)` so screen readers announce: *"Total Gratuity: 25 Lakh Rupees. Spelled out: Twenty-Five Lakh Rupees Only."*
- **Android System Navigation:**
  - Predictive Back gesture support via `PopScope`.
  - Back button pops modal sheet or returns to Home screen.
  - Soft keyboard dismissal on scroll or tap-outside using `GestureDetector(onTap: () => FocusScope.of(context).unfocus())`.
