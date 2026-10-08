# M11 · Coordinate app state and workflows

[Code Atlas](../README.md) · [Module overview](../00_Kurzueberblick.md) · [Diagram overview](../04_Diagrammuebersicht.md)

**Source code:** [lib/pages/home_page.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/pages/home_page.dart)

**Purpose:** The central StatefulWidget HomePage and its state _HomePageState manage the start view, lab and collection. They coordinate login, the cache, API pages, background synchronisation, search, artist folders, categories and navigation to the sort-name editor.

**Inputs:** Optional test dependencies, user actions, service notifications, API and database results.

**Outputs:** Current UI state; data and AuthService passed to child pages; callbacks for reloading.

**Connections:** The central coordinator for the database, authentication, API and cover cache. Builds StartPage; opens artist, category, album and editor pages.

**Key names:** HomePage, _HomePageState; _initialisieren(), _seiteLesen(), _albenLaden(), _bibliothekImHintergrundAktualisieren(), _kuenstlerSortiernamenOeffnen()

**Note:** Splitting the code into files does not yet separate all UI and domain logic. The lab and collection are widget methods here, rather than separate page classes.

**Related models:** [Responsibilities and data flows](../SVG/01_Komponenten.svg) · [User interface: objects and callbacks](../SVG/05_Klassen_Oberflaeche.svg) · [App startup: cache and stored session](../SVG/06_Sequenz_Appstart.svg) · [Loading the library: foreground and background](../SVG/08_Sequenz_Bibliothek.svg) · [From JSON resources to Album objects](../SVG/09_Sequenz_Albumseite.svg) · [Editing and saving sort names in bulk](../SVG/11_Sequenz_Kuenstlereditor.svg)
