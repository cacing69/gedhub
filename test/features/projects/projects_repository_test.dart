import 'package:drift/drift.dart' show DatabaseConnection;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gedhub/core/database/app_database.dart';
import 'package:gedhub/features/projects/domain/projects_repository.dart';
import 'package:gedhub/features/projects/data/projects_repository_impl.dart';

void main() {
  late AppDatabase db;
  late ProjectsRepository repo;

  setUp(() {
    db = AppDatabase(
      DatabaseConnection(
        NativeDatabase.memory(),
        closeStreamsSynchronously: true,
      ),
    );
    repo = ProjectsRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('ProjectsRepository', () {
    test('createProject returns new id and getProjectById returns project',
        () async {
      final createResult = await repo.createProject(
        name: 'Keluarga XYZ',
        description: 'Deskripsi singkat',
        locale: 'id_ID',
      );
      expect(createResult.isRight(), true);
      final id = createResult.getOrElse(() => 0);
      expect(id, greaterThan(0));

      final getResult = await repo.getProjectById(id);
      expect(getResult.isRight(), true);
      final project = getResult.getOrElse(() => null);
      expect(project, isNotNull);
      expect(project!.id, id);
      expect(project.name, 'Keluarga XYZ');
      expect(project.description, 'Deskripsi singkat');
      expect(project.locale, 'id_ID');
      expect(project.createdAt, isNotNull);
    });

    test('createProject with only required name', () async {
      final createResult = await repo.createProject(name: 'Minimal');
      expect(createResult.isRight(), true);
      final id = createResult.getOrElse(() => 0);
      expect(id, greaterThan(0));

      final getResult = await repo.getProjectById(id);
      expect(getResult.isRight(), true);
      final project = getResult.getOrElse(() => null);
      expect(project!.name, 'Minimal');
      expect(project.description, isNull);
      expect(project.locale, isNull);
    });

    test('getProjectById returns null for non-existent id', () async {
      final getResult = await repo.getProjectById(99999);
      expect(getResult.isRight(), true);
      final project = getResult.getOrElse(() => null);
      expect(project, isNull);
    });

    test('watchProjects emits empty then list after create', () async {
      final stream = repo.watchProjects();
      final list = await stream.first;
      expect(list, isEmpty);

      final createResult = await repo.createProject(name: 'First');
      expect(createResult.isRight(), true);
      final id = createResult.getOrElse(() => 0);
      final list2 = await stream.first;
      expect(list2.length, 1);
      expect(list2.first.id, id);
      expect(list2.first.name, 'First');
    });

    test('watchProjects returns all projects ordered by createdAt desc', () async {
      final r1 = await repo.createProject(name: 'Older');
      expect(r1.isRight(), true);
      await Future.delayed(const Duration(milliseconds: 50));
      final r2 = await repo.createProject(name: 'Newer');
      expect(r2.isRight(), true);

      final list = await repo.watchProjects().first;
      expect(list.length, 2);
      final names = list.map((p) => p.name).toList();
      expect(names, contains('Older'));
      expect(names, contains('Newer'));
      expect(list.first.createdAt.isAfter(list.last.createdAt) ||
          list.first.createdAt.isAtSameMomentAs(list.last.createdAt), isTrue);
    });

    test('updateProject changes name and getProjectById returns updated data',
        () async {
      final createResult = await repo.createProject(
        name: 'Original',
        description: 'Desc',
        locale: 'en_US',
      );
      expect(createResult.isRight(), true);
      final id = createResult.getOrElse(() => 0);

      final updateResult = await repo.updateProject(
        id,
        name: 'Updated Name',
        description: 'New desc',
        locale: 'id_ID',
      );
      expect(updateResult.isRight(), true);
      expect(updateResult.getOrElse(() => false), isTrue);

      final getResult = await repo.getProjectById(id);
      expect(getResult.isRight(), true);
      final project = getResult.getOrElse(() => null);
      expect(project, isNotNull);
      expect(project!.name, 'Updated Name');
      expect(project.description, 'New desc');
      expect(project.locale, 'id_ID');
    });

    test('updateProject returns false for non-existent id', () async {
      final updateResult = await repo.updateProject(
        99999,
        name: 'No such project',
      );
      expect(updateResult.isRight(), true);
      expect(updateResult.getOrElse(() => true), isFalse);
    });

    test('deleteProject removes project and getProjectById returns null',
        () async {
      final createResult = await repo.createProject(name: 'To Delete');
      expect(createResult.isRight(), true);
      final id = createResult.getOrElse(() => 0);

      final deleteResult = await repo.deleteProject(id);
      expect(deleteResult.isRight(), true);
      expect(deleteResult.getOrElse(() => false), isTrue);

      final getResult = await repo.getProjectById(id);
      expect(getResult.isRight(), true);
      final project = getResult.getOrElse(() => null);
      expect(project, isNull);
    });

    test('deleteProject returns false for non-existent id', () async {
      final deleteResult = await repo.deleteProject(99999);
      expect(deleteResult.isRight(), true);
      expect(deleteResult.getOrElse(() => true), isFalse);
    });

    test('watchProjects no longer includes project after delete', () async {
      final createResult = await repo.createProject(name: 'Will Delete');
      expect(createResult.isRight(), true);
      final id = createResult.getOrElse(() => 0);

      final deleteResult = await repo.deleteProject(id);
      expect(deleteResult.isRight(), true);

      final list = await repo.watchProjects().first;
      expect(list.where((p) => p.id == id), isEmpty);
    });
  });
}
