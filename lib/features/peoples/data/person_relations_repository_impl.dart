import 'package:drift/drift.dart';
import 'package:dartz/dartz.dart';
import 'package:gedhub/core/database/app_database.dart';
import 'package:gedhub/core/domain/repository_failure.dart';
import 'package:gedhub/features/peoples/domain/person.dart';
import 'package:gedhub/features/peoples/domain/person_relation.dart';
import 'package:gedhub/features/peoples/domain/person_relations_repository.dart';

/// Implementasi [PersonRelationsRepository] dengan Drift.
class PersonRelationsRepositoryImpl implements PersonRelationsRepository {
  PersonRelationsRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<Either<RepositoryFailure, int>> addRelation({
    required int projectId,
    required int personId,
    required int relatedPersonId,
    required String kind,
  }) async {
    if (personId == relatedPersonId) {
      return left(RepositoryFailure.database('Person tidak bisa berelasi dengan diri sendiri'));
    }
    try {
      final id = await _db.into(_db.personRelations).insert(
        PersonRelationsCompanion.insert(
          projectId: projectId,
          personId: personId,
          relatedPersonId: relatedPersonId,
          kind: kind,
        ),
      );
      return right(id);
    } catch (e) {
      return left(RepositoryFailure.database('addRelation: $e'));
    }
  }

  @override
  Future<Either<RepositoryFailure, bool>> removeRelation(int relationId) async {
    try {
      final deleted = await (_db.delete(_db.personRelations)
            ..where((r) => r.id.equals(relationId)))
          .go();
      return right(deleted > 0);
    } catch (e) {
      return left(RepositoryFailure.database('removeRelation: $e'));
    }
  }

  @override
  Stream<List<PersonRelationDisplay>> watchRelationDisplaysForPerson(int personId) {
    final query = _db.select(_db.personRelations)
      ..where((r) => r.personId.equals(personId) | r.relatedPersonId.equals(personId));
    return query.watch().asyncMap((rows) => _toDisplays(personId, rows));
  }

  Future<List<PersonRelationDisplay>> _toDisplays(int currentPersonId, List<PersonRelationRow> rows) async {
    if (rows.isEmpty) return [];
    final otherIds = rows.map((r) => r.personId == currentPersonId ? r.relatedPersonId : r.personId).toSet().toList();
    final personRows = await (_db.select(_db.persons)..where((p) => p.id.isIn(otherIds))).get();
    final personById = {for (final row in personRows) row.id: _rowToPerson(row)};
    return rows.map((r) {
      final otherId = r.personId == currentPersonId ? r.relatedPersonId : r.personId;
      final other = personById[otherId];
      if (other == null) return null;
      final kindEnum = PersonRelationKind.fromString(r.kind);
      final label = kindEnum != null
          ? (r.personId == currentPersonId ? kindEnum.labelAsFrom : kindEnum.labelAsTo)
          : r.kind;
      return PersonRelationDisplay(
        relation: PersonRelation(
          id: r.id,
          projectId: r.projectId,
          personId: r.personId,
          relatedPersonId: r.relatedPersonId,
          kind: r.kind,
        ),
        otherPerson: other,
        label: label,
      );
    }).whereType<PersonRelationDisplay>().toList();
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
        birthPlaceId: null,
        deathPlaceId: null,
        isLiving: row.isLiving != 0,
        notes: row.notes,
      );
}
