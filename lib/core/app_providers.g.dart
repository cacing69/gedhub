// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = SharedPreferencesProvider._();

final class SharedPreferencesProvider
    extends
        $FunctionalProvider<
          AsyncValue<SharedPreferences>,
          SharedPreferences,
          FutureOr<SharedPreferences>
        >
    with
        $FutureModifier<SharedPreferences>,
        $FutureProvider<SharedPreferences> {
  SharedPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferencesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesHash();

  @$internal
  @override
  $FutureProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SharedPreferences> create(Ref ref) {
    return sharedPreferences(ref);
  }
}

String _$sharedPreferencesHash() => r'6c03b929f567eb6f97608f6208b95744ffee3bfd';

/// Singleton database instance: keepAlive agar hanya satu AppDatabase yang dipakai
/// dan Drift tidak memperingatkan "database class created multiple times".

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

/// Singleton database instance: keepAlive agar hanya satu AppDatabase yang dipakai
/// dan Drift tidak memperingatkan "database class created multiple times".

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  /// Singleton database instance: keepAlive agar hanya satu AppDatabase yang dipakai
  /// dan Drift tidak memperingatkan "database class created multiple times".
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'8c69eb46d45206533c176c88a926608e79ca927d';

@ProviderFor(projectsRepository)
final projectsRepositoryProvider = ProjectsRepositoryProvider._();

final class ProjectsRepositoryProvider
    extends
        $FunctionalProvider<
          ProjectsRepository,
          ProjectsRepository,
          ProjectsRepository
        >
    with $Provider<ProjectsRepository> {
  ProjectsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$projectsRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProjectsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProjectsRepository create(Ref ref) {
    return projectsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProjectsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProjectsRepository>(value),
    );
  }
}

String _$projectsRepositoryHash() =>
    r'197954d74c6bee7ccaa730898f4d033ce5581595';

/// Daftar semua project GEDCOM yang tersimpan secara lokal.

@ProviderFor(projectsStream)
final projectsStreamProvider = ProjectsStreamProvider._();

/// Daftar semua project GEDCOM yang tersimpan secara lokal.

final class ProjectsStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Project>>,
          List<Project>,
          Stream<List<Project>>
        >
    with $FutureModifier<List<Project>>, $StreamProvider<List<Project>> {
  /// Daftar semua project GEDCOM yang tersimpan secara lokal.
  ProjectsStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectsStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$projectsStreamHash();

  @$internal
  @override
  $StreamProviderElement<List<Project>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Project>> create(Ref ref) {
    return projectsStream(ref);
  }
}

String _$projectsStreamHash() => r'217ff2ceb0ccb470d94579cec06a75d6b7ab5fe5';

/// Project GEDCOM yang saat ini aktif (digunakan untuk operasi peoples/tree).
/// keepAlive: true agar pilihan tetap tersimpan saat pindah tab.
/// Nilai disimpan ke SharedPreferences agar tetap terpilih setelah app ditutup.

@ProviderFor(CurrentProjectId)
final currentProjectIdProvider = CurrentProjectIdProvider._();

/// Project GEDCOM yang saat ini aktif (digunakan untuk operasi peoples/tree).
/// keepAlive: true agar pilihan tetap tersimpan saat pindah tab.
/// Nilai disimpan ke SharedPreferences agar tetap terpilih setelah app ditutup.
final class CurrentProjectIdProvider
    extends $NotifierProvider<CurrentProjectId, int?> {
  /// Project GEDCOM yang saat ini aktif (digunakan untuk operasi peoples/tree).
  /// keepAlive: true agar pilihan tetap tersimpan saat pindah tab.
  /// Nilai disimpan ke SharedPreferences agar tetap terpilih setelah app ditutup.
  CurrentProjectIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentProjectIdProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentProjectIdHash();

  @$internal
  @override
  CurrentProjectId create() => CurrentProjectId();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int?>(value),
    );
  }
}

String _$currentProjectIdHash() => r'50b51812dbc5027cbba66ddb811bbbaff6cd51a3';

/// Project GEDCOM yang saat ini aktif (digunakan untuk operasi peoples/tree).
/// keepAlive: true agar pilihan tetap tersimpan saat pindah tab.
/// Nilai disimpan ke SharedPreferences agar tetap terpilih setelah app ditutup.

abstract class _$CurrentProjectId extends $Notifier<int?> {
  int? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int?, int?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int?, int?>,
              int?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
