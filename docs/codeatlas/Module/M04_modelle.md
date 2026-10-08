# M04 · Describe shared data objects

[Code Atlas](../README.md) · [Module overview](../00_Kurzueberblick.md) · [Diagram overview](../04_Diagrammuebersicht.md)

**Source code:** [lib/models/modelle.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/models/modelle.dart)

**Purpose:** Defines eight domain and data transfer models for albums, artists, categories, settings, tracks, folders, API pages and the local cache. Album.ausRessourcen() combines API resources into an album.

**Inputs:** Constructor values; resource index keyed by type:id; SQLite map for KuenstlerEinstellung.

**Outputs:** Typed Dart objects; derived values such as year, display name and album count.

**Connections:** Shared vocabulary for HomePage, detail pages, SQLite, the collection and cover display.

**Key names:** Album, Kuenstler, Kategorie, KuenstlerEinstellung, KuenstlerOrdner, AlbumTitel, AlbumSeite, LokaleBibliothekCache

**Note:** Kategorie holds album IDs. Album contains artists, but no track list. A final field does not automatically make a list referenced by that field immutable.

**Diagrams:** [Domain models in memory](../SVG/02_Klassen_Datenmodelle.svg) · [From JSON resources to Album objects](../SVG/09_Sequenz_Albumseite.svg)
