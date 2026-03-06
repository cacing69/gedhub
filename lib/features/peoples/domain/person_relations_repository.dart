import 'package:dartz/dartz.dart';
import 'package:gedhub/core/domain/repository_failure.dart';
import 'package:gedhub/features/peoples/domain/person_relation.dart';

/// Repository untuk relasi antar person (parent, spouse, sibling).
/// Relasi bersifat koneksi yang bisa ditambah dan dilepas.
abstract interface class PersonRelationsRepository {
  /// Menambah relasi antara dua person (orang yang sudah ada).
  /// Untuk parent: [personId] = orang tua, [relatedPersonId] = anak.
  /// Untuk spouse/sibling: urutan bebas (satu baris cukup).
  Future<Either<RepositoryFailure, int>> addRelation({
    required int projectId,
    required int personId,
    required int relatedPersonId,
    required String kind,
  });

  /// Menghapus relasi by id.
  Future<Either<RepositoryFailure, bool>> removeRelation(int relationId);

  /// Stream daftar relasi untuk satu person (dengan data person di sisi lain + label).
  Stream<List<PersonRelationDisplay>> watchRelationDisplaysForPerson(int personId);
}
