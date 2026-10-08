# M02 · Process JSON, search text and durations

[Code Atlas](../README.md) · [Module overview](../00_Kurzueberblick.md) · [Diagram overview](../04_Diagrammuebersicht.md)

**Source code:** [lib/core/hilfen.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/core/hilfen.dart)

**Purpose:** Provides small helper functions with no state of their own. Checks JSON structures, cleans up text and converts ISO durations for the track display.

**Inputs:** Object?, JSON values, search text or Duration?.

**Outputs:** Json, List<Json>, String?, normalised search text, as well as Duration? and display text.

**Data types:** `String?` means text or `null`. `Duration?` means a duration or `null`. In each case, the `?` allows a missing value.

**Connections:** Used by models, API response processing, the collection and the album detail page. No direct network or database access.

**Key names:** Json, _objekt(), _optionalObjekt(), _liste(), _text(), _vergleichstext(), _dauerLesen(), _dauerAnzeige()

**Note:** A missing optional value may remain null. An invalid required structure, however, is reported as a FormatException.

**Diagrams:** [From JSON resources to Album objects](../SVG/09_Sequenz_Albumseite.svg) · [Loading album details and handing off to TIDAL](../SVG/14_Sequenz_Details_Wiedergabe.svg)
