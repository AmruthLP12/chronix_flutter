# Chronix Flutter — System Architecture

## 1. Architectural Philosophy & Layer Boundaries

The Chronix Flutter architecture follows **pragmatic, feature-oriented layering**. Rather than introducing speculative enterprise abstractions (such as Clean Architecture interactors, repository patterns for non-existent databases, or global service locators), Chronix strictly separates:

1. **Configuration Layer (`lib/config/`):** Design tokens, theme data, route definitions.
2. **Data & Models Layer (`lib/data/`, `lib/models/`):** Immutable metadata, calculation output records, static catalog definitions.
3. **Pure Business Logic Layer (`lib/utils/`):** Completely decoupled, deterministic Dart algorithms (zero Flutter UI imports) for date arithmetic, time format conversion, gratuity formulas, and leave encashment calculations.
4. **Presentation Layer (`lib/widgets/`, `lib/screens/`):** Declarative, theme-driven Flutter widgets that observe user input, pass values to pure utilities, and present calculated states.

```
┌─────────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                       │
│  ┌───────────────────────────────┐  ┌────────────────────┐  │
│  │     Screen Controllers        │  │   Design System    │  │
│  │ (Home, Gratuity, Age, etc.)   │  │ (ChronixCard, etc.)│  │
│  └───────────────┬───────────────┘  └─────────┬──────────┘  │
│                  │                            │             │
│                  ▼                            │             │
│  ┌───────────────────────────────┐            │             │
│  │      Pure Business Logic      │            │             │
│  │ (lib/utils/*_calculators.dart)│            │             │
│  └───────────────┬───────────────┘            │             │
│                  │                            │             │
│                  ▼                            ▼             │
│  ┌───────────────────────────────┐  ┌────────────────────┐  │
│  │        Models & Records       │  │    Theme Tokens    │  │
│  │(GratuityResult, Utility, etc.)│  │ (AppColors, Theme) │  │
│  └───────────────────────────────┘  └────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
```

---

## 2. Directory Structure

```
chronix_flutter/
├── android/                             # Native Android configuration
├── assets/
│   └── images/
│       └── logo.png                     # Vector / PNG branding
├── lib/
│   ├── main.dart                        # Initialization & platform configuration
│   ├── app.dart                         # MaterialApp, theme binding, route table
│   ├── config/
│   │   ├── routes.dart                  # Route constants & generator
│   │   └── theme/
│   │       ├── app_colors.dart          # Light/dark color tokens
│   │       ├── app_text_styles.dart     # Typography scale & tabular figures
│   │       └── app_theme.dart           # ThemeData configurations
│   ├── data/
│   │   └── utilities_data.dart          # Static utility catalog (active + pipeline)
│   ├── models/
│   │   ├── utility.dart                 # Utility metadata class
│   │   ├── age_result.dart              # Age duration record
│   │   ├── time_result.dart             # Converted time format record
│   │   ├── service_result.dart          # Service duration record
│   │   ├── leave_salary_result.dart     # Leave encashment breakdown record
│   │   └── gratuity_result.dart         # Gratuity computation record
│   ├── screens/
│   │   ├── home/
│   │   │   └── home_screen.dart         # Workspace launcher & filter chips
│   │   ├── whatsapp/
│   │   │   └── whatsapp_screen.dart     # Direct phone chat launcher
│   │   ├── age/
│   │   │   └── age_screen.dart          # Date interval calculator
│   │   ├── time/
│   │   │   └── time_screen.dart         # 12h <-> 24h converter
│   │   ├── service/
│   │   │   └── service_screen.dart      # Tenure & retirement tracker
│   │   ├── leave_salary/
│   │   │   └── leave_salary_screen.dart # EL & HPL leave encashment
│   │   ├── gratuity/
│   │   │   └── gratuity_screen.dart     # GPF & NPS gratuity calculator
│   │   └── about/
│   │       └── about_sheet.dart         # About modal bottom sheet
│   ├── widgets/
│   │   ├── chronix_app_bar.dart         # Top app bar
│   │   ├── chronix_card.dart            # Hairline border container
│   │   ├── chronix_button.dart          # Primary 52dp tactile button
│   │   ├── chronix_input_field.dart     # Form input field with validation
│   │   ├── chronix_numeric_input.dart   # Centered numeric input box
│   │   ├── chronix_date_field.dart      # Native date picker trigger
│   │   ├── chronix_segmented_control.dart # Animated pill segment toggle
│   │   ├── chronix_stat_card.dart       # Telemetry metric cards & grid
│   │   ├── chronix_result_card.dart     # Primary output card with copy action
│   │   ├── chronix_section_header.dart  # Section header with badge
│   │   └── chronix_utility_card.dart    # Home launcher item card
│   └── utils/
│       ├── date_calculators.dart        # Pure date interval algorithms
│       ├── financial_calculators.dart   # Gratuity and leave encashment math
│       ├── time_calculators.dart        # 12/24 hour time parsing and shifts
│       ├── formatters.dart              # Indian numbering (lakhs/crores) & dates
│       └── number_to_words.dart         # English words currency generator
├── test/
│   ├── utils/                           # Unit tests for pure calculators
│   │   ├── date_calculators_test.dart
│   │   ├── financial_calculators_test.dart
│   │   ├── time_calculators_test.dart
│   │   └── number_to_words_test.dart
│   └── widgets/                         # Component and screen tests
│       ├── chronix_card_test.dart
│       ├── chronix_button_test.dart
│       └── ...
└── docs/                                # Project documentation
    ├── prod.md
    ├── architecture.md
    ├── essential-architecture.md
    ├── design-system.md
    ├── migration-plan.md
    ├── agent.md
    └── CHANGELOG.md
```

