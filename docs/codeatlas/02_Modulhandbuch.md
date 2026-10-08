# Module handbook

[Code Atlas](README.md) · [Documentation overview](../README.md)

19 own Dart files, each described using the same profile format.

## M01 · Start the app and connect the files


**Source code:** [lib/main.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/main.dart)

**Purpose:** Starts Flutter with Tidal2WiiMApp. Builds MaterialApp, a dark theme and HomePage. Combines 16 part files into one shared Dart library and imports two other project libraries.

**Inputs:** Optional: bibliothekLaden callback and TidalAuthService for isolated tests.

**Outputs:** Widget tree with HomePage; does not itself provide album data or run SQL queries.

**Connections:** Includes all part files; imports models/kuenstler_sortierung.dart and services/tidal_auth_service.dart.

**Key names:** main(), Tidal2WiiMApp.build()

**Note:** The folders represent functional areas. Technically, tidal2wiim is a Dart package with three project libraries.

**Diagrams:** [Responsibilities and data flows](SVG/01_Komponenten.svg) · [User interface: objects and callbacks](SVG/05_Klassen_Oberflaeche.svg) · [App startup: cache and stored session](SVG/06_Sequenz_Appstart.svg)

---

## M02 · Process JSON, search text and durations


**Source code:** [lib/core/hilfen.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/core/hilfen.dart)

**Purpose:** Provides small helper functions with no state of their own. Checks JSON structures, cleans up text and converts **time spans in the standardised format defined by ISO 8601** – here, for example, the playing time of a music track – for the track display.

**Inputs:** Object?, JSON values, search text or Duration?.

**Outputs:** Json, List<Json>, String?, normalised search text, as well as Duration? and display text.

**Data types:** `String?` means text or `null`. `Duration?` means a duration or `null`. In each case, the `?` allows a missing value.

**Connections:** Used by models, API response processing, the collection and the album detail page. No direct network or database access.

**Key names:** Json, _objekt(), _optionalObjekt(), _liste(), _text(), _vergleichstext(), _dauerLesen(), _dauerAnzeige()

**Note:** A missing optional value may remain null. An invalid required structure, however, is reported as a FormatException.

**Diagrams:** [From JSON resources to Album objects](SVG/09_Sequenz_Albumseite.svg) · [Loading album details and handing off to TIDAL](SVG/14_Sequenz_Details_Wiedergabe.svg)

---

## M03 · Derive views from existing albums


**Source code:** [lib/core/sammlung.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/core/sammlung.dart)

**Purpose:** Filters and sorts albums, creates artist folders and calculates the A–Z jump index. Defines the selection values for the app page, collection view and sorting.

**Inputs:** List<Album>, search text, Sortierung and Map<String, KuenstlerEinstellung>.

**Outputs:** Filtered album list, List<KuenstlerOrdner> or Map<String, int> as a letter index.

**Connections:** HomePage calls the functions when building the collection. Uses domain models and text helpers.

**Key names:** Sortierung, SammlungAnsicht, AppSeite, _ansichtErstellen(), _kuenstlerOrdnerErstellen(), _kuenstlerAlphabetIndex()

**Note:** Artist folders are created in RAM. Multiple artists on one album result in multiple folder assignments. Album sorting uses TIDAL artist names; custom sort names control the artist folders.

**Diagrams:** [Responsibilities and data flows](SVG/01_Komponenten.svg) · [Domain models in memory](SVG/02_Klassen_Datenmodelle.svg)

---

## M04 · Describe shared data objects


**Source code:** [lib/models/modelle.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/models/modelle.dart)

**Purpose:** Defines eight domain and data transfer models for albums, artists, categories, settings, tracks, folders, API pages and the local cache. Album.ausRessourcen() combines API resources into an album.

**Inputs:** Constructor values; resource index keyed by type:id; SQLite map for KuenstlerEinstellung.

**Outputs:** Typed Dart objects; derived values such as year, display name and album count.

**Connections:** Shared vocabulary for HomePage, detail pages, SQLite, the collection and cover display.

**Key names:** Album, Kuenstler, Kategorie, KuenstlerEinstellung, KuenstlerOrdner, AlbumTitel, AlbumSeite, LokaleBibliothekCache

