# Quick overview

[Code Atlas](README.md) · [Documentation overview](../README.md)

The app is a digital record shelf for TIDAL albums. It adds personal organisation by artist and category. It processes metadata and cover images; the TIDAL app then plays the music.

## Each module in one sentence

The identifiers M01 to M19 are consistent across the handbook, the individual profiles and the PDF. Here, a module means a project-specific Dart file. The entire project is a Dart package; the folders grouped by responsibility are not individually installable packages.

| Module / file | Responsibility |
| --- | --- |
| [M01 - lib/main.dart](Module/M01_main.md) | Starts Flutter and sets the app theme; opens HomePage. |
| [M02 - lib/core/hilfen.dart](Module/M02_hilfen.md) | Groups helper functions for text, names, search and JSON. |
| [M03 - lib/core/sammlung.dart](Module/M03_sammlung.md) | Filters and sorts albums; creates artist folders and the A–Z index. |
| [M04 - lib/models/modelle.dart](Module/M04_modelle.md) | Defines the shared data objects, such as albums, artists and categories. |
| [M05 - lib/models/kuenstler_sortierung.dart](Module/M05_kuenstler_sortierung.md) | Keeps unsaved sort names as an editable draft. |
| [M06 - lib/data/lokale_datenbank.dart](Module/M06_lokale_datenbank.md) | Stores and reads metadata, categories and artist preferences in SQLite. |
| [M07 - lib/data/kuenstler_sortierung_speichern.dart](Module/M07_kuenstler_sortierung_speichern.md) | Writes several changed artist sort names in one transaction. |
| [M08 - lib/services/tidal_auth_service.dart](Module/M08_tidal_auth_service.md) | Restores the session, refreshes tokens and encapsulates the secure store. |
| [M09 - lib/services/tidal_api.dart](Module/M09_tidal_api.md) | Reads TIDAL JSON; handles status, cursors, cover URLs and error messages. |
| [M10 - lib/services/cover_cache.dart](Module/M10_cover_cache.md) | Downloads cover images and keeps them as local image files. |
| [M11 - lib/pages/home_page.dart](Module/M11_home_page.md) | Coordinates navigation, sign-in, collection and background synchronisation. |
| [M12 - lib/pages/start_page.dart](Module/M12_start_page.md) | Displays the start image and status; passes user actions on through callbacks. |
| [M13 - lib/pages/album_detail_page.dart](Module/M13_album_detail_page.md) | Displays album details, loads tracks and manages category assignments. |
| [M14 - lib/pages/kuenstler_page.dart](Module/M14_kuenstler_page.md) | Displays the already prepared albums in an artist folder. |
| [M15 - lib/pages/kategorie_page.dart](Module/M15_kategorie_page.md) | Matches stored category IDs to the currently loaded albums. |
| [M16 - lib/pages/kuenstler_sortiernamen_page.dart](Module/M16_kuenstler_sortiernamen_page.md) | Displays the artist editor with search, input fields and saving. |
| [M17 - lib/widgets/album_grid.dart](Module/M17_album_grid.md) | Displays a reusable album grid and opens album details. |
| [M18 - lib/widgets/album_cover.dart](Module/M18_album_cover.md) | Displays a cover image from the file cache or a fallback display. |
| [M19 - lib/widgets/dialoge.dart](Module/M19_dialoge.md) | Collects dialog input and returns results to the calling page. |

## Data follows different paths

HomePage coordinates the processes. Pages receive objects and services through constructors. They return user actions or changes through callbacks and Navigator results. Asynchronous results are handled with Future and await.

| Data | Path / location | Why separate? |
| --- | --- | --- |
| Album metadata | TIDAL JSON → album objects → SQLite cache | Previously loaded albums are quickly available at the next start. |
| Personal organisation | Dialog/editor → result objects → SQLite | Categories and sort names are retained locally. |
| Cover images | HTTPS image request → files → AlbumCover | Image bytes belong in the file cache, not in SQL tables. |
| Sign-in | Authentication service ↔ secure session store | Tokens are stored separately from metadata and images. |
| Playback | Album/track link → external handler/TIDAL app | The app passes on a content ID; it does not stream music itself. |

## Three useful starting points for the models

1. [Component model 01](SVG/01_Komponenten.svg): an overview of responsibilities, data flows and system boundaries.
2. [Class model 04](SVG/04_Klassen_Kuenstlereditor.svg): how the editor, draft, change list and storage relate to each other.
3. [Sequence model 11](SVG/11_Sequenz_Kuenstlereditor.svg): enter values → build a change list → save together → reload the view.

Next, model 06 covers app startup, model 08 covers full library synchronisation and model 13 covers cover images. The handbook links each module to the relevant diagrams.
