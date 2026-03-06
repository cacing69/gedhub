import 'package:drift/drift.dart' show OrderingTerm, Value;
import 'package:dartz/dartz.dart';
import 'package:gedhub/core/database/app_database.dart';
import 'package:gedhub/core/domain/repository_failure.dart';
import 'package:gedhub/features/projects/domain/project.dart';
import 'package:gedhub/features/projects/domain/projects_repository.dart';

/// Implementasi [ProjectsRepository] dengan Drift (SQLite).
class ProjectsRepositoryImpl implements ProjectsRepository {
  ProjectsRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<Either<RepositoryFailure, Project?>> getProjectById(int id) async {
    try {
      final row = await (_db.select(_db.projects)..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      if (row == null) return right(null);
      return right(Project(
        id: row.id,
        name: row.name,
        description: row.description,
        locale: row.locale,
        createdAt: row.createdAt,
      ));
    } catch (e) {
      return left(RepositoryFailure.database('getProjectById: $e'));
    }
  }

  @override
  Future<Either<RepositoryFailure, int>> createProject({
    required String name,
    String? description,
    String? locale,
  }) async {
    try {
      final id = await _db.into(_db.projects).insert(
        ProjectsCompanion.insert(
          name: name,
          description: Value(description),
          locale: Value(locale),
        ),
      );
      return right(id);
    } catch (e) {
      return left(RepositoryFailure.database('createProject: $e'));
    }
  }

  @override
  Future<Either<RepositoryFailure, bool>> updateProject(
    int id, {
    required String name,
    String? description,
    String? locale,
  }) async {
    try {
      final updated = await (_db.update(_db.projects)..where((t) => t.id.equals(id)))
          .write(
        ProjectsCompanion(
          name: Value(name),
          description: Value(description),
          locale: Value(locale),
        ),
      );
      return right(updated > 0);
    } catch (e) {
      return left(RepositoryFailure.database('updateProject: $e'));
    }
  }

  @override
  Future<Either<RepositoryFailure, bool>> deleteProject(int id) async {
    try {
      final deleted =
          await (_db.delete(_db.projects)..where((t) => t.id.equals(id))).go();
      return right(deleted > 0);
    } catch (e) {
      return left(RepositoryFailure.database('deleteProject: $e'));
    }
  }

  @override
  Stream<List<Project>> watchProjects() {
    final query = _db.select(_db.projects)
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]);
    return query.watch().map(
          (rows) => rows
              .map(
                (row) => Project(
                  id: row.id,
                  name: row.name,
                  description: row.description,
                  locale: row.locale,
                  createdAt: row.createdAt,
                ),
              )
              .toList(),
        );
  }
}
