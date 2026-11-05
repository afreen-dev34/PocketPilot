# PocketPilot – Defect Log

This document records defects and observations identified during project testing. Only defects that have been actually reproduced are marked as open or fixed.

| ID    | Defect / Observation                                         | Steps to Reproduce                                       | Status   | Fix / Retest Notes                                                                  |
| ----- | ------------------------------------------------------------ | -------------------------------------------------------- | -------- | ----------------------------------------------------------------------------------- |
| D-001 | Default widget test fails because MyApp is not defined       | Run `flutter test test/widget_test.dart`                 | Open     | Update the test to use the actual application root widget and retest.               |
| D-002 | APK release build initially attempted from the parent folder | Run `flutter build apk --release` from the parent folder | Resolved | Changed to the PocketPilot project root and successfully generated the release APK. |
| D-003 | APK file was not initially visible in the expected folder    | Open the release APK output folder                       | Resolved | Rebuilt the release APK successfully. Verify that `app-release.apk` is present.     |

## Required Test Areas

The following areas must be checked during team testing:

* Empty and invalid form submissions
* Very long text and boundary values
* Offline use and app restart persistence
* Repeated rapid taps and repeated save attempts
* Portrait and landscape orientation
* Physical-device release APK installation and launch

## Testing Notes

* Release APK build completed successfully.
* Release APK size: approximately 49.8 MB.
* At least one widget test must pass using the `flutter test` command.
* All defects must be retested before marking them as fixed.
