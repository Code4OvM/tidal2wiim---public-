# M05 · Collect changes in a draft

[Code Atlas](../README.md) · [Module overview](../00_Kurzueberblick.md) · [Diagram overview](../04_Diagrammuebersicht.md)

**Source code:** [lib/models/kuenstler_sortierung.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/models/kuenstler_sortierung.dart)

**Purpose:** Manages the original rows and sort names that have not yet been saved. Detects actual changes and keeps the order and the basis for searching stable while typing.

**Inputs:** Iterable<KuenstlerSortierZeile>; artist ID and input text; search text.

**Outputs:** Filtered rows, change count and an immutable List<KuenstlerSortierAenderung>.

**Connections:** Independent library with no imports from Flutter, SQLite or TIDAL. The editor page uses it; dedicated unit tests check the logic.

**Key names:** KuenstlerSortierZeile, KuenstlerSortierAenderung, KuenstlerSortierEntwurf; setzen(), filtern(), aenderungen

**Note:** Raw text is retained while typing. Only the effective value to be saved is trimmed; an empty field falls back to the original TIDAL name.

**Diagrams:** [Artist editor: input, draft and storage](../SVG/04_Klassen_Kuenstlereditor.svg) · [Editing and saving sort names in bulk](../SVG/11_Sequenz_Kuenstlereditor.svg)
