# M15 · Connect saved assignments to loaded albums

[Code Atlas](../README.md) · [Module overview](../00_Kurzueberblick.md) · [Diagram overview](../04_Diagrammuebersicht.md)

**Source code:** [lib/pages/kategorie_page.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/pages/kategorie_page.dart)

**Purpose:** Reads the category together with its album IDs and filters the supplied album list. Displays both the visible albums and the number of saved assignments.

**Inputs:** Category ID/name, all currently loaded albums, AuthService and callbacks.

**Outputs:** List<Album> sorted by year and title for AlbumGrid; updates after category changes.

**Connections:** Uses LokaleDatenbank.kategorienLaden(); AlbumGrid opens the details. The callback reloads this page first and then the parent view.

**Key names:** KategoriePage, _KategoriePageState; _neuLaden()

**Note:** A saved album ID may no longer be in the current cache. The total count and visible count can therefore differ.

**Related models:** [User interface: objects and callbacks](../SVG/05_Klassen_Oberflaeche.svg) · [Assigning an album to several categories](../SVG/12_Sequenz_Kategorien.svg)
