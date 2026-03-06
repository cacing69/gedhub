import 'package:dartz/dartz.dart';
import 'package:gedhub/core/domain/repository_failure.dart';
import 'package:gedhub/features/peoples/domain/person.dart';

/// Abstraksi repository person (implementasi: [PersonsRepositoryImpl], fake: untuk test).
abstract interface class PersonsRepository {
  Future<Either<RepositoryFailure, Person?>> getPersonById(int id);
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
  });
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
  });
  Future<Either<RepositoryFailure, bool>> deletePerson(int id);
  Stream<List<Person>> watchPersons(int projectId);
}
