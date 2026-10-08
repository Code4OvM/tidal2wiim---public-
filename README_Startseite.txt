Tidal2WiiM – visual start screen
================================

This package is based on the most recently tested refactoring version (step 4),
including the SQLite library cache and the local cover cache.

New:
- visual start screen using the approved landscape design
- “Open collection” as the main entry point
- the “Settings” gear icon opens the existing technical lab
- TIDAL status at the bottom left: tap when signed out -> sign in
- “Refresh collection” starts the TIDAL background synchronisation
- album count, TIDAL status, library status and last refresh are displayed dynamically
- the existing collection page remains unchanged

IMPORTANT – pubspec.yaml
------------------------
The image must be registered as an asset under the existing "flutter:" section:

flutter:
  uses-material-design: true
  assets:
    - assets/images/startseite.png

If an "assets:" section already exists, add only this line:

    - assets/images/startseite.png

Then run these commands in the project directory:

  flutter pub get
  dart format lib
  flutter analyze
  flutter test
  flutter build apk --release

Install on the tablet:

  & "$env:LOCALAPPDATA\Android\Sdk\platform-tools\adb.exe" install -r "D:\Entwicklung\tidal2wiim\build\app\outputs\flutter-apk\app-release.apk"
