import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/album_export.dart';
import '../services/album_excel_export.dart';
import '../services/album_export_metadaten.dart';

typedef AlbumExcelSpeichern = Future<String?> Function(
  Uint8List bytes,
  String name,
);
typedef AlbumExcelErzeugen = Future<Uint8List> Function(
  AlbumExcelDokument dokument,
);

Future<String?> albumExcelAufAndroidSpeichern(
  Uint8List bytes,
  String name,
) async {
  if (!Platform.isAndroid) {
    throw UnsupportedError(
      'File export is designed for the Android tablet.',
    );
  }
  // file_picker 13: statische API, Rückgabewert Uri? statt String?.
  // Das Plugin schreibt die Bytes selbst. Eine content:-URI ist kein Dateipfad:
  // Deshalb hier NICHT zusätzlich File(uri).writeAsBytes() aufrufen.
  final Uri? ziel = await FilePicker.saveFile(
    dialogTitle: 'Save album list',
    fileName: name,
    mimeType:
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    type: FileType.custom,
    allowedExtensions: const ['xlsx'],
    bytes: bytes,
  );
  // Bestehende App-/Testschnittstelle beibehalten: null bedeutet Abbruch.
  return ziel?.toString();
}

class AlbumExcelExportPage extends StatefulWidget {
  const AlbumExcelExportPage({
    super.key,
    required this.albumAnzahl,
    required this.snapshotLaden,
    this.jsonLesen,
    this.land,
    this.speichern,
    this.erzeugen,
  });

  final int albumAnzahl;
  final Future<AlbumExportSnapshot> Function() snapshotLaden;
  final AlbumExportJsonLesen? jsonLesen;
  final String? land;
  final AlbumExcelSpeichern? speichern;
  final AlbumExcelErzeugen? erzeugen;

  @override
  State<AlbumExcelExportPage> createState() => _AlbumExcelExportPageState();
}

class _AlbumExcelExportPageState extends State<AlbumExcelExportPage> {
  late bool _onlineErgaenzen;
  bool _beschaeftigt = false;
  bool _dateidialog = false;
  bool _fehler = false;
  String _status = '';
  String? _hinweis;
  AlbumExportAbbruch? _abbruch;

  @override
  void initState() {
    super.initState();
    _onlineErgaenzen = widget.jsonLesen != null;
  }

  @override
  void dispose() {
    _abbruch?.abbrechen();
    super.dispose();
  }

  void _statusSetzen(String text) {
    if (!mounted) {
      return;
    }
    setState(() => _status = text);
  }

