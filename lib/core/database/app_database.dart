import 'package:drift/drift.dart';
import 'package:gedhub/core/database/connection/connection.dart';

part 'app_database.g.dart';

@DataClassName('ProjectRow')
class Projects extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get description => text().nullable()();

  TextColumn get locale => text().nullable()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('PersonRow')
class Persons extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get projectId => integer().references(Projects, #id, onDelete: KeyAction.cascade)();

  TextColumn get gedcomXref => text().nullable()();

  TextColumn get givenName => text()();

  TextColumn get surname => text()();

  TextColumn get nickname => text().nullable()();

  TextColumn get gender => text()();

  TextColumn get birthDate => text().nullable()();

  TextColumn get deathDate => text().nullable()();

  IntColumn get isLiving => integer().withDefault(const Constant(1))();

  TextColumn get notes => text().nullable()();
}

@DataClassName('FamilyRow')
class Families extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get projectId => integer().references(Projects, #id, onDelete: KeyAction.cascade)();

  TextColumn get gedcomXref => text().nullable()();

  IntColumn get husbandId => integer().nullable().references(Persons, #id, onDelete: KeyAction.restrict)();

  IntColumn get wifeId => integer().nullable().references(Persons, #id, onDelete: KeyAction.restrict)();

  TextColumn get marriageDate => text().nullable()();

  TextColumn get divorceDate => text().nullable()();

  TextColumn get notes => text().nullable()();
}

@DataClassName('ContactRow')
class Contacts extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get projectId => integer().references(Projects, #id, onDelete: KeyAction.cascade)();

  IntColumn get personId => integer().references(Persons, #id, onDelete: KeyAction.cascade)();

  TextColumn get provider => text()();

  TextColumn get contactType => text()();

  TextColumn get value => text()();

  TextColumn get label => text().nullable()();

  TextColumn get providerContactId => text().nullable()();

  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  TextColumn get notes => text().nullable()();

  IntColumn get createdAt => integer().nullable()();

  IntColumn get updatedAt => integer().nullable()();
}

@DataClassName('PlaceRow')
class Places extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  RealColumn get latitude => real().nullable()();

  RealColumn get longitude => real().nullable()();
}

/// Relasi antar person (koneksi yang bisa dilepas-pasang).
/// kind: 'parent' (personId = orang tua, relatedPersonId = anak), 'spouse', 'sibling'.
@DataClassName('PersonRelationRow')
class PersonRelations extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get projectId => integer().references(Projects, #id, onDelete: KeyAction.cascade)();

  IntColumn get personId => integer().references(Persons, #id, onDelete: KeyAction.cascade)();

  IntColumn get relatedPersonId => integer().references(Persons, #id, onDelete: KeyAction.cascade)();

  TextColumn get kind => text()();
}

@DriftDatabase(
  tables: [
    Projects,
    Persons,
    Families,
    Contacts,
    Places,
    PersonRelations,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? connection])
      : super(connection ?? openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from == 1 && to == 2) {
        await m.createTable(places);
        await m.createTable(persons);
        await m.createTable(families);
        await m.createTable(contacts);
      }
      if (from <= 2 && to >= 3) {
        await m.createTable(personRelations);
      }
    },
  );
}
