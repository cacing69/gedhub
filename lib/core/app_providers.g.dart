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

/// Repository untuk CRUD project GEDCOM (interface; impl: [ProjectsRepositoryImpl]).

@ProviderFor(projectsRepository)
final projectsRepositoryProvider = ProjectsRepositoryProvider._();

/// Repository untuk CRUD project GEDCOM (interface; impl: [ProjectsRepositoryImpl]).

final class ProjectsRepositoryProvider
    extends
        $FunctionalProvider<
          ProjectsRepository,
          ProjectsRepository,
          ProjectsRepository
        >
    with $Provider<ProjectsRepository> {
  /// Repository untuk CRUD project GEDCOM (interface; impl: [ProjectsRepositoryImpl]).
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
    r'372ea8c93734362dbf4c6a2964d49cfac04030e7';

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

/// Project GEDCOM yang saat ini aktif (digunakan untuk switching multi‑project).
/// keepAlive: true agar pilihan tetap tersimpan saat pindah tab.
/// Nilai disimpan ke SharedPreferences agar tetap terpilih setelah app ditutup.

@ProviderFor(CurrentProjectId)
final currentProjectIdProvider = CurrentProjectIdProvider._();

/// Project GEDCOM yang saat ini aktif (digunakan untuk switching multi‑project).
/// keepAlive: true agar pilihan tetap tersimpan saat pindah tab.
/// Nilai disimpan ke SharedPreferences agar tetap terpilih setelah app ditutup.
final class CurrentProjectIdProvider
    extends $NotifierProvider<CurrentProjectId, int?> {
  /// Project GEDCOM yang saat ini aktif (digunakan untuk switching multi‑project).
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

String _$currentProjectIdHash() => r'02e303750332ac75593eece02e52f9e82b403a2a';

/// Project GEDCOM yang saat ini aktif (digunakan untuk switching multi‑project).
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

/// Persons repository (interface; impl: [PersonsRepositoryImpl]).

@ProviderFor(personsRepository)
final personsRepositoryProvider = PersonsRepositoryProvider._();

/// Persons repository (interface; impl: [PersonsRepositoryImpl]).

final class PersonsRepositoryProvider
    extends
        $FunctionalProvider<
          PersonsRepository,
          PersonsRepository,
          PersonsRepository
        >
    with $Provider<PersonsRepository> {
  /// Persons repository (interface; impl: [PersonsRepositoryImpl]).
  PersonsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'personsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$personsRepositoryHash();

  @$internal
  @override
  $ProviderElement<PersonsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PersonsRepository create(Ref ref) {
    return personsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PersonsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PersonsRepository>(value),
    );
  }
}

String _$personsRepositoryHash() => r'7e9868ca4c8397c99174f3c72078595c98f08973';

/// Contacts repository (interface; impl: [ContactsRepositoryImpl]).

@ProviderFor(contactsRepository)
final contactsRepositoryProvider = ContactsRepositoryProvider._();

/// Contacts repository (interface; impl: [ContactsRepositoryImpl]).

final class ContactsRepositoryProvider
    extends
        $FunctionalProvider<
          ContactsRepository,
          ContactsRepository,
          ContactsRepository
        >
    with $Provider<ContactsRepository> {
  /// Contacts repository (interface; impl: [ContactsRepositoryImpl]).
  ContactsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contactsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contactsRepositoryHash();

  @$internal
  @override
  $ProviderElement<ContactsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ContactsRepository create(Ref ref) {
    return contactsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ContactsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ContactsRepository>(value),
    );
  }
}

String _$contactsRepositoryHash() =>
    r'7941e9f1dc28aeab3a7738eb8c85f166dfed1b37';

/// Stream list persons untuk project aktif.
/// Mengembalikan stream kosong bila belum ada project yang dipilih.

@ProviderFor(personsStream)
final personsStreamProvider = PersonsStreamProvider._();

/// Stream list persons untuk project aktif.
/// Mengembalikan stream kosong bila belum ada project yang dipilih.

final class PersonsStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Person>>,
          List<Person>,
          Stream<List<Person>>
        >
    with $FutureModifier<List<Person>>, $StreamProvider<List<Person>> {
  /// Stream list persons untuk project aktif.
  /// Mengembalikan stream kosong bila belum ada project yang dipilih.
  PersonsStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'personsStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$personsStreamHash();

  @$internal
  @override
  $StreamProviderElement<List<Person>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Person>> create(Ref ref) {
    return personsStream(ref);
  }
}

String _$personsStreamHash() => r'a3a0a47b09cc79c1e1f642d59a6c5e7ce398cc85';

/// Stream list contacts untuk satu person.

@ProviderFor(contactsStreamProvider)
final contactsStreamProviderProvider = ContactsStreamProviderFamily._();

/// Stream list contacts untuk satu person.

