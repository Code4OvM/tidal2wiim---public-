# M08 · Manage login and the token lifecycle

[Code Atlas](../README.md) · [Module overview](../00_Kurzueberblick.md) · [Diagram overview](../04_Diagrammuebersicht.md)

**Source code:** [lib/services/tidal_auth_service.dart](https://github.com/Code4OvM/tidal2wiim-demo/blob/851304ffd33e6ed9f65d74a29d146311e9a6265b/lib/services/tidal_auth_service.dart)

**Purpose:** Restores the shared session, saves login results and renews tokens when needed. Prevents duplicate concurrent refreshes and results from a session that has since been replaced.

**Inputs:** clientId, optional store/client/clock dependencies; TidalSession at login; HTTPS URI and HTTP client when reading.

**Outputs:** Future<String> for a token, Future<Response> for an API GET, status getters and ChangeNotifier notifications.

**Connections:** HomePage owns or receives the service and passes the same reference to subpages. SecureTidalSessionStore uses flutter_secure_storage.

**Key names:** TidalAuthService, TidalSession, TidalSessionStore, SecureTidalSessionStore; restore(), acceptLogin(), accessToken(), get(), forget()

**Note:** HTTP 401 leads to at most one second API GET. Temporary network errors preserve the session. storageWarning indicates problems reading, saving or removing the securely stored session.

**Diagrams:** [Session management and testability](../SVG/03_Klassen_Sitzung.svg) · [App startup: cache and stored session](../SVG/06_Sequenz_Appstart.svg) · [Interactive sign-in and secure storage](../SVG/07_Sequenz_Anmeldung.svg) · [API 401: refresh once and retry](../SVG/10_Sequenz_Token401.svg)
