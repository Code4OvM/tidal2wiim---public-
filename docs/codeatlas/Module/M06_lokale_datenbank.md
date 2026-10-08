# M06 · Store structured data locally

[Code Atlas](../README.md) · [Module overview](../00_Kurzueberblick.md) · [Diagram overview](../04_Diagrammuebersicht.md)

**Source code:** [lib/data/lokale_datenbank.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/data/lokale_datenbank.dart)

**Purpose:** Opens tidal2wiim.db with schema 3 and enables foreign keys. Encapsulates the cache, artist preferences, categories and album assignments; handles migrations and transactions.

**Inputs:** Album lists with timestamps, KuenstlerEinstellung, category names, and album and category IDs.

**Outputs:** Future<LokaleBibliothekCache?>, settings map, category lists, sets of IDs or Future<void>.

**Connections:** HomePage, KategoriePage and AlbumDetailPage use LokaleDatenbank.instance. sqflite executes SQL; path constructs the file path.

**Key names:** LokaleDatenbank, albumCacheLaden(), albumCacheSpeichern(), kategorienLaden(), albumKategorienSetzen()

**Note:** Cache replacement and assignment changes are atomic. Only category_albums.category_id is an SQL foreign key; artist data is stored in the cache as JSON.

**Diagrams:** [Responsibilities and data flows](../SVG/01_Komponenten.svg) · [Loading the library: foreground and background](../SVG/08_Sequenz_Bibliothek.svg) · [Assigning an album to several categories](../SVG/12_Sequenz_Kategorien.svg)