final class ContactsStreamProviderProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Contact>>,
          List<Contact>,
          Stream<List<Contact>>
        >
    with $FutureModifier<List<Contact>>, $StreamProvider<List<Contact>> {
  /// Stream list contacts untuk satu person.
  ContactsStreamProviderProvider._({
    required ContactsStreamProviderFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'contactsStreamProviderProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$contactsStreamProviderHash();

  @override
  String toString() {
    return r'contactsStreamProviderProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Contact>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Contact>> create(Ref ref) {
    final argument = this.argument as int;
    return contactsStreamProvider(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ContactsStreamProviderProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$contactsStreamProviderHash() =>
    r'af948c43fabfd276b84a0a61fe72a20e89b91706';

/// Stream list contacts untuk satu person.

final class ContactsStreamProviderFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Contact>>, int> {
  ContactsStreamProviderFamily._()
    : super(
        retry: null,
        name: r'contactsStreamProviderProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Stream list contacts untuk satu person.

  ContactsStreamProviderProvider call(int personId) =>
      ContactsStreamProviderProvider._(argument: personId, from: this);

  @override
  String toString() => r'contactsStreamProviderProvider';
}

/// Person relations repository (interface; impl: [PersonRelationsRepositoryImpl]).

@ProviderFor(personRelationsRepository)
final personRelationsRepositoryProvider = PersonRelationsRepositoryProvider._();

/// Person relations repository (interface; impl: [PersonRelationsRepositoryImpl]).

final class PersonRelationsRepositoryProvider
    extends
        $FunctionalProvider<
          PersonRelationsRepository,
          PersonRelationsRepository,
          PersonRelationsRepository
        >
    with $Provider<PersonRelationsRepository> {
  /// Person relations repository (interface; impl: [PersonRelationsRepositoryImpl]).
  PersonRelationsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'personRelationsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$personRelationsRepositoryHash();

  @$internal
  @override
  $ProviderElement<PersonRelationsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PersonRelationsRepository create(Ref ref) {
    return personRelationsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PersonRelationsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PersonRelationsRepository>(value),
    );
  }
}

String _$personRelationsRepositoryHash() =>
    r'6123e2392eb2301203351f7d96898a2d88d7acc1';

/// Stream daftar relasi (dengan label + person lain) untuk satu person.

@ProviderFor(personRelationDisplaysStream)
final personRelationDisplaysStreamProvider =
    PersonRelationDisplaysStreamFamily._();

/// Stream daftar relasi (dengan label + person lain) untuk satu person.

final class PersonRelationDisplaysStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PersonRelationDisplay>>,
          List<PersonRelationDisplay>,
          Stream<List<PersonRelationDisplay>>
        >
    with
        $FutureModifier<List<PersonRelationDisplay>>,
        $StreamProvider<List<PersonRelationDisplay>> {
  /// Stream daftar relasi (dengan label + person lain) untuk satu person.
  PersonRelationDisplaysStreamProvider._({
    required PersonRelationDisplaysStreamFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'personRelationDisplaysStreamProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$personRelationDisplaysStreamHash();

  @override
  String toString() {
    return r'personRelationDisplaysStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<PersonRelationDisplay>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<PersonRelationDisplay>> create(Ref ref) {
    final argument = this.argument as int;
    return personRelationDisplaysStream(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PersonRelationDisplaysStreamProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$personRelationDisplaysStreamHash() =>
    r'5ee670e47a808037a8855cf059ac11c1b110b1c1';

/// Stream daftar relasi (dengan label + person lain) untuk satu person.

final class PersonRelationDisplaysStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<PersonRelationDisplay>>, int> {
  PersonRelationDisplaysStreamFamily._()
    : super(
        retry: null,
        name: r'personRelationDisplaysStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Stream daftar relasi (dengan label + person lain) untuk satu person.

  PersonRelationDisplaysStreamProvider call(int personId) =>
      PersonRelationDisplaysStreamProvider._(argument: personId, from: this);

  @override
  String toString() => r'personRelationDisplaysStreamProvider';
}

/// Mode tema aplikasi (light / dark / system). Disimpan di SharedPreferences
/// agar pilihan tetap dipakai saat app dibuka kembali.

@ProviderFor(ThemeModeNotifier)
final themeModeProvider = ThemeModeNotifierProvider._();

/// Mode tema aplikasi (light / dark / system). Disimpan di SharedPreferences
/// agar pilihan tetap dipakai saat app dibuka kembali.
final class ThemeModeNotifierProvider
    extends $NotifierProvider<ThemeModeNotifier, ThemeMode> {
  /// Mode tema aplikasi (light / dark / system). Disimpan di SharedPreferences
  /// agar pilihan tetap dipakai saat app dibuka kembali.
  ThemeModeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeModeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeModeNotifierHash();

  @$internal
  @override
  ThemeModeNotifier create() => ThemeModeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$themeModeNotifierHash() => r'0ccf552d2d6f48509aa623b3f75915319c461aad';

/// Mode tema aplikasi (light / dark / system). Disimpan di SharedPreferences
/// agar pilihan tetap dipakai saat app dibuka kembali.

abstract class _$ThemeModeNotifier extends $Notifier<ThemeMode> {
  ThemeMode build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ThemeMode, ThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeMode, ThemeMode>,
              ThemeMode,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
