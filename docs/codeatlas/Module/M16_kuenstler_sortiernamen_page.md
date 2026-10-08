# M16 · Edit multiple sort names conveniently

[Code Atlas](../README.md) · [Module overview](../00_Kurzueberblick.md) · [Diagram overview](../04_Diagrammuebersicht.md)

**Source code:** [lib/pages/kuenstler_sortiernamen_page.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/pages/kuenstler_sortiernamen_page.dart)

**Purpose:** Provides search, input fields, a change counter and saving. Manages controllers, focus changes and protection against leaving with unsaved changes.

**Inputs:** List<KuenstlerSortierZeile> and an onSpeichern callback.

**Outputs:** A list of changes passed to the callback; a Navigator result of true after successful saving. Cancelling does not return true.

**Connections:** HomePage supplies the rows and save function. KuenstlerSortierEntwurf keeps the domain logic separate from Flutter.

**Key names:** KuenstlerSortiernamenPage, _KuenstlerSortiernamenPageState; _speichern(), _verlassen(), _fokusVerschieben()

**Note:** If saving fails, the entered values remain on the page. Editing and accidental closing are blocked while saving.

**Related models:** [Artist editor: input, draft and storage](../SVG/04_Klassen_Kuenstlereditor.svg) · [Editing and saving sort names in bulk](../SVG/11_Sequenz_Kuenstlereditor.svg)
