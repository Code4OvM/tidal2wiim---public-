# M01 · Start the app and connect the files

[Code Atlas](../README.md) · [Module overview](../00_Kurzueberblick.md) · [Diagram overview](../04_Diagrammuebersicht.md)

**Source code:** [lib/main.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/main.dart)

**Purpose:** Starts Flutter with Tidal2WiiMApp. Builds MaterialApp, a dark theme and HomePage. Combines 16 part files into one shared Dart library and imports two other project libraries.

**Inputs:** Optional: bibliothekLaden callback and TidalAuthService for isolated tests.

**Outputs:** Widget tree with HomePage; does not itself provide album data or run SQL queries.

**Connections:** Includes all part files; imports models/kuenstler_sortierung.dart and services/tidal_auth_service.dart.

**Key names:** main(), Tidal2WiiMApp.build()

**Note:** The folders represent functional areas. Technically, tidal2wiim is a Dart package with three project libraries.

**Diagrams:** [Responsibilities and data flows](../SVG/01_Komponenten.svg) · [User interface: objects and callbacks](../SVG/05_Klassen_Oberflaeche.svg) · [App startup: cache and stored session](../SVG/06_Sequenz_Appstart.svg)
