# M19 · Collect input and return results

[Code Atlas](../README.md) · [Module overview](../00_Kurzueberblick.md) · [Diagram overview](../04_Diagrammuebersicht.md)

**Source code:** [lib/widgets/dialoge.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/widgets/dialoge.dart)

**Purpose:** Groups three stateful dialogs: a category name, an individual artist adjustment and album category selection. Each dialog has its own input controllers or copy of the selection.

**Inputs:** Dialog title/initial name, artist data or categories with selected IDs.

**Outputs:** String, _KuenstlerDialogErgebnis or Set<int> through Navigator.pop(); null when cancelled.

**Connections:** HomePage and AlbumDetailPage open the dialogs and then save to SQLite themselves.

**Key names:** _KategorieNameDialog, _KuenstlerBearbeitenDialog, _AlbumKategorienDialog, _KuenstlerDialogErgebnis; corresponding State classes

**Note:** The dialogs do not perform SQL operations. Controllers are released in dispose() of their own dialog state.

**Related models:** [Assigning an album to several categories](../SVG/12_Sequenz_Kategorien.svg)
