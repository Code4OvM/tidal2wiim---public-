# M14 · Display the albums in an artist folder

[Code Atlas](../README.md) · [Module overview](../00_Kurzueberblick.md) · [Diagram overview](../04_Diagrammuebersicht.md)

**Source code:** [lib/pages/kuenstler_page.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/pages/kuenstler_page.dart)

**Purpose:** A small, stateless wrapper: displays the display name as the page title and passes the associated albums to AlbumGrid.

**Inputs:** KuenstlerOrdner, AuthService, optional country and change/login callbacks.

**Outputs:** Widget tree consisting of AppBar and AlbumGrid.

**Connections:** HomePage creates the folder beforehand with _kuenstlerOrdnerErstellen(). AlbumGrid handles navigation to the details.

**Key names:** KuenstlerPage.build()

**Note:** The page does not create folders or request artist data. It receives objects that have already been prepared.

**Related models:** [Domain models in memory](../SVG/02_Klassen_Datenmodelle.svg) · [User interface: objects and callbacks](../SVG/05_Klassen_Oberflaeche.svg)
