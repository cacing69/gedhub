import 'package:drift/drift.dart' show OrderingTerm, Value;
import 'package:gedhub/core/database/app_database.dart';
import 'package:gedhub/features/projects/domain/project.dart';

class ProjectsRepository {
  ProjectsRepository(this._db);

  final AppDatabase _db;

  /// Mengembalikan project dengan [id], atau null jika tidak ada (untuk validasi current project).
  Future<Project?> getProjectById(int id) async {
    final row = await (_db.select(_db.projects)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (row == null) return null;
    return Project(
      id: row.id,
      name: row.name,
      description: row.description,
      locale: row.locale,
      createdAt: row.createdAt,
    );
  }

  Future<int> createProject({
    required String name,
    String? description,
    String? locale,
  }) {
    return _db.into(_db.projects).insert(
          ProjectsCompanion.insert(
            name: name,
            description: Value(description),
            locale: Value(locale),
          ),
        );
  }

  /// Mengubah project dengan [id]. Mengembalikan true jika ada baris yang di-update.
  Future<bool> updateProject(
    int id, {
    required String name,
    String? description,
    String? locale,
  }) async {
    final updated = await (_db.update(_db.projects)..where((t) => t.id.equals(id)))
        .write(
      ProjectsCompanion(
        name: Value(name),
        description: Value(description),
        locale: Value(locale),
      ),
    );
    return updated > 0;
  }

  /// Menghapus project dengan [id]. Mengembalikan true jika ada baris yang dihapus.
  Future<bool> deleteProject(int id) async {
    final deleted = await (_db.delete(_db.projects)..where((t) => t.id.equals(id))).go();
    return deleted > 0;
  }

  Stream<List<Project>> watchProjects() {
    final query = _db.select(_db.projects)
      ..orderBy([
        (tbl) => OrderingTerm.desc(tbl.createdAt),
      ]);
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