**Note:** Kategorie holds album IDs. Album contains artists, but no track list. A final field does not automatically make a list referenced by that field immutable.

**Diagrams:** [Domain models in memory](SVG/02_Klassen_Datenmodelle.svg) · [From JSON resources to Album objects](SVG/09_Sequenz_Albumseite.svg)

---

## M05 · Collect changes in a draft


**Source code:** [lib/models/kuenstler_sortierung.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/models/kuenstler_sortierung.dart)

**Purpose:** Manages the original rows and sort names that have not yet been saved. Detects actual changes and keeps the order and the basis for searching stable while typing.

**Inputs:** Iterable<KuenstlerSortierZeile>; artist ID and input text; search text.

**Outputs:** Filtered rows, change count and an immutable List<KuenstlerSortierAenderung>.

**Connections:** Independent library with no imports from Flutter, SQLite or TIDAL. The editor page uses it; dedicated unit tests check the logic.

**Key names:** KuenstlerSortierZeile, KuenstlerSortierAenderung, KuenstlerSortierEntwurf; setzen(), filtern(), aenderungen

**Note:** Raw text is retained while typing. Only the effective value to be saved is trimmed; an empty field falls back to the original TIDAL name.

**Diagrams:** [Artist editor: input, draft and storage](SVG/04_Klassen_Kuenstlereditor.svg) · [Editing and saving sort names in bulk](SVG/11_Sequenz_Kuenstlereditor.svg)

---

## M06 · Store structured data locally


**Source code:** [lib/data/lokale_datenbank.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/data/lokale_datenbank.dart)

**Purpose:** Opens tidal2wiim.db with schema 3 and enables foreign keys. Encapsulates the cache, artist preferences, categories and album assignments; handles migrations and transactions.

**Inputs:** Album lists with timestamps, KuenstlerEinstellung, category names, and album and category IDs.

**Outputs:** Future<LokaleBibliothekCache?>, settings map, category lists, sets of IDs or Future<void>.

**Connections:** HomePage, KategoriePage and AlbumDetailPage use LokaleDatenbank.instance. sqflite executes SQL; path constructs the file path.

**Key names:** LokaleDatenbank, albumCacheLaden(), albumCacheSpeichern(), kategorienLaden(), albumKategorienSetzen()

**Note:** Cache replacement and assignment changes are atomic. Only category_albums.category_id is an SQL foreign key; artist data is stored in the cache as JSON.

**Diagrams:** [Responsibilities and data flows](SVG/01_Komponenten.svg) · [Loading the library: foreground and background](SVG/08_Sequenz_Bibliothek.svg) · [Assigning an album to several categories](SVG/12_Sequenz_Kategorien.svg)

---

## M07 · Write sort names to SQLite in one batch


**Source code:** [lib/data/kuenstler_sortierung_speichern.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/data/kuenstler_sortierung_speichern.dart)

**Purpose:** Adds batch saving to LokaleDatenbank. Checks IDs in advance and performs all changes in a single transaction. Does not modify existing custom display names.

**Inputs:** List<KuenstlerSortierAenderung> from the draft.

**Outputs:** Future<void>; on errors, an Exception and rollback rather than a partially applied set of changes.

**Connections:** HomePage connects the extension method to the editor page as the onSpeichern callback. Writes to artist_preferences.

**Key names:** extension KuenstlerSortierungSpeichern on LokaleDatenbank; kuenstlerSortiernamenSpeichern()

**Note:** An extension is not a subclass. When resetting, a preference record is only deleted if no custom display name needs to be retained.

**Diagrams:** [Artist editor: input, draft and storage](SVG/04_Klassen_Kuenstlereditor.svg) · [Editing and saving sort names in bulk](SVG/11_Sequenz_Kuenstlereditor.svg)

---

## M08 · Manage login and the token lifecycle


**Source code:** [lib/services/tidal_auth_service.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/services/tidal_auth_service.dart)

**Purpose:** Restores the shared session, saves login results and renews tokens when needed. Prevents duplicate concurrent refreshes and results from a session that has since been replaced.

**Inputs:** clientId, optional store/client/clock dependencies; TidalSession at login; HTTPS URI and HTTP client when reading.

