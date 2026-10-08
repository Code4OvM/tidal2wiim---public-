# M09 · Standardise API calls and read JSON

[Code Atlas](../README.md) · [Module overview](../00_Kurzueberblick.md) · [Diagram overview](../04_Diagrammuebersicht.md)

**Source code:** [lib/services/tidal_api.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/services/tidal_api.dart)

**Purpose:** Builds OpenAPI URLs, calls the authentication service, checks for HTTP 200 and decodes JSON. Reads the next-page cursor, selects a suitable cover URL and translates errors into understandable messages.

**Inputs:** http.Client, shared TidalAuthService, path segments and query parameters; JSON resources for the cover and cursor.

**Outputs:** Future<Json>, String? for a cursor/cover URL, or ApiFehler.

**Connections:** HomePage and AlbumDetailPage use _apiLesen(). Album.ausRessourcen() uses _coverUrlLesen().

**Key names:** _apiLesen(), _cursorLesen(), _coverUrlLesen(), _fehlerText(), ApiFehler

**Note:** The file is mainly a collection of functions, not a TidalApi class. Each call waits 300 ms before the request; this is not a complete automatic retry mechanism for HTTP 429.

**Diagrams:** [Responsibilities and data flows](../SVG/01_Komponenten.svg) · [From JSON resources to Album objects](../SVG/09_Sequenz_Albumseite.svg) · [API 401: refresh once and retry](../SVG/10_Sequenz_Token401.svg)
