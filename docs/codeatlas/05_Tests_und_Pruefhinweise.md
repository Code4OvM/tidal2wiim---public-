# External packages and tests

[Code Atlas](README.md) · [Documentation overview](../README.md)

## Direct external packages

The listed package versions come from the pubspec.lock of the documented source revision.

| Package | Lockfile version | Responsibility |
| --- | --- | --- |
| flutter | SDK | Widgets, MaterialApp, Navigator, setState, ChangeNotifier and lifecycle. |
| flutter_appauth | 12.1.0 | Interactive TIDAL sign-in; supplies the initial token set to HomePage. |
| http | 1.6.0 | OpenAPI GET, token POST and cover downloads; interchangeable clients enable testing. |
| sqflite | 2.4.4 | SQLite queries, migrations and transactions on the device. |
| path | 1.9.1 | Joins database and cover paths appropriately for the platform. |
| flutter_secure_storage | 11.2.0 | Secure platform storage for the JSON token package. |
| url_launcher | 6.3.2 | Passes album, track and video links to an external application. |
| cupertino_icons | 1.0.9 | Declared in the project; no CupertinoIcons call in the examined lib code. |
| flutter_test | SDK | Unit/widget tests, WidgetTester and the Flutter test environment. |
| flutter_lints | 6.0.0 | Static style/analysis rules through analysis_options.yaml; not a runtime service. |
| flutter_launcher_icons | 0.14.4 | Development tool for generating app icons; not a runtime service. |

The Dart SDK libraries dart:async, dart:convert and dart:io provide asynchronous operations, JSON/UTF-8 and file access. Flutter provides material.dart, services.dart and foundation.dart, among others. These imports are not additional project-specific packages.

## Configuration and platform folders

pubspec.yaml describes the package, dependencies and assets. pubspec.lock records the resolved versions. analysis_options.yaml configures static analysis. assets/ contains the start image and icon. docs/datenmodell/ contains the existing planning models.

android/ contains the native Android embedding, Gradle configuration, manifest, OAuth callback and resources. ios/, macos/, linux/ and web/ are additional platform scaffolds. Their existence does not demonstrate tested support for these platforms. The declared target device remains Android.

## Existing tests

| File | Focus | What they check / provide |
| --- | --- | --- |
| test/kuenstler_sortierung_test.dart | Draft logic | Only changed IDs, fallback for empty values, stable filters/order, separate IDs despite identical names and invalid input. |
| test/kuenstler_sortiernamen_page_test.dart | Editor UI | Save/cancel, Android back navigation, save errors, preserved input, keyboard focus and different screen/text sizes. |
| test/tidal_auth_service_test.dart | Session service | Restoration, expiry time, shared refresh, network/server errors, invalid_grant, storage warning and exactly one 401 retry. |
| test/widget_test.dart | Start/laboratory | Start actions and touch targets, dynamic status values, restoration/forgetting sign-in and layout variants. |
| test/support/memory_session_store.dart | Test double | MemorySessionStore stores only in RAM, counts writes and simulates write errors; not an independent test case. |

The overview describes the existing test sources. Results from rerunning tests or builds are not part of this documentation. Widget tests with injected data or mock clients check isolated processes; real API, SQLite or tablet integration requires additional integration tests.

There is no dedicated direct integration test for SQLite transactions or the cover cache in the examined test/ folder. Complete end-to-end verification with TIDAL and WiiM would be an additional check.
