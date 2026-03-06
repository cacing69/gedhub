import 'package:drift/drift.dart';
import 'package:dartz/dartz.dart';
import 'package:gedhub/core/database/app_database.dart';
import 'package:gedhub/core/domain/repository_failure.dart';
import 'package:gedhub/features/peoples/domain/person.dart';
import 'package:gedhub/features/peoples/domain/contacts_repository.dart';

/// Implementasi [ContactsRepository] dengan Drift (SQLite).
class ContactsRepositoryImpl implements ContactsRepository {
  ContactsRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<Either<RepositoryFailure, int>> createContact({
    required int projectId,
    required int personId,
    required String provider,
    required String contactType,
    required String value,
    String? label,
    String? providerContactId,
    int? sortOrder,
    String? notes,
  }) async {
    try {
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final id = await _db.into(_db.contacts).insert(
        ContactsCompanion.insert(
          projectId: projectId,
          personId: personId,
          provider: provider,
          contactType: contactType,
          value: value,
          label: Value(label),
          providerContactId: Value(providerContactId),
          sortOrder: Value(sortOrder ?? 0),
          notes: Value(notes),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
      return right(id);
    } catch (e) {
      return left(RepositoryFailure.database('createContact: $e'));
    }
  }

  @override
  Future<Either<RepositoryFailure, bool>> updateContact(
    int id, {
    required String provider,
    required String contactType,
    required String value,
    String? label,
    String? providerContactId,
    int? sortOrder,
    String? notes,
  }) async {
    try {
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final updated =
          await (_db.update(_db.contacts)..where((c) => c.id.equals(id))).write(
        ContactsCompanion(
          provider: Value(provider),
          contactType: Value(contactType),
          value: Value(value),
          label: Value(label),
          providerContactId: Value(providerContactId),
          sortOrder: sortOrder != null ? Value(sortOrder) : const Value.absent(),
          notes: Value(notes),
          updatedAt: Value(now),
        ),
      );
      return right(updated > 0);
    } catch (e) {
      return left(RepositoryFailure.database('updateContact: $e'));
    }
  }

  @override
  Future<Either<RepositoryFailure, bool>> deleteContact(int id) async {
    try {
      final deleted =
          await (_db.delete(_db.contacts)..where((c) => c.id.equals(id))).go();
      return right(deleted > 0);
    } catch (e) {
      return left(RepositoryFailure.database('deleteContact: $e'));
    }
  }

  @override
  Stream<List<Contact>> watchContacts(int personId) {
    final query = _db.select(_db.contacts)
      ..where((c) => c.personId.equals(personId))
      ..orderBy([(c) => OrderingTerm.asc(c.sortOrder)]);
    return query.watch().map((rows) => rows.map(_rowToContact).toList());
  }

  Contact _rowToContact(ContactRow row) => Contact(
        id: row.id,
        projectId: row.projectId,
        personId: row.personId,
        provider: row.provider,
        contactType: row.contactType,
        value: row.value,
        label: row.label,
        providerContactId: row.providerContactId,
        sortOrder: row.sortOrder,
        notes: row.notes,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );
}
