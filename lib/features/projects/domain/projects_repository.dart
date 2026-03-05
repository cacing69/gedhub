import 'package:drift/drift.dart' show OrderingTerm, Value;
import 'package:gedhub/core/database/app_database.dart';
import 'package:gedhub/features/projects/domain/project.dart';

class ProjectsRepository {
  ProjectsRepository(this._db);

  final AppDatabase _db;

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

