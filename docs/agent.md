# Chronix Flutter — Agent Development Instructions & Skill Policy

## 1. Project Rules & Boundaries

### Source of Truth
- The original Expo project at `/home/amruth/Documents/personal/Amruth/pro/flutter/chronix/chronix` is the single source of truth for functionality, calculations, and business logic.
- The original project is **strictly READ-ONLY** — never modify, delete, rename, or generate files inside `chronix/`.
- All development happens exclusively inside `/home/amruth/Documents/personal/Amruth/pro/flutter/chronix/chronix_flutter/`.
- Refer to `docs/prod.md` for the complete feature inventory and specifications.

### Git and Repository Isolation
- **Do not initialize a Git repository** inside `chronix_flutter/` during this migration phase.
- **Do not push anything to GitHub** or configure remotes. The user will initialize and connect the repository independently.

### Documentation Maintenance
- Update `docs/CHANGELOG.md` with every meaningful change or milestone completion.
- Keep `docs/prod.md`, `docs/architecture.md`, `docs/essential-architecture.md`, `docs/design-system.md`, and `docs/migration-plan.md` synchronized.
- Never fabricate features, screens, or requirements that do not exist in the original app.

---

## 2. Skill Usage Matrix & Conflict Resolution

### Precedence Hierarchy
When different skills, guidelines, or templates provide overlapping or contradictory recommendations, resolve them strictly in this order:
1. **Explicit Chronix Product Requirements:** Offline-first, stateless calculations, zero backend, zero database, Android-only.
2. **Project Architecture & Agent Instructions:** `architecture.md`, `essential-architecture.md`, `design-system.md`.
3. **Flutter-Specific Best Practices:** `flutter-expert` and official Flutter stack guidelines.
4. **Specialist Skills:** `ui-ux-pro-max`, `frontend-design`, `clean-code`, `ponytail`.
5. **General Development Conventions:** `senior-architect`, `gravitas`.

### Skill Usage Matrix

| Skill Name | Purpose | Applies to Chronix? | When Used | Overlapping / Conflicting Instructions | Resolution / Precedence |
|------------|---------|---------------------|-----------|----------------------------------------|-------------------------|
| `flutter-architecture` | Flutter app structure & conventions | **Yes (Selective)** | Folder structure, linting, code hygiene | Suggests Riverpod state management and references gaming app templates | **Precedence: Chronix rules.** Reject Riverpod and gaming templates. Adopt standard Flutter `StatefulWidget` + `setState`, clean folder separation, and static analysis. |
| `flutter-expert` | Deep Flutter 3 & Dart 3 mastery | **Yes (Full)** | Widget composition, Dart 3 features, accessibility, performance | Recommends multiple state libs (Riverpod, Bloc, etc.) | **Precedence: Chronix rules.** Adopt Dart 3 null safety, records, patterns, Material 3, `const` widgets, and `PopScope`. Ignore complex state libs. |
| `senior-architect` | High-level system design | **Yes (Pragmatic)** | Architectural boundaries, trade-off analysis | Includes backend, Docker, K8s, cloud DBs | **Precedence: Chronix rules.** Discard all backend/cloud infra. Retain clean boundary separation and deterministic data flow. |
| `clean-code` | Concise, direct coding standards | **Yes (Full)** | Writing all Dart code and widgets | Rules on max lines and guard clauses | Follow strictly: SRP, DRY, KISS, YAGNI, functions < 20 lines, guard clauses, self-documenting code. |
| `frontend-design` | Distinctive, non-templated UI design | **Yes (Full)** | UI layout, typography, visual hierarchy | Warns against generic AI card kits & gradient tells | Follow strictly: Build an intentional, instrument-grade visual identity. Avoid AI tells (tracked-out all-caps everywhere, grey card kits). |
| `ui-design` | Interface & interaction design | **Yes (Selective)** | Form validation, touch targets, contrast | Templated for "Clash Command" gaming timers | Discard gaming specifics (villages, builders). Adopt touch target rules (≥48x48dp), semantic status colors, and inline validation. |
| `ui-ux-pro-max` | Design system intelligence | **Yes (Full)** | Colors, type scale, touch targets, a11y | Includes web/React/Next.js stacks | Use only `flutter` stack guidance and mobile guidelines. Follow WCAG contrast, tabular numbers, and Material 3 rules. |
| `brainstorming` | Collaborative design exploration | **Yes (Selective)** | Requirements refinement | Recommends git worktrees & open dialogue | Adopt YAGNI and exploring alternative UI approaches. |
| `product-specification` | Specifying behavior & acceptance criteria | **Yes (Selective)** | Defining screen behaviors and DoD | Mentions game tracking timers | Discard gaming context. Apply definition-of-done and acceptance criteria for all 6 active calculators. |
| `testing` | Multi-layer test strategies | **Yes (Full)** | Unit testing calculation engines and widgets | Mentions database and notification tests | Focus on pure Dart unit tests for calculations and widget tests for forms/cards. Skip database tests. |
| `file-organizer` | Project directory hygiene | **Yes (Contextual)** | Keeping `lib/`, `test/`, and `docs/` clean | File moves / renaming | Use for keeping project file organization tidy. |
| `gravitas` | Engineering reliability runtime | **Yes (Full)** | Implementation, verification, evidence tracking | Multi-agent delegation ceremony | Apply "Report what happened, not what you intended." Verify with real test/build evidence. Avoid multi-agent overhead. |
| `ponytail` | Lazy senior dev mode (KISS / YAGNI) | **Yes (Full)** | Implementing features with minimal clean diffs | Suggests skipping tests for trivial changes | Follow: the smallest complete change that fully works. Standard library over packages. Non-trivial calculations must have tests. |
| `offline-data` | Drift / SQLite persistence | **NO (Excluded)** | Not applicable | Recommends Drift database and migrations | **Chronix is completely stateless.** Adding a database violates KISS and product requirements. Excluded. |
| `android-notifications`| Scheduled local alarms / notifications | **NO (Deferred)** | Not applicable in Phase 2 | Recommends notification services | Chronix has zero active notification features. Pipeline modules are placeholders. Excluded in Phase 2. |
| `android-cicd` | GitHub Actions Google Play CI/CD | **NO (Deferred)** | Future deployment only | Automated Play Store releases | User explicitly requested no Git or GitHub in this phase. Documented for future use only. |
| `senior-fullstack` / `seo-optimizer` | Web/backend fullstack & SEO | **NO (Excluded)** | Not applicable | Web/backend capabilities | Not applicable to an offline Android app. Excluded. |

