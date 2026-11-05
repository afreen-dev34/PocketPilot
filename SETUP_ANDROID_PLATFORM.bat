@echo off
setlocal
where flutter >nul 2>nul
if errorlevel 1 (
  echo Flutter was not found. Install Flutter and add flutter\bin to PATH first.
  pause
  exit /b 1
)
flutter create --platforms=android .
if errorlevel 1 exit /b 1
flutter pub get
if errorlevel 1 exit /b 1
dart run flutter_launcher_icons
if errorlevel 1 exit /b 1
echo Android platform created and PocketPilot launcher icon generated.
echo Next: flutter analyze ^&^& flutter test ^&^& flutter run
pause
