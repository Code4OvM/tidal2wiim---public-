# M17 · A reusable grid for child pages

[Code Atlas](../README.md) · [Module overview](../00_Kurzueberblick.md) · [Diagram overview](../04_Diagrammuebersicht.md)

**Source code:** [lib/widgets/album_grid.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/widgets/album_grid.dart)

**Purpose:** Displays album cards with a cover, title, artists and year. Tapping a card opens an AlbumDetailPage with the same services and callbacks.

**Inputs:** List<Album>, AuthService, optional country and two callbacks.

**Outputs:** Album grid and navigation to the detail page.

**Connections:** Used by KuenstlerPage and KategoriePage; builds AlbumCover. The main collection currently has its own grid in HomePage.

**Key names:** AlbumGrid.build()

**Note:** Reuse is clearly visible here. It would be inaccurate to claim that every grid in the app already uses this widget.

**Related models:** [User interface: objects and callbacks](../SVG/05_Klassen_Oberflaeche.svg) · [Loading album details and handing off to TIDAL](../SVG/14_Sequenz_Details_Wiedergabe.svg)