---

## 3. Coding Conventions & Best Practices

### Dart 3 Conventions
- Use full null safety. Never use the `!` force-unwrap operator unless provably safe.
- Prefer `final` for all variables that do not mutate after initialization.
- Use Dart 3 patterns, records, and switch expressions where they simplify logic.
- Place trailing commas on all multi-line widget constructors for clean `dart format` output.
- Name constants in `lowerCamelCase` (e.g. `const defaultPadding = 16.0;`).
- Keep private methods and properties prefixed with `_`.
- Clean up unused imports immediately — zero warnings allowed in `flutter analyze`.

### Flutter Widget Rules
- **One public widget per file.** File name must match the class name in `snake_case.dart`.
- Prefer `StatelessWidget` whenever possible. Use `StatefulWidget` only when local state (`TextEditingController`, focus, or calculation state) is required.
- Always use `const` constructors for static widget trees to eliminate unnecessary rebuilds.
- Always access theme styling via `Theme.of(context)` — **never hardcode hex colors in widget build methods**.
- Always call `dispose()` on controllers (`TextEditingController`, `AnimationController`, `FocusNode`).
- Keep `build()` methods clean and under 50 lines by extracting sub-widgets.

### Business Logic & Utilities
- **Separation of Concerns:** Keep core calculation algorithms in pure Dart files under `lib/utils/` without importing `package:flutter/material.dart`.
- Pure functions make unit testing trivial, fast, and completely deterministic.
- Validation logic should be cleanly separated and reusable.

---

## 4. Prohibited Shortcuts & Hard Constraints

1. **No database or persistence:** Do not add Drift, SQLite, Hive, or SharedPreferences.
2. **No state management packages:** Do not add Riverpod, Bloc, Provider, GetX, or MobX.
3. **No routing packages:** Do not add `go_router` or `auto_route`. Built-in `Navigator` with named routes is required.
4. **No code generators:** Do not add `build_runner`, `freezed`, or `json_serializable`.
5. **No backend or network calls:** No HTTP clients, Firebase, or Supabase.
6. **No modification of the Expo project:** The `chronix/` directory is strictly read-only.
7. **No Git initialization:** Do not run `git init` or push to any remote.
8. **No skipping validation:** Every validation rule from the original app must be enforced.
9. **No placeholder implementations:** Do not create dummy or fake screens. Implement the real feature or wait for its stage.
10. **No untested calculations:** Every mathematical formula must have passing unit tests before being considered done.

---

## 5. Verification & Definition of Done

Before considering any task or stage complete, the following verification commands must run and pass:

```bash
# 1. Format check
dart format --output=none --set-exit-if-changed lib test

# 2. Static analysis
flutter analyze

# 3. Unit and widget test execution
flutter test

# 4. Build verification
flutter build apk --debug
```

Every claim of completion must rest on verifiable command output. If something was not checked, state explicitly that it was not checked.
