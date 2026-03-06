import 'package:drift/drift.dart';
import 'package:dartz/dartz.dart';
import 'package:gedhub/core/database/app_database.dart';
import 'package:gedhub/core/domain/repository_failure.dart';
import 'package:gedhub/features/peoples/domain/person.dart';
import 'package:gedhub/features/peoples/domain/persons_repository.dart';

/// Implementasi [PersonsRepository] dengan Drift (SQLite).
class PersonsRepositoryImpl implements PersonsRepository {
  PersonsRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<Either<RepositoryFailure, Person?>> getPersonById(int id) async {
    try {
      final row = await (_db.select(_db.persons)..where((p) => p.id.equals(id)))
          .getSingleOrNull();
      if (row == null) return right(null);
      return right(_rowToPerson(row));
    } catch (e) {
      return left(RepositoryFailure.database('getPersonById: $e'));
    }
  }

  @override
  Future<Either<RepositoryFailure, int>> createPerson({
    required int projectId,
    required String givenName,
    required String surname,
    String? nickname,
    String? gender,
    String? birthDate,
    String? deathDate,
    bool? isLiving,
    String? notes,
  }) async {
    try {
      final id = await _db.into(_db.persons).insert(
        PersonsCompanion.insert(
          projectId: projectId,
          givenName: givenName,
          surname: surname,
          nickname: Value(nickname),
          gender: gender ?? '',
          birthDate: Value(birthDate),
          deathDate: Value(deathDate),
          isLiving: Value((isLiving ?? true) ? 1 : 0),
          notes: Value(notes),
        ),
      );
      return right(id);
    } catch (e) {
      return left(RepositoryFailure.database('createPerson: $e'));
    }
  }

  @override
  Future<Either<RepositoryFailure, bool>> updatePerson(
    int id, {
    required String givenName,
    required String surname,
    String? nickname,
    String? gender,
    String? birthDate,
    String? deathDate,
    bool? isLiving,
    String? notes,
  }) async {
    try {
      final updated = await (_db.update(_db.persons)..where((p) => p.id.equals(id)))
          .write(
        PersonsCompanion(
          givenName: Value(givenName),
          surname: Value(surname),
          nickname: Value(nickname),
          gender: Value(gender ?? ''),
          birthDate: Value(birthDate),
          deathDate: Value(deathDate),
          isLiving: isLiving != null ? Value(isLiving ? 1 : 0) : const Value.absent(),
          notes: Value(notes),
        ),
      );
      return right(updated > 0);
    } catch (e) {
      return left(RepositoryFailure.database('updatePerson: $e'));
    }
  }

  @override
  Future<Either<RepositoryFailure, bool>> deletePerson(int id) async {
    try {
      final deleted =
          await (_db.delete(_db.persons)..where((p) => p.id.equals(id))).go();
      return right(deleted > 0);
    } catch (e) {
      return left(RepositoryFailure.database('deletePerson: $e'));
    }
  }

  @override
  Stream<List<Person>> watchPersons(int projectId) {
    final query = _db.select(_db.persons)
      ..where((p) => p.projectId.equals(projectId))
      ..orderBy([
        (p) => OrderingTerm.asc(p.givenName),
        (p) => OrderingTerm.asc(p.surname),
      ]);
    return query.watch().map((rows) => rows.map(_rowToPerson).toList());
  }

  Person _rowToPerson(PersonRow row) => Person(
        id: row.id,
        projectId: row.projectId,
        gedcomXref: row.gedcomXref,
        givenName: row.givenName,
        surname: row.surname,
        nickname: row.nickname,
        gender: row.gender,
        birthDate: row.birthDate,
        deathDate: row.deathDate,
        isLiving: row.isLiving != 0,
        notes: row.notes,
      );
}
