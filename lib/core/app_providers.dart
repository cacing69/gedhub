import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:gedhub/core/database/app_database.dart';
import 'package:gedhub/features/projects/domain/project.dart';
import 'package:gedhub/features/projects/domain/projects_repository.dart';
import 'package:gedhub/features/projects/data/projects_repository_impl.dart';
import 'package:gedhub/features/peoples/domain/person.dart';
import 'package:gedhub/features/peoples/domain/persons_repository.dart';
import 'package:gedhub/features/peoples/data/persons_repository_impl.dart';
import 'package:gedhub/features/peoples/domain/contacts_repository.dart';
import 'package:gedhub/features/peoples/data/contacts_repository_impl.dart';
import 'package:gedhub/features/peoples/domain/person_relations_repository.dart';
import 'package:gedhub/features/peoples/data/person_relations_repository_impl.dart';
import 'package:gedhub/features/peoples/domain/person_relation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_providers.g.dart';

const String _kCurrentProjectIdKey = 'current_project_id';
const String _kThemeModeKey = 'theme_mode';

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

/// Repository untuk CRUD project GEDCOM (interface; impl: [ProjectsRepositoryImpl]).
@riverpod
ProjectsRepository projectsRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return ProjectsRepositoryImpl(db);
}

/// Daftar semua project GEDCOM yang tersimpan secara lokal.
@riverpod
Stream<List<Project>> projectsStream(Ref ref) {
  final repo = ref.watch(projectsRepositoryProvider);
  return repo.watchProjects();
}

/// Project GEDCOM yang saat ini aktif (digunakan untuk switching multi‑project).
/// keepAlive: true agar pilihan tetap tersimpan saat pindah tab.
/// Nilai disimpan ke SharedPreferences agar tetap terpilih setelah app ditutup.
@Riverpod(keepAlive: true)
class CurrentProjectId extends _$CurrentProjectId {
  @override
  int? build() {
    scheduleMicrotask(_loadSavedProjectId);
    return null;
  }

  void select(int? id) {
    state = id;
    _persist(id);
  }

  Future<void> _loadSavedProjectId() async {
    try {
      final prefs = await ref.read(sharedPreferencesProvider.future);
      final saved = prefs.getInt(_kCurrentProjectIdKey);
      if (saved == null) return;
      final repo = ref.read(projectsRepositoryProvider);
      final result = await repo.getProjectById(saved);
      result.fold(
        (_) async {
          state = null;
          await prefs.remove(_kCurrentProjectIdKey);
        },
        (project) {
          if (project == null) {
            state = null;
            prefs.remove(_kCurrentProjectIdKey);
          } else {
            state = saved;
          }
        },
      );
    } catch (_) {}
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

/// Persons repository (interface; impl: [PersonsRepositoryImpl]).
@riverpod
PersonsRepository personsRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return PersonsRepositoryImpl(db);
}

/// Contacts repository (interface; impl: [ContactsRepositoryImpl]).
@riverpod
ContactsRepository contactsRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return ContactsRepositoryImpl(db);
}

/// Stream list persons untuk project aktif.
/// Mengembalikan stream kosong bila belum ada project yang dipilih.
@riverpod
Stream<List<Person>> personsStream(Ref ref) {
  final projectId = ref.watch(currentProjectIdProvider);
  final repo = ref.watch(personsRepositoryProvider);
  if (projectId == null) return Stream.value([]);
  return repo.watchPersons(projectId);
}

/// Stream list contacts untuk satu person.
@riverpod
Stream<List<Contact>> contactsStreamProvider(Ref ref, int personId) {
  final repo = ref.watch(contactsRepositoryProvider);
  return repo.watchContacts(personId);
}

/// Person relations repository (interface; impl: [PersonRelationsRepositoryImpl]).
@riverpod
PersonRelationsRepository personRelationsRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return PersonRelationsRepositoryImpl(db);
}

/// Stream daftar relasi (dengan label + person lain) untuk satu person.
@riverpod
Stream<List<PersonRelationDisplay>> personRelationDisplaysStream(Ref ref, int personId) {
  final repo = ref.watch(personRelationsRepositoryProvider);
  return repo.watchRelationDisplaysForPerson(personId);
}

/// Mode tema aplikasi (light / dark / system). Disimpan di SharedPreferences
/// agar pilihan tetap dipakai saat app dibuka kembali.
@Riverpod(keepAlive: true)
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeMode build() {
    scheduleMicrotask(_loadSavedThemeMode);
    return ThemeMode.system;
  }

  Future<void> _loadSavedThemeMode() async {
    try {
      final prefs = await ref.read(sharedPreferencesProvider.future);
      final saved = prefs.getString(_kThemeModeKey);
      // Tanpa preferensi tersimpan → ikuti tema sistem (default).
      final mode = switch (saved) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        'system' => ThemeMode.system,
        _ => ThemeMode.system,
      };
      state = mode;
    } catch (_) {
      state = ThemeMode.system;
    }
  }

  /// Mengubah mode tema dan menyimpan ke SharedPreferences. Menunggu persist
  /// selesai agar pilihan tetap dipakai saat app dibuka selanjutnya.
  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await _persist(mode);
  }

  Future<void> _persist(ThemeMode mode) async {
    try {
      final prefs = await ref.read(sharedPreferencesProvider.future);
      final value = switch (mode) {
        ThemeMode.light => 'light',
        ThemeMode.dark => 'dark',
        ThemeMode.system => 'system',
      };
      await prefs.setString(_kThemeModeKey, value);
    } catch (_) {}
  }
}
