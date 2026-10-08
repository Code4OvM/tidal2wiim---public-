# M03 · Derive views from existing albums

[Code Atlas](../README.md) · [Module overview](../00_Kurzueberblick.md) · [Diagram overview](../04_Diagrammuebersicht.md)

**Source code:** [lib/core/sammlung.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/core/sammlung.dart)

**Purpose:** Filters and sorts albums, creates artist folders and calculates the A–Z jump index. Defines the selection values for the app page, collection view and sorting.

**Inputs:** List<Album>, search text, Sortierung and Map<String, KuenstlerEinstellung>.

**Outputs:** Filtered album list, List<KuenstlerOrdner> or Map<String, int> as a letter index.

**Connections:** HomePage calls the functions when building the collection. Uses domain models and text helpers.

**Key names:** Sortierung, SammlungAnsicht, AppSeite, _ansichtErstellen(), _kuenstlerOrdnerErstellen(), _kuenstlerAlphabetIndex()

**Note:** Artist folders are created in RAM. Multiple artists on one album result in multiple folder assignments. Album sorting uses TIDAL artist names; custom sort names control the artist folders.

**Diagrams:** [Responsibilities and data flows](../SVG/01_Komponenten.svg) · [Domain models in memory](../SVG/02_Klassen_Datenmodelle.svg)
