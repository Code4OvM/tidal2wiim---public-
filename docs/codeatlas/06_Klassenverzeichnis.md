# Complete class directory

[Code Atlas](README.md) · [Documentation overview](../README.md)

46 class/interface declarations in lib/. Framework classes and MemorySessionStore (tests only) are not included in this count.

| Name | File | Responsibility |
| --- | --- | --- |
| LokaleDatenbank | lib/data/lokale_datenbank.dart | SQLite access and schema 3. |
| Tidal2WiiMApp | lib/main.dart | Root widget, theme and HomePage. |
| KuenstlerSortierZeile | lib/models/kuenstler_sortierung.dart | Unchanged initial data for an editor row. |
| KuenstlerSortierAenderung | lib/models/kuenstler_sortierung.dart | Data object for a confirmed sort-name change. |
| KuenstlerSortierEntwurf | lib/models/kuenstler_sortierung.dart | In-memory state for input, filtering and change detection. |
| KuenstlerEinstellung | lib/models/modelle.dart | Custom display name and local sort name. |
| Kategorie | lib/models/modelle.dart | Category ID, name and set of album IDs. |
| Kuenstler | lib/models/modelle.dart | TIDAL artist ID and name. |
| Album | lib/models/modelle.dart | Album metadata and participating artists. |
| LokaleBibliothekCache | lib/models/modelle.dart | Loaded album list with storage timestamp. |
| AlbumTitel | lib/models/modelle.dart | A track or video in the detail page state. |
| KuenstlerOrdner | lib/models/modelle.dart | Artist view derived from albums. |
| AlbumSeite | lib/models/modelle.dart | Result of an API collection page with the next cursor. |
| AlbumDetailPage | lib/pages/album_detail_page.dart | Configuration for a selected album. |
| _AlbumDetailPageState | lib/pages/album_detail_page.dart | Track list, categories and handoff to an external application. |
| HomePage | lib/pages/home_page.dart | Main page configuration and optional test dependencies. |
| _HomePageState | lib/pages/home_page.dart | Central coordination of state, data loading and navigation. |
| KategoriePage | lib/pages/kategorie_page.dart | Configuration of a category view. |
| _KategoriePageState | lib/pages/kategorie_page.dart | Reads the category, filters current album objects and refreshes the display. |
| KuenstlerPage | lib/pages/kuenstler_page.dart | Artist heading and shared album grid. |
| KuenstlerSortiernamenPage | lib/pages/kuenstler_sortiernamen_page.dart | Editor configuration and save callback. |
| _KuenstlerSortiernamenPageState | lib/pages/kuenstler_sortiernamen_page.dart | Draft, input fields, focus and cancel/save flow. |
| StartPage | lib/pages/start_page.dart | Start image and status data supplied by the parent widget. |
| _StartAktion | lib/pages/start_page.dart | Labelled, usable touch target. |
| _StartStatusLeiste | lib/pages/start_page.dart | Album/TIDAL status and refresh action. |
| _StartTidalZeichen | lib/pages/start_page.dart | Draws the status symbol as a CustomPainter. |
| _StartBibliothekZeichen | lib/pages/start_page.dart | Draws the library symbol as a CustomPainter. |
| LokalerCoverCache | lib/services/cover_cache.dart | File lookup, download, preloading and cover cleanup. |
| ApiFehler | lib/services/tidal_api.dart | HTTP status and API path as an error object. |
| TidalSessionStore | lib/services/tidal_auth_service.dart | Interface for reading/writing the session package. |
| SecureTidalSessionStore | lib/services/tidal_auth_service.dart | Production store based on flutter_secure_storage. |
| TidalSession | lib/services/tidal_auth_service.dart | Token set and expiry time. |
| TidalSignInRequired | lib/services/tidal_auth_service.dart | A new sign-in is required. |
| TidalAuthUnavailable | lib/services/tidal_auth_service.dart | Temporary access failure without automatically discarding the session. |
| TidalSessionChanged | lib/services/tidal_auth_service.dart | An operation in progress no longer belongs to the current session. |
| TidalAuthService | lib/services/tidal_auth_service.dart | Shared session, token refresh and authenticated API GETs. |
| AlbumCover | lib/widgets/album_cover.dart | Configuration of the cover display for an album. |
| _AlbumCoverState | lib/widgets/album_cover.dart | File Future, loading indicator and image fallback. |
| AlbumGrid | lib/widgets/album_grid.dart | Shared grid for artist/category child pages. |
| _KategorieNameDialog | lib/widgets/dialoge.dart | Configuration of the category name dialog. |
| _KategorieNameDialogState | lib/widgets/dialoge.dart | Text controller, required-field validation and name return. |
| _KuenstlerDialogErgebnis | lib/widgets/dialoge.dart | Setting or explicit request to reset. |
| _KuenstlerBearbeitenDialog | lib/widgets/dialoge.dart | Configuration of an individual artist adjustment. |
| _KuenstlerBearbeitenDialogState | lib/widgets/dialoge.dart | Controllers for display/sort names and result return. |
| _AlbumKategorienDialog | lib/widgets/dialoge.dart | Configuration of the category selection. |
| _AlbumKategorienDialogState | lib/widgets/dialoge.dart | Edits a copy of the selected IDs. |


Also: one Dart extension, `KuenstlerSortierungSpeichern`, three enums, `Sortierung`, `SammlungAnsicht`, `AppSeite`, and the type alias `Json`. The functions in core/ and tidal_api.dart are not additional classes.
