# PocketPilot — Smart Student Expense Tracker

A Flutter Android application that helps students record everyday spending, review transactions and understand category-wise expenses. PocketPilot uses locally stored user-created data, so it works without an internet connection and keeps records after the app is closed and reopened.

## Project brief

- **Approved topic:** Expense tracker
- **Framework:** Flutter stable 3.35 or newer
- **Language:** Dart with null safety
- **State management:** Provider (`ChangeNotifier`)
- **Persistence:** `shared_preferences` (JSON-encoded expense records)
- **Date formatting:** `intl`
- **Platform:** Android

## Features

1. Dashboard with current-month spending and recent activity.
2. Transaction list with loading, error/retry, empty and data states.
3. Transaction detail view with category, date, note and delete confirmation.
4. Validated add-expense form (title, positive numeric amount, category, date and optional note).
5. Insights screen with total spending and category-wise breakdown.
6. Pull-to-refresh, local persistence, Material 3 theme and responsive scrollable layouts.

## Screenshots for final submission

The official submission requires at least three screenshots. After running the app on an emulator or phone, capture genuine screenshots and add them under `screenshots/` (for example `dashboard.png`, `transactions.png` and `insights.png`). Then embed them here before submitting:

```markdown
![Dashboard](screenshots/dashboard.png)
![Transactions](screenshots/transactions.png)
![Insights](screenshots/insights.png)
```

Do not submit placeholder or mock screenshots as evidence of a running application.

## Folder structure

```text
lib/
  main.dart
  models/expense.dart
  providers/expense_provider.dart
  services/expense_storage.dart
  screens/
    app_shell.dart
    dashboard_screen.dart
    transactions_screen.dart
    expense_detail_screen.dart
    expense_form_screen.dart
    analytics_screen.dart
  widgets/
    expense_tile.dart
    expense_list_body.dart
test/
  expense_model_test.dart
  expense_tile_test.dart
```

## Requirements

- Flutter SDK stable 3.35 or newer
- Dart SDK compatible with the Flutter installation
- Android Studio with Flutter and Dart plugins
- JDK 17 and Android SDK
- Android emulator or physical Android phone

## Run locally

1. Extract the project ZIP.
2. Open a terminal in the `pocketpilot` folder.
3. Run:

   ```bash
   flutter doctor
   flutter pub get
   flutter analyze
   flutter test
   flutter run
   ```

4. Run `SETUP_ANDROID_PLATFORM.bat` once on Windows to generate the Android platform folder and PocketPilot launcher icon. (Alternatively run `flutter create --platforms=android .`, `flutter pub get` and `dart run flutter_launcher_icons`.)
5. Connect an Android phone with USB debugging enabled, or start an Android emulator.

## Build release APK

```bash
flutter build apk --release
```

The APK is generated at `build/app/outputs/flutter-apk/app-release.apk`. Install it on a physical Android phone and test adding, viewing, deleting and retaining expenses after restart.

## GitHub collaboration

Create one public repository named `pocketpilot`. Each member should clone the repository, work on an assigned feature branch, commit meaningful changes regularly, and open a pull request for review. Do not upload only one final commit. Do not commit API keys, signing credentials, local build output or private data.

Suggested initial commands:

```bash
git init
git add .
git commit -m "Initial PocketPilot Flutter project"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/pocketpilot.git
git push -u origin main
```

### Suggested three-member ownership (replace with actual names)

| Member | Owned work |
|---|---|
| Member 1 — Name | Dashboard, transaction list and detail screen |
| Member 2 — Name | Add-expense form, validation and user flow |
| Member 3 — Name | Provider, local storage, insights, tests and integration |

Every member should make regular commits and be able to explain their own code and the overall app flow.

## Testing checklist

- [ ] `flutter analyze` completes without errors.
- [ ] `flutter test` passes, including the widget test.
- [ ] Fresh install displays the empty state.
- [ ] Adding an expense with blank title is rejected with a clear message.
- [ ] Blank, non-numeric, zero and negative amounts are rejected.
- [ ] Valid expense appears in the list and detail screen.
- [ ] Expense remains after closing and reopening the app.
- [ ] Delete confirmation removes the selected expense.
- [ ] Very long title/note is constrained by field limits.
- [ ] App works with airplane mode enabled (local-first design).
- [ ] Rapid taps do not create duplicate submissions.
- [ ] Layout remains usable in portrait and landscape.
- [ ] Release APK installs and runs on a physical Android phone.

## Known scope and limitations

- This first version is a single-device, offline-first tracker; it has no account login, cloud sync, bank integration or recurring payments.
- `shared_preferences` is suitable for this small student-project dataset, not sensitive financial records or large databases.
- The APK must be built and physically tested on a machine with Flutter and Android build tools installed.

## Five-minute demonstration plan

| Time | Demonstration |
|---|---|
| 0:00–0:30 | Introduce PocketPilot, its student audience and the problem it solves. |
| 0:30–1:15 | Show dashboard and empty state (use a fresh app install/profile). |
| 1:15–2:00 | Submit an invalid form entry and show validation messages. |
| 2:00–3:30 | Add a valid expense, open its details, show transaction list and insights. |
| 3:30–4:30 | Explain one technical challenge (shared Provider state and persistent local storage) and how the team handled it. Every member speaks. |
| 4:30–5:00 | Show public GitHub repository, commit history from all members and release APK on the phone. |

Slides do not replace the working application.
