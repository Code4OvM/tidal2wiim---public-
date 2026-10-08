# M18 · Load a cover file and handle image errors

[Code Atlas](../README.md) · [Module overview](../00_Kurzueberblick.md) · [Diagram overview](../04_Diagrammuebersicht.md)

**Source code:** [lib/widgets/album_cover.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/widgets/album_cover.dart)

**Purpose:** Requests a cover from the file cache and displays a loading indicator, a file image or a network image. A placeholder appears if the URL is missing or the network image fails.

**Inputs:** Album; changes to the ID or cover URL are detected when the widget is updated.

**Outputs:** Image display with FutureBuilder; no modified Album object.

**Connections:** Uses LokalerCoverCache.dateiFuer(), Image.file and Image.network as a fallback. Used in the main collection, AlbumGrid and the detail page.

**Key names:** AlbumCover, _AlbumCoverState; initState(), didUpdateWidget(), _netzFallback()

**Note:** An existing file path does not guarantee that the image can be decoded. Image.file therefore also has error handling.

**Related models:** [Cover display: file, download and fallback](../SVG/13_Sequenz_Cover.svg)
