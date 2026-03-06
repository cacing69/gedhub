import 'package:dartz/dartz.dart';
import 'package:gedhub/core/domain/repository_failure.dart';
import 'package:gedhub/features/peoples/domain/person.dart';
import 'package:gedhub/features/peoples/domain/persons_repository.dart';

/// Fake [PersonsRepository] untuk test: data in-memory, tidak pakai database.
class FakePersonsRepository implements PersonsRepository {
  FakePersonsRepository() : _persons = [];

  final List<Person> _persons;
  int _nextId = 1;

  @override
  Future<Either<RepositoryFailure, Person?>> getPersonById(int id) async {
    try {
      final list = _persons.where((p) => p.id == id).toList();
      return right(list.isEmpty ? null : list.first);
    } catch (_) {
      return left(RepositoryFailure.database('FakePersonsRepository.getPersonById'));
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
    final id = _nextId++;
    _persons.add(Person(
      id: id,
      projectId: projectId,
      givenName: givenName,
      surname: surname,
      nickname: nickname,
      gender: gender,
      birthDate: birthDate,
      deathDate: deathDate,
      isLiving: isLiving ?? true,
      notes: notes,
    ));
    return right(id);
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
    final index = _persons.indexWhere((p) => p.id == id);
    if (index < 0) return right(false);
    _persons[index] = Person(
      id: id,
      projectId: _persons[index].projectId,
      givenName: givenName,
      surname: surname,
      nickname: nickname,
      gender: gender,
      birthDate: birthDate,
      deathDate: deathDate,
      isLiving: isLiving ?? _persons[index].isLiving,
      notes: notes,
    );
    return right(true);
  }

  @override
  Future<Either<RepositoryFailure, bool>> deletePerson(int id) async {
    final before = _persons.length;
    _persons.removeWhere((p) => p.id == id);
    return right(_persons.length < before);
  }

  @override
  Stream<List<Person>> watchPersons(int projectId) {
    return Stream.value(
      _persons.where((p) => p.projectId == projectId).toList(),
    );
  }
}