**Outputs:** Future<String> for a token, Future<Response> for an API GET, status getters and ChangeNotifier notifications.

**Connections:** HomePage owns or receives the service and passes the same reference to subpages. SecureTidalSessionStore uses flutter_secure_storage.

**Key names:** TidalAuthService, TidalSession, TidalSessionStore, SecureTidalSessionStore; restore(), acceptLogin(), accessToken(), get(), forget()

**Note:** HTTP 401 leads to at most one second API GET. Temporary network errors preserve the session. storageWarning indicates problems reading, saving or removing the securely stored session.

**Diagrams:** [Session management and testability](SVG/03_Klassen_Sitzung.svg) · [App startup: cache and stored session](SVG/06_Sequenz_Appstart.svg) · [Interactive sign-in and secure storage](SVG/07_Sequenz_Anmeldung.svg) · [API 401: refresh once and retry](SVG/10_Sequenz_Token401.svg)

---

## M09 · Standardise API calls and read JSON


**Source code:** [lib/services/tidal_api.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/services/tidal_api.dart)

**Purpose:** Builds OpenAPI URLs, calls the authentication service, checks for HTTP 200 and decodes JSON. Reads the next-page cursor, selects a suitable cover URL and translates errors into understandable messages.

**Inputs:** http.Client, shared TidalAuthService, path segments and query parameters; JSON resources for the cover and cursor.

**Outputs:** Future<Json>, String? for a cursor/cover URL, or ApiFehler.

**Connections:** HomePage and AlbumDetailPage use _apiLesen(). Album.ausRessourcen() uses _coverUrlLesen().

**Key names:** _apiLesen(), _cursorLesen(), _coverUrlLesen(), _fehlerText(), ApiFehler

**Note:** The file is mainly a collection of functions, not a TidalApi class. Each call waits 300 ms before the request; this is not a complete automatic retry mechanism for HTTP 429.

**Diagrams:** [Responsibilities and data flows](SVG/01_Komponenten.svg) · [From JSON resources to Album objects](SVG/09_Sequenz_Albumseite.svg) · [API 401: refresh once and retry](SVG/10_Sequenz_Token401.svg)

---

## M10 · Cache album covers as files


**Source code:** [lib/services/cover_cache.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/services/cover_cache.dart)

**Purpose:** Finds or downloads cover files in the local cover_cache directory. Combines ongoing downloads for the same target path, initially writes to .tmp and removes obsolete files during synchronisation.

**Inputs:** Album with an ID and cover URL, or List<Album> for preloading; optional HTTP client.

**Outputs:** Future<File?> for a cover, or Future<void> after synchronisieren().

**Connections:** AlbumCover requests individual files. HomePage starts preloading after accepting the cache or completing a full update.

**Key names:** LokalerCoverCache.instance, dateiFuer(), synchronisieren(), _herunterladen()

**Note:** The limit of up to four workers applies to synchronisieren(), rather than being a global limit on all individual requests. Image bytes are stored in the file system and never as BLOBs in SQLite.

**Diagrams:** [Responsibilities and data flows](SVG/01_Komponenten.svg) · [App startup: cache and stored session](SVG/06_Sequenz_Appstart.svg) · [Cover display: file, download and fallback](SVG/13_Sequenz_Cover.svg)

---

## M11 · Coordinate app state and workflows


**Source code:** [lib/pages/home_page.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/pages/home_page.dart)

**Purpose:** The central StatefulWidget HomePage and its state _HomePageState manage the start view, lab and collection. They coordinate login, the cache, API pages, background synchronisation, search, artist folders, categories and navigation to the sort-name editor.

**Inputs:** Optional test dependencies, user actions, service notifications, API and database results.

**Outputs:** Current UI state; data and AuthService passed to child pages; callbacks for reloading.

**Connections:** The central coordinator for the database, authentication, API and cover cache. Builds StartPage; opens artist, category, album and editor pages.

**Key names:** HomePage, _HomePageState; _initialisieren(), _seiteLesen(), _albenLaden(), _bibliothekImHintergrundAktualisieren(), _kuenstlerSortiernamenOeffnen()

**Note:** Splitting the code into files does not yet separate all UI and domain logic. The lab and collection are widget methods here, rather than separate page classes.