---

## 3. Evaluated Trade-offs & Decisions

### State Management: `StatefulWidget` + `setState` (Selected)
- **Alternatives Considered:** Riverpod, Bloc, Provider, GetX.
- **Decision:** Use standard Flutter `StatefulWidget` with `setState`.
- **Justification:**
  - In Chronix, **zero state is shared across screens**.
  - No user session, no authentication token, no cart, no global settings.
  - Adding Riverpod or Bloc introduces boilerplates, extra generated files, provider containers, and dependency overhead with zero architectural benefit for self-contained calculators.
  - Screen states are purely ephemeral: text field values, date picker selections, and nullable result models.

### Navigation: Flutter Built-in `Navigator` (Selected)
- **Alternatives Considered:** `go_router`, `auto_route`, `beamer`.
- **Decision:** Use Flutter's built-in `Navigator` with named routes.
- **Justification:**
  - Chronix is an Android-only mobile application with a flat screen hierarchy (1 Home hub + 6 calculator stack screens + 1 modal sheet).
  - It does not need deep linking, web browser URL bar synchronization, query parameter parsing, or nested stateful tab shells.
  - Standard `Navigator.pushNamed()` with `MaterialPageRoute` delivers native Android predictive back (`PopScope`), slide transitions, and minimal complexity.

### Persistence: Stateless / Zero Database (Selected)
- **Alternatives Considered:** Drift, SQLite, Hive, SharedPreferences.
- **Decision:** Zero persistence layer.
- **Justification:**
  - Chronix is a real-time calculation and conversion tool.
  - In the original Expo application, no data was persisted to disk. Calculations are executed on demand and discarded when navigating away.
  - Adding a database would violate YAGNI and KISS.

### Number to Words: Custom Pure Dart Implementation (Selected)
- **Alternatives Considered:** External pub package (`number_to_words_english`).
- **Decision:** Implement a self-contained pure Dart conversion utility in `lib/utils/number_to_words.dart`.
- **Justification:**
  - The algorithm is small, deterministic, and requires no external network or file dependencies.
  - It specifically supports Indian currency formatting conventions (*"Rupees Only"*).

---

## 4. Dependencies & Justification

| Package | Version | Justification |
|---------|---------|---------------|
| `flutter` | SDK | Core UI framework |
| `intl` | `^0.19.0` | High-precision Indian locale currency formatting (`en_IN` lakhs/crores) and date formatting (`dd MMM yyyy`) |
| `url_launcher` | `^6.3.0` | Android intent resolution for direct `https://wa.me/{phone}` WhatsApp links |
| `flutter_lints` | `^6.0.0` (dev) | Official Flutter code quality and style enforcement |
| `flutter_test` | SDK (dev) | Unit, widget, and golden test runner |

---

## 5. Error Handling & Invalidation Strategy

1. **Form-level Validation:**
   - Every input field validates on submit and displays inline feedback.
   - Guard clauses prevent mathematical evaluation on empty, negative, or invalid inputs.
2. **Dynamic Invalidation:**
   - Modifying any input field immediately sets the screen's result variable to `null`.
   - Prevents stale calculation numbers from remaining visible when inputs are altered.
3. **External Action Safety:**
   - `url_launcher` calls are wrapped in `canLaunchUrl` checks and try-catch blocks to present clean Android alerts if WhatsApp is not installed.
4. **Deterministic Math:**
   - All arithmetic uses integer operations (`Math.round`, integer division) matching statutory financial rounding rules.
