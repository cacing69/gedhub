import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:gedhub/core/database/app_database.dart';
import 'package:gedhub/features/projects/domain/project.dart';
import 'package:gedhub/features/projects/domain/projects_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_providers.g.dart';

const String _kCurrentProjectIdKey = 'current_project_id';

@riverpod
Future<SharedPreferences> sharedPreferences(Ref ref) async {
  return SharedPreferences.getInstance();
}

/// Singleton database instance: keepAlive agar hanya satu AppDatabase yang dipakai
/// dan Drift tidak memperingatkan "database class created multiple times".
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  return AppDatabase();
}

@riverpod
ProjectsRepository projectsRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return ProjectsRepository(db);
}

/// Daftar semua project GEDCOM yang tersimpan secara lokal.
@riverpod
Stream<List<Project>> projectsStream(Ref ref) {
  final repo = ref.watch(projectsRepositoryProvider);
  return repo.watchProjects();
}

/// Project GEDCOM yang saat ini aktif (digunakan untuk operasi peoples/tree).
/// keepAlive: true agar pilihan tetap tersimpan saat pindah tab.
/// Nilai disimpan ke SharedPreferences agar tetap terpilih setelah app ditutup.
@Riverpod(keepAlive: true)
class CurrentProjectId extends _$CurrentProjectId {
  @override
  int? build() {
    scheduleMicrotask(_loadSavedProjectId);
    return null;
  }

  Future<void> _loadSavedProjectId() async {
    try {
      final prefs = await ref.read(sharedPreferencesProvider.future);
      final saved = prefs.getInt(_kCurrentProjectIdKey);
      if (saved != null) state = saved;
    } catch (_) {}
  }

  void select(int? id) {
    state = id;
    _persist(id);
  }

  Future<void> _persist(int? id) async {
    try {
      final prefs = await ref.read(sharedPreferencesProvider.future);
      if (id != null) {
        await prefs.setInt(_kCurrentProjectIdKey, id);
      } else {
        await prefs.remove(_kCurrentProjectIdKey);
      }
    } catch (_) {}
  }
}

