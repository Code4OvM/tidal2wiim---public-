Tidal2WiiM – graphical start-screen correction
Version dated: 30 September 2026
Target device according to the project: LZF ZA1, especially in landscape orientation.

FIXED ISSUES
1. Consistent scale: the image, text and tap targets share the same canvas
   (1448 x 1086, matching the actual PNG file).
   No distortion from BoxFit.fill; the entire interface is fitted proportionally
   into the available area.
2. The clickable Settings area covers BOTH the gear icon and its label.
   It opens the lab and remains accessible while loading.
3. The example album count embedded in the image is covered completely. The current
   value appears in the intended position under “MEINE SAMMLUNG” (“MY COLLECTION”).
4. The entire bottom status bar is rebuilt as an opaque layer with real Flutter
   elements. No old status words, check marks, track counts or times remain visible.
   The total track count, which has not been determined, is omitted.
5. SafeArea accounts for the screen insets reported by the Android system,
   particularly the bottom navigation bar. No fixed device-pixel height is required.
   Wider screen formats retain dark side margins instead of cropping or distorting
   the 4:3 artwork.
6. The widget test now checks the new start screen and navigation to the lab,
   rather than sign-in buttons directly on the image-based start screen.

COPY THE FILES
First create a backup of your project outside lib/test.
Extract the ZIP into a separate directory.
Copy the lib, assets and test folders into D:\Entwicklung\tidal2wiim.
Replace existing files with the same names, particularly test\widget_test.dart.
Do NOT replace the project's existing pubspec.yaml.

No new packages, no new database version and no Android/Gradle changes are needed.
The image file is byte-for-byte identical to the approved image from the previous
start-screen package. Its path remains unchanged:
assets/images/startseite.png

The additional optional bibliothekLaden function in Tidal2WiiMApp/HomePage
enables isolated UI tests without the SQLite plugin. Normal startup remains
unchanged: the library cache is read from SQLite.

CHECK (in the project directory)
dart format lib test
flutter analyze
flutter test

Only if the checks succeed:
flutter build apk --release

Only after a successful build, in the same PowerShell window:
& "$env:LOCALAPPDATA\Android\Sdk\platform-tools\adb.exe" -s DHZ1A256GB26240629 install -r "D:\Entwicklung\tidal2wiim\build\app\outputs\flutter-apk\app-release.apk"

Do not uninstall the app or delete any app data. Categories, artist sort names,
the library cache and the cover cache are not changed by this source-code package.
install -r uses the normal update procedure.

PRACTICAL TEST
- Rotate the tablet into landscape orientation; the Android navigation bar remains visible.
- Tap directly on the gear icon: the lab must appear.
- Tap the house icon at the top of the lab: return to the graphical start screen.
- Check the album count and status fields: no misaligned or duplicated text.
- Open the collection, then return to the start screen.
- Refresh: the existing synchronisation runs; the timestamp is updated.

VERIFICATION STATUS OF THIS PACKAGE
Checked: completeness, part references, the unchanged image file, differences
from the original package and coordinates of the image, text and controls.
The included Flutter widget tests cover actions, lab navigation, dynamic values
and several aspect ratios with simulated system insets.
They were not run in the creation container: no Flutter SDK is installed here.
Flutter analyze/test and the Android build must be run on the development computer.
No test run on the LZF ZA1 is claimed.
