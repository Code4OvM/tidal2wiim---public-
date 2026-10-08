# M07 · Write sort names to SQLite in one batch

[Code Atlas](../README.md) · [Module overview](../00_Kurzueberblick.md) · [Diagram overview](../04_Diagrammuebersicht.md)

**Source code:** [lib/data/kuenstler_sortierung_speichern.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/data/kuenstler_sortierung_speichern.dart)

**Purpose:** Adds batch saving to LokaleDatenbank. Checks IDs in advance and performs all changes in a single transaction. Does not modify existing custom display names.

**Inputs:** List<KuenstlerSortierAenderung> from the draft.

**Outputs:** Future<void>; on errors, an Exception and rollback rather than a partially applied set of changes.

**Connections:** HomePage connects the extension method to the editor page as the onSpeichern callback. Writes to artist_preferences.

**Key names:** extension KuenstlerSortierungSpeichern on LokaleDatenbank; kuenstlerSortiernamenSpeichern()

**Note:** An extension is not a subclass. When resetting, a preference record is only deleted if no custom display name needs to be retained.

**Diagrams:** [Artist editor: input, draft and storage](../SVG/04_Klassen_Kuenstlereditor.svg) · [Editing and saving sort names in bulk](../SVG/11_Sequenz_Kuenstlereditor.svg)
