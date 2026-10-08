# Documentation

[Project overview](../README.md)

The documentation connects the view of the program code with the existing data models. The diagrams are available as readable graphics and editable PlantUML sources.

## Code Atlas

The [Code Atlas](codeatlas/README.md) describes the 19 project-specific Dart modules, their responsibilities, relationships and data exchange.

| Starting point | Content |
| --- | --- |
| [Quick overview](codeatlas/00_Kurzueberblick.md) | An overview of all modules and the main data flows. |
| [Architecture and reading guide](codeatlas/01_Architektur.md) | Libraries, responsibilities and connections. |
| [Module handbook](codeatlas/02_Modulhandbuch.md) | Descriptions of all 19 modules with source code references. |
| [Data exchange and storage](codeatlas/03_Datenaustausch.md) | Data contracts, SQLite, file cache and session store. |
| [Diagram overview](codeatlas/04_Diagrammuebersicht.md) | One component model, four class models and nine sequence models. |
| [Code Atlas as a PDF](codeatlas/Tidal2WiiM_Codeatlas_2026-10-08.pdf) | A complete reading version with 38 pages. |

A simple reading path leads from the overview through the architecture to a module and its corresponding diagram. On the individual module pages, links lead back to the module overview and directly to the relevant models.

## Data models

The existing data models complement the Code Atlas with a view of entities and tables. Their representations remain separate documentation.

| Model | Reading view | Editable source |
| --- | --- | --- |
| ER model in Chen notation | [SVG](datenmodell/Leseansichten/01_ER_Modell_Chen_Leseansicht.svg) | [PlantUML](datenmodell/PlantUML/01_ER_Modell_Chen.puml) |
| Relational table model | [SVG](datenmodell/Leseansichten/02_Relationales_Tabellenmodell_Leseansicht.svg) | [PlantUML](datenmodell/PlantUML/02_Relationales_Tabellenmodell.puml) |

Both reading views are also combined in the [data models PDF](datenmodell/Tidal2WiiM_Datenmodelle_Leseansicht.pdf).