  Future<void> _exportieren() async {
    if (_beschaeftigt) {
      return;
    }
    FocusScope.of(context).unfocus();
    final abbruch = AlbumExportAbbruch();
    _abbruch = abbruch;
    setState(() {
      _beschaeftigt = true;
      _fehler = false;
      _hinweis = null;
      _status = 'Reading local library and categories ...';
    });
    try {
      final snapshot = await widget.snapshotLaden();
      abbruch.pruefen();
      if (snapshot.alben.isEmpty) {
        throw const FormatException(
          'Noch keine vollständige lokale Bibliothek vorhanden. '
          'Bitte zuerst die Sammlung vollständig laden.',
        );
      }
      _statusSetzen(
        _onlineErgaenzen
            ? 'Adding version and quality information from TIDAL ...'
            : 'Preparing local data for Excel ...',
      );
      final ergebnis = await albumExportMetadatenErgaenzen(
        alben: snapshot.alben,
        abbruch: abbruch,
        lesen: _onlineErgaenzen ? widget.jsonLesen : null,
        land: widget.land,
        fortschritt: (fertig, gesamt) => _statusSetzen(
          'TIDAL metadata: $fertig of $gesamt albums processed ...',
        ),
      );
      abbruch.pruefen();
      if (!mounted) {
        return;
      }
      setState(() {
        _hinweis = ergebnis.hinweis;
        _status =
            'Creating Excel file for ${ergebnis.alben.length} albums ...';
      });
      final zeit = DateTime.now();
      final dokument = AlbumExcelDokument(
        alben: ergebnis.alben,
        exportiertAm: zeit,
        cacheStand: snapshot.cacheStand,
        zusatzmetadatenAnzahl: ergebnis.ergaenzt,
        hinweis: ergebnis.hinweis,
      );
      final bytes = widget.erzeugen != null
          ? await widget.erzeugen!(dokument)
          : await compute(albumExcelErzeugen, dokument);
      abbruch.pruefen();
      if (!mounted) {
        return;
      }
      setState(() {
        _dateidialog = true;
        _status =
            'Choose a folder and filename in the Android dialog ...';
      });
      final name = albumExcelDateiname(zeit);
      final ort = await (widget.speichern ?? albumExcelAufAndroidSpeichern)(
        bytes,
        name,
      );
      if (!mounted) {
        return;
      }
      _statusSetzen(
        ort == null
            ? 'Save cancelled. The collection was not changed.'
            : '${ergebnis.alben.length} albums saved as an Excel file. '
                  'The file is at the selected location.',
      );
    } on AlbumExportAbgebrochen {
      _statusSetzen('Export cancelled. The collection was not changed.');
    } on FormatException catch (e) {
      if (!mounted) {
        return;
      }
      setState(() {
        _fehler = true;
        _status = e.message;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _fehler = true;
        _status =
            'Export oder Speichern fehlgeschlagen. Bitte erneut versuchen. '
            'Die Sammlung bleibt unverändert.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _beschaeftigt = false;
          _dateidialog = false;
          _abbruch = null;
        });
      }
    }
  }

  void _abbrechen() {
    if (_dateidialog) {
      return;
    }
    _abbruch?.abbrechen();
    _statusSetzen(
      'Cancelling export; the current request will finish first ...',
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_beschaeftigt,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Export albums to Excel'),
          leading: IconButton(
            tooltip: 'Back to settings',
            onPressed: _beschaeftigt ? null : () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  Text(
                    '${widget.albumAnzahl} albums available in the current view',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'The full locally saved library is exported, '
                    'not only matching search results. One row per album; multiple '
                    'artists and categories remain combined in the same row.',
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Artist · album title and version · release date · '
                    'Audio quality · categories · TIDAL link · TIDAL album ID',
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'The columns “Suggested genres”, “Assignment confidence” '
                    'and “Notes” are left empty for later editing.',
                  ),
                  const SizedBox(height: 20),
                  SwitchListTile.adaptive(
                    key: const ValueKey('excel-zusatzangaben'),
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'Retrieve version and quality details from TIDAL',
                    ),
                    subtitle: Text(
                      widget.jsonLesen == null
                          ? 'No saved sign-in session. Offline export is still available.'
                          : 'Read-only metadata requests. If the connection fails, '
                                'local data is still exported; missing values remain blank.',
                    ),
                    value: _onlineErgaenzen,
                    onChanged: _beschaeftigt || widget.jsonLesen == null
                        ? null
                        : (value) => setState(() => _onlineErgaenzen = value),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'The file can be saved to Downloads and then '
                    'transferred to a PC. No import, no changes to categories '
                    'and no automatic genre assignment.',
                  ),
                  const SizedBox(height: 24),
                  if (_beschaeftigt) ...[
                    const LinearProgressIndicator(),
                    const SizedBox(height: 12),
                  ],
                  if (_status.isNotEmpty) ...[
                    Text(
                      _status,
                      key: const ValueKey('excel-status'),
                      style: TextStyle(
                        color: _fehler
                            ? Theme.of(context).colorScheme.error
                            : null,
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                  if (_hinweis != null) ...[
                    Text(_hinweis!, key: const ValueKey('excel-hinweis')),
                    const SizedBox(height: 12),
                  ],
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      FilledButton.icon(
                        key: const ValueKey('excel-speichern'),
                        onPressed: _beschaeftigt || widget.albumAnzahl == 0
                            ? null
                            : _exportieren,
                        icon: const Icon(Icons.file_download_outlined),
                        label: const Text(
                          'Create and save Excel file',
                        ),
                      ),
                      if (_beschaeftigt && !_dateidialog)
                        TextButton(
                          key: const ValueKey('excel-abbrechen'),
                          onPressed: _abbruch?.abgebrochen == true
                              ? null
                              : _abbrechen,
                          child: const Text('Cancel export'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}