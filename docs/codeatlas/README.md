# Tidal2WiiM - Code Atlas

[Documentation overview](../README.md) · [Project overview](../../README.md)

**Version dated 8 October 2026**

The Code Atlas describes the app from the program entry point through local storage and the TIDAL connection to the artist editor. It explains the modules' responsibilities, their connections and data exchange.

## Documented source revision

Source code: `Code4OvM/tidal2wiim-demo`, commit `851304ffd33e6ed9f65d74a29d146311e9a6265b`. The source links point to this recorded revision.

## Contents and starting points

- [PDF reading version](Tidal2WiiM_Codeatlas_2026-10-08.pdf)
- [Quick overview](00_Kurzueberblick.md)
- [Architecture and reading guide](01_Architektur.md)
- [19 module profiles](02_Modulhandbuch.md), also available individually under `Module/`
- [Data exchange and storage](03_Datenaustausch.md)
- [14 PlantUML diagrams](04_Diagrammuebersicht.md)
- [External packages and tests](05_Tests_und_Pruefhinweise.md)
- [Class directory](06_Klassenverzeichnis.md)

The diagrams are available as PlantUML sources, SVG and PNG. The [existing ER/table models](../README.md#data-models) provide a separate view; the class and sequence models complement them with a view of the program code.

## Modules and libraries

A module profile describes a Dart file under `lib/`. The project is a Dart package with three project-specific libraries: `main.dart` and 16 `part` files, plus the independent libraries `models/kuenstler_sortierung.dart` and `services/tidal_auth_service.dart`.

## Regenerating the diagrams

With Java and an existing `plantuml.jar`:

```powershell
.\Modelle_rendern.ps1 -PlantUmlJar "C:\Tools\plantuml\plantuml.jar"
```

Or with Python and Java:

```text
python Modelle_rendern.py /path/to/plantuml.jar
```

The scripts write to `SVG/` and `PNG/`. Component and class models use Smetana. The supplied graphics were generated locally with PlantUML 1.2025.10.
