# Data exchange and storage

[Code Atlas](README.md) · [Documentation overview](../README.md)

## Data contracts between modules

| Connection | Data type / transfer | Meaning |
| --- | --- | --- |
| API → _apiLesen() | HTTP response / UTF-8 JSON | HTTP 200 is checked; the result is Json = Map<String, dynamic>. |
| JSON → Album | Map<String, Json> keyed by type:id | Collection IDs are resolved using album, artist and cover resources. |
| Page loader → Home | AlbumSeite | Contains List<Album> and the next collection cursor, rather than the complete library. |
| SQLite → Home | LokaleBibliothekCache? | Album list and storage timestamp; an empty table returns null. |
| Home → child page | Objects and references | Album/folder/lists plus the same TidalAuthService instance; no copied token. |
| Dialog → caller | String / Set<int> / result object | Navigator.pop provides a result later; null usually means cancellation. |
| Editor → save function | List<KuenstlerSortierAenderung> | Only artists that have actually changed; after success, pop(true) returns to Home. |
| Detail page → parent view | Future<void> Function() | onKategorienGeaendert reports the change without a data-set payload; parents read again. |
| Authentication → Home | ChangeNotifier | The listener reads the status getters again and calls setState; no app-wide event bus. |
| Cover cache → widget | Future<File?> | Image bytes remain in the file system. null/file errors lead to the network fallback. |
| App → TIDAL app | HTTPS URL | Only the content ID is in the link; neither an OAuth token nor a music file is passed on. |

## Four forms of storage

| Location | Content | Lifetime / boundary |
| --- | --- | --- |
| RAM | Albums, filtered views, loaded tracks, editor draft | Lost when the process ends; setState only updates the UI. |
| SQLite / tidal2wiim.db | Categories, album assignments, artist preferences, metadata cache | Persistent within the app's storage area. Schema 3; no audio streams or tokens. |
| Files / cover_cache | Downloaded covers as .img; temporarily .tmp | File name based on a sanitised album ID and a stable URL hash; can be downloaded again later. |
| Secure store | Version, clientId, access/refresh tokens and expiry time as JSON | Encapsulated by TidalSessionStore; not in SQLite or cover files. |

## SQLite is not the class model

`artist_preferences` stores custom artist names and sort names. `categories` contains categories. `category_albums` maps category/album pairs. `album_cache` contains album metadata, order and artist data as JSON.

Only `category_albums.category_id → categories.id` is an SQL foreign key. There is no such foreign key to album_cache. A complete cache replacement therefore does not delete category assignments. artist_preferences also only refers logically to TIDAL artist IDs; there is no separate artist table in the current schema.

A KuenstlerOrdner is derived from the current album objects. AlbumSeite and LokaleBibliothekCache are transport objects. AlbumTitel is loaded when a detail page is opened and is not stored in the local database. The existing ER/table models remain separate, unchanged representations.

## Example: a new sort name

Editor rows are created from album data and stored settings. The input “Wülker, Nils” initially becomes text in the draft. Saving creates a KuenstlerSortierAenderung object with the artist ID, TIDAL name and new sort name. The extension updates artist_preferences within a transaction. HomePage then reads the settings again and recalculates the artist folders and A–Z index. The TIDAL name and any existing custom display name are preserved.

## Example: an updated album

The collection first supplies the album ID. Further API calls supply album, artist and cover resources. Album.ausRessourcen() creates the domain object. After full background synchronisation, the entire metadata cache is replaced atomically. Only then is the visible album list replaced. The cover image is downloaded separately as a file. A single failed cover download does not invalidate the successfully stored album record.

## System boundary for playback

Album and track links contain a content ID. They contain no session tokens. The platform chooses the external handler; on the intended tablet, this is the TIDAL app. Playback must be started there. TIDAL Connect to the WiiM is not a separate call made by the code examined here.
