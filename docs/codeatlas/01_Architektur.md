# Architecture and reading guide

[Code Atlas](README.md) · [Documentation overview](../README.md)

## A short path through the project

1. `main.dart`: identify the entry point and library boundaries.
2. `models/modelle.dart`: understand which data the app uses in RAM.
3. `core/sammlung.dart`: derive artist folders and views from albums.
4. `pages/home_page.dart`: follow the coordination of the UI, cache and online synchronisation.
5. `data/` and `services/`: distinguish persistent data, sign-in and external access.
6. Follow the artist editor with diagram 11: initial state → draft → confirmed change list → transaction → reloaded view.

## Three project-specific Dart libraries

| Library | Connection | Meaning |
| --- | --- | --- |
| main.dart plus 16 part files | part / part of | Shared namespace. `_private` names are visible across files within this library. |
| models/kuenstler_sortierung.dart | import in main.dart | Pure editing model without Flutter, SQLite or TIDAL dependencies. |
| services/tidal_auth_service.dart | import in main.dart | Encapsulated session with public methods and private internal state. |

The folders grouped by responsibility are therefore not strict technical layers. `HomePage` is the central stateful UI component (StatefulWidget) of the Flutter app. Its state, `_HomePageState`, coordinates navigation, views and data retrieval. The start view with its title graphic is built by the `StartPage` widget. The database and API use the same domain models. Refactoring into further independent libraries would be a later change, rather than the current implementation.

## How the connections work

**Constructor parameters:** When a page is opened, the album, lists, optional country and existing AuthService reference are passed to it. The data is not exchanged again over a network between the Dart files.

**Future and await:** A Future represents a result that will become available later. await waits within the relevant asynchronous function. Future.wait does not start separate operating system threads; the asynchronous operations that have been started can overlap in time. The cover workers are also asynchronous loops, not explicitly created isolates.

**Callbacks:** A child page calls a function passed to it. `onKategorienGeaendert()` does not send a complete data set. The parent view subsequently reads the affected data again. In contrast, the editor explicitly passes its change list to `onSpeichern(aenderungen)`.

**UI state:** setState notifies Flutter of a local state change. It does not save anything in SQLite. ChangeNotifier is used specifically for the session service; there is no general event bus here.

**Navigator:** A dialog or route can return a result. On editor success, this is true; only then does HomePage reload the settings. Cancelling or going back without changes does not result in a confirmed save operation.

## Notation in the PlantUML models

Solid class arrows show held references; dashed arrows show usage or creation. A dashed relationship labelled “via IDs” is not a stored object reference. Realisation and inheritance are shown only where they exist in the Dart code. The database extension is not a subclass.

In sequence diagrams, time runs from top to bottom. `alt` shows alternatives, `opt` a condition, `loop` repetition and `par` independently started asynchronous operations. Return arrows carry data or signal the completion of a Future. The representation condenses the code; it is not a runtime trace.

The class diagrams show selected attributes and methods for readability. The complete directory of all 46 classes/interfaces is provided separately. Helper functions are not drawn as invented service classes.
