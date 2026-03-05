import 'package:drift/drift.dart' show Value;
import 'package:gedhub_app/core/database/app_database.dart';

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

  Future<void> dispose() async {
    await _db.close();
  }
}

