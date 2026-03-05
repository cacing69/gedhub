import 'package:drift/drift.dart' show DatabaseConnection;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gedhub/core/database/app_database.dart';
import 'package:gedhub/features/projects/domain/projects_repository.dart';

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
    repo = ProjectsRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('ProjectsRepository', () {
    test('createProject returns new id and getProjectById returns project',
        () async {
      final id = await repo.createProject(
        name: 'Keluarga XYZ',
        description: 'Deskripsi singkat',
        locale: 'id_ID',
      );
      expect(id, greaterThan(0));

      final project = await repo.getProjectById(id);
      expect(project, isNotNull);
      expect(project!.id, id);
      expect(project.name, 'Keluarga XYZ');
      expect(project.description, 'Deskripsi singkat');
      expect(project.locale, 'id_ID');
      expect(project.createdAt, isNotNull);
    });

    test('createProject with only required name', () async {
      final id = await repo.createProject(name: 'Minimal');
      expect(id, greaterThan(0));

      final project = await repo.getProjectById(id);
      expect(project!.name, 'Minimal');
      expect(project.description, isNull);
      expect(project.locale, isNull);
    });

    test('getProjectById returns null for non-existent id', () async {
      final project = await repo.getProjectById(99999);
      expect(project, isNull);
    });

    test('watchProjects emits empty then list after create', () async {
      final stream = repo.watchProjects();
      final list = await stream.first;
      expect(list, isEmpty);

      final id = await repo.createProject(name: 'First');
      final list2 = await stream.first;
      expect(list2.length, 1);
      expect(list2.first.id, id);
      expect(list2.first.name, 'First');
    });

    test('watchProjects returns all projects ordered by createdAt desc', () async {
      await repo.createProject(name: 'Older');
      await Future.delayed(const Duration(milliseconds: 50));
      await repo.createProject(name: 'Newer');

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
      final id = await repo.createProject(
        name: 'Original',
        description: 'Desc',
        locale: 'en_US',
      );
      final updated = await repo.updateProject(
        id,
        name: 'Updated Name',
        description: 'New desc',
        locale: 'id_ID',
      );
      expect(updated, isTrue);

      final project = await repo.getProjectById(id);
      expect(project, isNotNull);
      expect(project!.name, 'Updated Name');
      expect(project.description, 'New desc');
      expect(project.locale, 'id_ID');
    });

    test('updateProject returns false for non-existent id', () async {
      final updated = await repo.updateProject(
        99999,
        name: 'No such project',
      );
      expect(updated, isFalse);
    });

    test('deleteProject removes project and getProjectById returns null',
        () async {
      final id = await repo.createProject(name: 'To Delete');
      final deleted = await repo.deleteProject(id);
      expect(deleted, isTrue);

      final project = await repo.getProjectById(id);
      expect(project, isNull);
    });

    test('deleteProject returns false for non-existent id', () async {
      final deleted = await repo.deleteProject(99999);
      expect(deleted, isFalse);
    });

    test('watchProjects no longer includes project after delete', () async {
      final id = await repo.createProject(name: 'Will Delete');
      await repo.deleteProject(id);

      final list = await repo.watchProjects().first;
      expect(list.where((p) => p.id == id), isEmpty);
    });
  });
}
