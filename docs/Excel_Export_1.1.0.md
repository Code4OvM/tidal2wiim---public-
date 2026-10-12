# Excel export – Tidal2WiiM 1.1.0

## Purpose and motivation

Tidal2WiiM is a personal digital record shelf for a TIDAL album library. It intentionally does not automatically assign genre categories: instead, it exports the saved albums to an open workbook format, allowing manual or AI-assisted analysis outside the app. The owner makes the final decision about categories, keeping the application small and maintainable.

## Features

- Open Settings/Lab → **Export albums to Excel**.
- Export the **entire locally cached library**, independent of filters and search queries.
- **One row per TIDAL album ID**, with multiple artists and categories combined within their respective cells.
- Artist, album and version, release date, available catalogue audio quality tags, categories, TIDAL link and TIDAL album ID.
- Optional read-only TIDAL requests for missing version and quality metadata; missing metadata stays empty, and albums are never silently omitted.
- Three deliberately blank columns: **Suggested genres** (one to three), **Assignment confidence** (high/medium/unclear), **Notes**.
- Formatted XLSX workbook, filter and frozen header, notes sheet, Android save dialog.
- Export does not modify the collection, SQLite database or categories. No re-import, embedded AI or automatic genre assignment.

## Practical validation

On 12 October 2026, **510 albums produced 510 workbook data rows**. Two albums whose TIDAL metadata could not be resolved were retained with their IDs and links. The export was tested on an Android tablet, and the developer reported a passing Flutter test suite and analyzer.

## Version

Version `1.1.0+2`. Uses `archive 4.3.0` and `file_picker 13.1.0`. Existing `flutter_secure_storage 11.2.0` authentication storage is unchanged.
