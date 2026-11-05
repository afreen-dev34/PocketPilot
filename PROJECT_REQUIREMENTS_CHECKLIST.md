# Official Project Specification Mapping

| PDF requirement | PocketPilot implementation / evidence |
|---|---|
| Team of 2–3 | Suggested three-person ownership is documented in README; replace placeholders with real names. |
| Flutter 3.35+, Dart null safety, Android | Flutter/Dart project declaration and Android build instructions. |
| Provider + ChangeNotifier | `lib/providers/expense_provider.dart`; app-wide provider in `lib/main.dart`. |
| Models, services, screens, widgets folders | Folders and files are created under `lib/`. |
| Four screens minimum | Transactions list, transaction detail, add-expense form and insights; dashboard is an additional screen. |
| Real data | Expenses are created by the user and saved locally in SharedPreferences. No hard-coded sample list is used. |
| Loading, error/retry, empty and data states | `ExpenseListBody` and `ExpenseProvider.loadState`. |
| Validated form | Required title, minimum title length, positive numeric amount, amount upper bound, category selection and note length limit. |
| Detail view | Tapping a transaction opens its detail screen. |
| Shared state | Provider state is read by dashboard, transactions, detail actions and insights. |
| Theme and app identity | Material 3 theme from one seed colour; app name PocketPilot. Custom launcher icon source is included at `assets/pocketpilot_icon.png`; generate Android launcher assets with `dart run flutter_launcher_icons`. |
| Robustness | Scrollable layouts, input limits, save/delete error feedback, retry state and confirmation before deletion. Must still be verified on device for rapid taps, rotation and no crashes. |
| GitHub commits from every member | Collaboration instructions included; team must create repository and commit from each member's account. |
| Release APK on physical phone | Build and device-test instructions included; APK is not prebuilt in this archive. |
| At least one passing widget test | `test/expense_tile_test.dart`; run `flutter test` and retain passing output. |
| Submission README, 3 screenshots and defect log | README and defect log templates included. Capture and add at least three real screenshots after running the app. |
| Five-minute live demo | Timed demonstration plan included in README. |
