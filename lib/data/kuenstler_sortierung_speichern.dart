part of '../main.dart';

// Extension of the existing database class. No schema change.
extension KuenstlerSortierungSpeichern on LokaleDatenbank {
  Future<void> kuenstlerSortiernamenSpeichern(
    List<KuenstlerSortierAenderung> aenderungen,
  ) async {
    if (aenderungen.isEmpty) {
      return;
    }
    // Validate the entire input BEFORE the transaction starts.
    final ids = <String>{};
    for (final eintrag in aenderungen) {
      if (eintrag.kuenstlerId.trim().isEmpty ||
          eintrag.tidalName.trim().isEmpty) {
        throw ArgumentError('Künstler-ID und TIDAL-Name fehlen.');
      }
      if (!ids.add(eintrag.kuenstlerId)) {
        throw ArgumentError('Künstler-ID mehrfach in der Änderungsliste.');
      }
    }

    final db = await datenbank;
    final jetzt = DateTime.now().millisecondsSinceEpoch;

    await db.transaction((txn) async {
      for (final eintrag in aenderungen) {
        final name = eintrag.sortiername.trim();
        final sortiername = name.isEmpty ? eintrag.tidalName.trim() : name;
        final original = eintrag.tidalName.trim();

        if (sortiername == original) {
          // An empty input field means: use the TIDAL name again.
          // Do NOT remove a custom display name when doing so.
          final vorhanden = await txn.query(
            'artist_preferences',
            columns: ['custom_name'],
            where: 'artist_id = ?',
            whereArgs: [eintrag.kuenstlerId],
            limit: 1,
          );
          if (vorhanden.isEmpty) {
            continue;
          }
          if (_text(vorhanden.first['custom_name']) == null) {
            await txn.delete(
              'artist_preferences',
              where: 'artist_id = ?',
              whereArgs: [eintrag.kuenstlerId],
            );
            continue;
          }
        }

        // Update only the sorting; custom_name remains byte-for-byte
        // unchanged. Only IDs with actual changes are affected.
        final getroffen = await txn.update(
          'artist_preferences',
          {'sort_name': sortiername, 'updated_at': jetzt},
          where: 'artist_id = ?',
          whereArgs: [eintrag.kuenstlerId],
        );
        if (getroffen == 0) {
          await txn.insert('artist_preferences', {
            'artist_id': eintrag.kuenstlerId,
            'custom_name': null,
            'sort_name': sortiername,
            'updated_at': jetzt,
          });
        }
      }
    });
  }
}
