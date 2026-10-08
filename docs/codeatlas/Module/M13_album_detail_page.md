# M13 · Display an album, its tracks and local assignments

[Code Atlas](../README.md) · [Module overview](../00_Kurzueberblick.md) · [Diagram overview](../04_Diagrammuebersicht.md)

**Source code:** [lib/pages/album_detail_page.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/pages/album_detail_page.dart)

**Purpose:** Loads the track list from TIDAL and categories from SQLite independently of each other. Allows category assignment and opens album, track or video links externally.

**Inputs:** Album, shared AuthService, **optional country code of the TIDAL account, for example DE for Germany** and callbacks for login and category changes.

**Outputs:** List<AlbumTitel> in the page state, local category selection and external URLs; feedback after an assignment is saved.

**Connections:** Opened by HomePage or AlbumGrid; uses _apiLesen(), LokaleDatenbank, AlbumCover and dialogs.

**Key names:** AlbumDetailPage, _AlbumDetailPageState; _titelLaden(), _kategorienBearbeiten(), _inTidalOeffnen(), _titelInTidalOeffnen()

**Note:** The track list is not cached persistently. launchUrl() starts an external handler; playback and WiiM selection then take place outside our app.

**Related models:** [User interface: objects and callbacks](../SVG/05_Klassen_Oberflaeche.svg) · [Assigning an album to several categories](../SVG/12_Sequenz_Kategorien.svg) · [Loading album details and handing off to TIDAL](../SVG/14_Sequenz_Details_Wiedergabe.svg)