**Related models:** [Responsibilities and data flows](SVG/01_Komponenten.svg) · [User interface: objects and callbacks](SVG/05_Klassen_Oberflaeche.svg) · [App startup: cache and stored session](SVG/06_Sequenz_Appstart.svg) · [Loading the library: foreground and background](SVG/08_Sequenz_Bibliothek.svg) · [From JSON resources to Album objects](SVG/09_Sequenz_Albumseite.svg) · [Editing and saving sort names in bulk](SVG/11_Sequenz_Kuenstlereditor.svg)

---

## M12 · Connect the start image to real controls


**Source code:** [lib/pages/start_page.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/pages/start_page.dart)

**Purpose:** Displays the start graphic, dynamic album count and status bar. Scales the image, text and touch target areas together and triggers four actions supplied by the parent widget.

**Inputs:** Album count, session/loading flags, update time and four callbacks.

**Outputs:** Calls to onSammlungOeffnen, onLaborOeffnen, onAktualisieren and onTidalStatus.

**Connections:** Configured by HomePage. _StartAktion, _StartStatusLeiste and two CustomPainter implementations form internal UI components.

**Key names:** StartPage, _StartAktion, _StartStatusLeiste, _StartTidalZeichen, _StartBibliothekZeichen

**Note:** StartPage does not read SQLite or the API itself. It displays the supplied state and delegates actions back to HomePage.

**Related models:** [User interface: objects and callbacks](SVG/05_Klassen_Oberflaeche.svg) · [App startup: cache and stored session](SVG/06_Sequenz_Appstart.svg)

---

## M13 · Display an album, its tracks and local assignments


**Source code:** [lib/pages/album_detail_page.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/pages/album_detail_page.dart)

**Purpose:** Loads the track list from TIDAL and categories from SQLite independently of each other. Allows category assignment and opens album, track or video links externally.

**Inputs:** Album, shared AuthService, optional country and callbacks for login and category changes.

**Outputs:** List<AlbumTitel> in the page state, local category selection and external URLs; feedback after an assignment is saved.

**Connections:** Opened by HomePage or AlbumGrid; uses _apiLesen(), LokaleDatenbank, AlbumCover and dialogs.

**Key names:** AlbumDetailPage, _AlbumDetailPageState; _titelLaden(), _kategorienBearbeiten(), _inTidalOeffnen(), _titelInTidalOeffnen()

**Note:** The track list is not cached persistently. launchUrl() starts an external handler; playback and WiiM selection then take place outside our app.

**Related models:** [User interface: objects and callbacks](SVG/05_Klassen_Oberflaeche.svg) · [Assigning an album to several categories](SVG/12_Sequenz_Kategorien.svg) · [Loading album details and handing off to TIDAL](SVG/14_Sequenz_Details_Wiedergabe.svg)

---

## M14 · Display the albums in an artist folder


**Source code:** [lib/pages/kuenstler_page.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/pages/kuenstler_page.dart)

**Purpose:** A small, stateless wrapper: displays the display name as the page title and passes the associated albums to AlbumGrid.

**Inputs:** KuenstlerOrdner, AuthService, optional country and change/login callbacks.

**Outputs:** Widget tree consisting of AppBar and AlbumGrid.

**Connections:** HomePage creates the folder beforehand with _kuenstlerOrdnerErstellen(). AlbumGrid handles navigation to the details.

**Key names:** KuenstlerPage.build()

**Note:** The page does not create folders or request artist data. It receives objects that have already been prepared.

**Related models:** [Domain models in memory](SVG/02_Klassen_Datenmodelle.svg) · [User interface: objects and callbacks](SVG/05_Klassen_Oberflaeche.svg)

---

## M15 · Connect saved assignments to loaded albums


**Source code:** [lib/pages/kategorie_page.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/pages/kategorie_page.dart)

**Purpose:** Reads the category together with its album IDs and filters the supplied album list. Displays both the visible albums and the number of saved assignments.

**Inputs:** Category ID/name, all currently loaded albums, AuthService and callbacks.

**Outputs:** List<Album> sorted by year and title for AlbumGrid; updates after category changes.

**Connections:** Uses LokaleDatenbank.kategorienLaden(); AlbumGrid opens the details. The callback reloads this page first and then the parent view.

