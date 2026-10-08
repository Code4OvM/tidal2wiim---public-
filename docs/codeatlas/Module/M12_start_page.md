# M12 · Connect the start image to real controls

[Code Atlas](../README.md) · [Module overview](../00_Kurzueberblick.md) · [Diagram overview](../04_Diagrammuebersicht.md)

**Source code:** [lib/pages/start_page.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/pages/start_page.dart)

**Purpose:** Displays the start graphic, dynamic album count and status bar. Scales the image, text and touch target areas together and triggers four actions supplied by the parent widget.

**Inputs:** Album count, session/loading flags, update time and four callbacks.

**Outputs:** Calls to onSammlungOeffnen, onLaborOeffnen, onAktualisieren and onTidalStatus.

**Connections:** Configured by HomePage. _StartAktion, _StartStatusLeiste and two CustomPainter implementations form internal UI components.

**Key names:** StartPage, _StartAktion, _StartStatusLeiste, _StartTidalZeichen, _StartBibliothekZeichen

**Note:** StartPage does not read SQLite or the API itself. It displays the supplied state and delegates actions back to HomePage.

**Related models:** [User interface: objects and callbacks](../SVG/05_Klassen_Oberflaeche.svg) · [App startup: cache and stored session](../SVG/06_Sequenz_Appstart.svg)
