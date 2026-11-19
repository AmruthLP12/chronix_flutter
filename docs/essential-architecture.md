# Chronix Flutter — Essential Architecture & Constraints

## 1. Core Architectural Pillars

### Pillar I: Absolute Statelessness
- Chronix is an on-demand calculation tool.
- Zero local database (no SQLite, no Drift, no Hive).
- Zero file persistence (no SharedPreferences, no local JSON caches).
- Every calculation begins with user input, computes immediately in memory, presents results, and discards all data upon navigating away.

### Pillar II: Built-In State Management Only
- Every screen is completely self-contained.
- Use standard Flutter `StatefulWidget` with `setState`.
- **Strictly Prohibited:** Riverpod, Bloc, Provider, Redux, MobX, GetX.
- Zero cross-screen state sharing. Zero global state containers.

### Pillar III: Standard Navigation & Android Integrity
- Built-in `Navigator` with named routes.
- **Strictly Prohibited:** `go_router`, `auto_route`, `beamer`.
- Full Android predictive back support via `PopScope`.
- Stack depth never exceeds 2 levels (`Home` $\rightarrow$ `Utility Screen`).
- The About screen is presented as a modal bottom sheet (`showModalBottomSheet`), preserving the single-screen home foundation.

### Pillar IV: Pure Dart Business Logic Isolation
- Core mathematical, temporal, and financial algorithms live in `lib/utils/` as **pure Dart functions**.
- These files import zero Flutter UI packages (`package:flutter/material.dart` is prohibited in `lib/utils/`).
- Decoupled algorithms allow 100% deterministic, lightning-fast unit tests without widget harnesses.

---

## 2. Core Application Boundaries & Data Flow

```
┌────────────────────────────────────────────────────────┐
│                      Chronix App                       │
│                                                        │
│  ┌───────────────┐       ┌──────────────────────────┐  │
│  │  Home Screen  │──────→│     Utility Screens      │  │
│  │ (Catalog Hub) │       │ (Self-contained forms)   │  │
│  └───────┬───────┘       └────────────┬─────────────┘  │
│          │                            │                │
│          │                            │ (Pure calls)   │
│          ▼                            ▼                │
│  ┌───────────────┐       ┌──────────────────────────┐  │
│  │  About Modal  │       │     Pure Dart Utils      │  │
│  │ (Information) │       │ (Calculators/Formatters) │  │
│  └───────────────┘       └──────────────────────────┘  │
│                                                        │
│  No shared state   •   No disk storage   •   No API    │
└────────────────────────────────────────────────────────┘
```

### Form Invalidation Cycle
1. User enters data into `TextEditingController` or selects a date.
2. User taps `Calculate`.
3. Validation executes:
   - If invalid: Error shown via inline field error text or alert dialog. Execution terminates.
4. Pure calculator function executes synchronously.
5. `setState()` assigns the calculated record model to a nullable state variable (`_result = calculatedOutput`).
6. UI renders the result card smoothly.
7. **Invalidation Guard:** If user changes any input or selects a new date, `_result` is immediately reset to `null` to prevent misleading, stale data from remaining on screen.

---

## 3. State Ownership & Scoping

| State Entity | Owner Class | Scope | Lifetime |
|--------------|-------------|-------|----------|
| Active Category Filter | `_HomeScreenState` | Home screen local | Discarded on app termination |
| Form Input Text | `_UtilityScreenState` | Screen local | Discarded on screen pop |
| Date Picker Selection | `_UtilityScreenState` | Screen local | Discarded on screen pop |
| Calculation Result Model | `_UtilityScreenState` | Screen local | Discarded on screen pop or input change |
| System Brightness / Theme | `MaterialApp` | Framework | Follows Android system brightness |

---

## 4. Error Handling & Edge-Case Rules

1. **Validation at Trust Boundaries:**
   - Empty input fields: Highlight field with inline error message.
   - Non-numeric input: Keyboard is restricted to numeric/phone type; parsing uses `tryParse` with guard clause.
   - Invalid date sequence (`startDate > endDate`): Prevent calculation and display clear alert dialog.
   - Invalid Indian phone numbers: Restrict to 10 digits (auto-prefix 91) or 12 digits starting with 91.
2. **Deterministic Calculations:**
   - Calculations must never throw unhandled runtime exceptions. Formulas use integer rounding (`round()`, `floor()`) matching Indian statutory accounting rules.
3. **Intent Safety:**
   - WhatsApp URL launch wrapped in `canLaunchUrl()` check. If opening fails, show user-facing dialog explaining WhatsApp is unavailable.

---

## 5. Anti-Overengineering Invariants (Ponytail & Clean Code)

1. **No Speculative Architecture:** Do not write interfaces or abstractions for a single implementation.
2. **No Dependency Bloat:** Only `intl` and `url_launcher` are approved. Every other capability must use the Flutter SDK or standard Dart libraries.
3. **No Code Generators:** No `build_runner`, `freezed`, or `json_serializable`. Plain Dart classes and records only.
4. **No Layer Multipliers:** Do not create `repositories`, `services`, `interactors`, `DTOs`, or `entities` for stateless calculations.
5. **No Dead Code:** No commented-out blocks, no unused imports, zero linter warnings.
