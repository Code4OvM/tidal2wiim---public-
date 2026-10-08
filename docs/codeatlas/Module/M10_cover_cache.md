# M10 · Cache album covers as files

[Code Atlas](../README.md) · [Module overview](../00_Kurzueberblick.md) · [Diagram overview](../04_Diagrammuebersicht.md)

**Source code:** [lib/services/cover_cache.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/services/cover_cache.dart)

**Purpose:** Finds or downloads cover files in the local cover_cache directory. Combines ongoing downloads for the same target path, initially writes to .tmp and removes obsolete files during synchronisation.

**Inputs:** Album with an ID and cover URL, or List<Album> for preloading; optional HTTP client.

**Outputs:** Future<File?> for a cover, or Future<void> after synchronisieren().

**Connections:** AlbumCover requests individual files. HomePage starts preloading after accepting the cache or completing a full update.

**Key names:** LokalerCoverCache.instance, dateiFuer(), synchronisieren(), _herunterladen()

**Note:** The limit of up to four workers applies to synchronisieren(), rather than being a global limit on all individual requests. Image bytes are stored in the file system and never as BLOBs in SQLite.

**Diagrams:** [Responsibilities and data flows](../SVG/01_Komponenten.svg) · [App startup: cache and stored session](../SVG/06_Sequenz_Appstart.svg) · [Cover display: file, download and fallback](../SVG/13_Sequenz_Cover.svg)