**Key names:** KategoriePage, _KategoriePageState; _neuLaden()

**Note:** A saved album ID may no longer be in the current cache. The total count and visible count can therefore differ.

**Related models:** [User interface: objects and callbacks](SVG/05_Klassen_Oberflaeche.svg) · [Assigning an album to several categories](SVG/12_Sequenz_Kategorien.svg)

---

## M16 · Edit multiple sort names conveniently


**Source code:** [lib/pages/kuenstler_sortiernamen_page.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/pages/kuenstler_sortiernamen_page.dart)

**Purpose:** Provides search, input fields, a change counter and saving. Manages controllers, focus changes and protection against leaving with unsaved changes.

**Inputs:** List<KuenstlerSortierZeile> and an onSpeichern callback.

**Outputs:** A list of changes passed to the callback; a Navigator result of true after successful saving. Cancelling does not return true.

**Connections:** HomePage supplies the rows and save function. KuenstlerSortierEntwurf keeps the domain logic separate from Flutter.

**Key names:** KuenstlerSortiernamenPage, _KuenstlerSortiernamenPageState; _speichern(), _verlassen(), _fokusVerschieben()

**Note:** If saving fails, the entered values remain on the page. Editing and accidental closing are blocked while saving.

**Related models:** [Artist editor: input, draft and storage](SVG/04_Klassen_Kuenstlereditor.svg) · [Editing and saving sort names in bulk](SVG/11_Sequenz_Kuenstlereditor.svg)

---

## M17 · A reusable grid for child pages


**Source code:** [lib/widgets/album_grid.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/widgets/album_grid.dart)

**Purpose:** Displays album cards with a cover, title, artists and year. Tapping a card opens an AlbumDetailPage with the same services and callbacks.

**Inputs:** List<Album>, AuthService, optional country and two callbacks.

**Outputs:** Album grid and navigation to the detail page.

**Connections:** Used by KuenstlerPage and KategoriePage; builds AlbumCover. The main collection currently has its own grid in HomePage.

**Key names:** AlbumGrid.build()

**Note:** Reuse is clearly visible here. It would be inaccurate to claim that every grid in the app already uses this widget.

**Related models:** [User interface: objects and callbacks](SVG/05_Klassen_Oberflaeche.svg) · [Loading album details and handing off to TIDAL](SVG/14_Sequenz_Details_Wiedergabe.svg)

---

## M18 · Load a cover file and handle image errors


**Source code:** [lib/widgets/album_cover.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/widgets/album_cover.dart)

**Purpose:** Requests a cover from the file cache and displays a loading indicator, a file image or a network image. A placeholder appears if the URL is missing or the network image fails.

**Inputs:** Album; changes to the ID or cover URL are detected when the widget is updated.

**Outputs:** Image display with FutureBuilder; no modified Album object.

**Connections:** Uses LokalerCoverCache.dateiFuer(), Image.file and Image.network as a fallback. Used in the main collection, AlbumGrid and the detail page.

**Key names:** AlbumCover, _AlbumCoverState; initState(), didUpdateWidget(), _netzFallback()

**Note:** An existing file path does not guarantee that the image can be decoded. Image.file therefore also has error handling.

**Related models:** [Cover display: file, download and fallback](SVG/13_Sequenz_Cover.svg)

---

## M19 · Collect input and return results


**Source code:** [lib/widgets/dialoge.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/widgets/dialoge.dart)

**Purpose:** Groups three stateful dialogs: a category name, an individual artist adjustment and album category selection. Each dialog has its own input controllers or copy of the selection.

**Inputs:** Dialog title/initial name, artist data or categories with selected IDs.

**Outputs:** String, _KuenstlerDialogErgebnis or Set<int> through Navigator.pop(); null when cancelled.

**Connections:** HomePage and AlbumDetailPage open the dialogs and then save to SQLite themselves.

**Key names:** _KategorieNameDialog, _KuenstlerBearbeitenDialog, _AlbumKategorienDialog, _KuenstlerDialogErgebnis; corresponding State classes

**Note:** The dialogs do not perform SQL operations. Controllers are released in dispose() of their own dialog state.

**Related models:** [Assigning an album to several categories](SVG/12_Sequenz_Kategorien.svg)
