// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProjectsTable extends Projects
    with TableInfo<$ProjectsTable, ProjectRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localeMeta = const VerificationMeta('locale');
  @override
  late final GeneratedColumn<String> locale = GeneratedColumn<String>(
    'locale',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    locale,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'projects';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProjectRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('locale')) {
      context.handle(
        _localeMeta,
        locale.isAcceptableOrUnknown(data['locale']!, _localeMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProjectRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProjectRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      locale: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locale'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ProjectsTable createAlias(String alias) {
    return $ProjectsTable(attachedDatabase, alias);
  }
}

class ProjectRow extends DataClass implements Insertable<ProjectRow> {
  final int id;
  final String name;
  final String? description;
  final String? locale;
  final DateTime createdAt;
  const ProjectRow({
    required this.id,
    required this.name,
    this.description,
    this.locale,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || locale != null) {
      map['locale'] = Variable<String>(locale);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ProjectsCompanion toCompanion(bool nullToAbsent) {
    return ProjectsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      locale: locale == null && nullToAbsent
          ? const Value.absent()
          : Value(locale),
      createdAt: Value(createdAt),
    );
  }

  factory ProjectRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProjectRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      locale: serializer.fromJson<String?>(json['locale']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'locale': serializer.toJson<String?>(locale),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ProjectRow copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<String?> locale = const Value.absent(),
    DateTime? createdAt,
  }) => ProjectRow(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    locale: locale.present ? locale.value : this.locale,
    createdAt: createdAt ?? this.createdAt,
  );
  ProjectRow copyWithCompanion(ProjectsCompanion data) {
    return ProjectRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      locale: data.locale.present ? data.locale.value : this.locale,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProjectRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('locale: $locale, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, locale, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProjectRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.locale == this.locale &&
          other.createdAt == this.createdAt);
}

class ProjectsCompanion extends UpdateCompanion<ProjectRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> locale;
  final Value<DateTime> createdAt;
  const ProjectsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.locale = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ProjectsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.locale = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<ProjectRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? locale,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (locale != null) 'locale': locale,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ProjectsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<String?>? locale,
    Value<DateTime>? createdAt,
  }) {
    return ProjectsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      locale: locale ?? this.locale,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (locale.present) {
      map['locale'] = Variable<String>(locale.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('locale: $locale, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PersonsTable extends Persons with TableInfo<$PersonsTable, PersonRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<int> projectId = GeneratedColumn<int>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _gedcomXrefMeta = const VerificationMeta(
    'gedcomXref',
  );
  @override
  late final GeneratedColumn<String> gedcomXref = GeneratedColumn<String>(
    'gedcom_xref',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _givenNameMeta = const VerificationMeta(
    'givenName',
  );
  @override
  late final GeneratedColumn<String> givenName = GeneratedColumn<String>(
    'given_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _surnameMeta = const VerificationMeta(
    'surname',
  );
  @override
  late final GeneratedColumn<String> surname = GeneratedColumn<String>(
    'surname',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nicknameMeta = const VerificationMeta(
    'nickname',
  );
  @override
  late final GeneratedColumn<String> nickname = GeneratedColumn<String>(
    'nickname',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
    'gender',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _birthDateMeta = const VerificationMeta(
    'birthDate',
  );
  @override
  late final GeneratedColumn<String> birthDate = GeneratedColumn<String>(
    'birth_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deathDateMeta = const VerificationMeta(
    'deathDate',
  );
  @override
  late final GeneratedColumn<String> deathDate = GeneratedColumn<String>(
    'death_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isLivingMeta = const VerificationMeta(
    'isLiving',
  );
  @override
  late final GeneratedColumn<int> isLiving = GeneratedColumn<int>(
    'is_living',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    projectId,
    gedcomXref,
    givenName,
    surname,
    nickname,
    gender,
    birthDate,
    deathDate,
    isLiving,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'persons';
  @override
  VerificationContext validateIntegrity(
    Insertable<PersonRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('gedcom_xref')) {
      context.handle(
        _gedcomXrefMeta,
        gedcomXref.isAcceptableOrUnknown(data['gedcom_xref']!, _gedcomXrefMeta),
      );
    }
    if (data.containsKey('given_name')) {
      context.handle(
        _givenNameMeta,
        givenName.isAcceptableOrUnknown(data['given_name']!, _givenNameMeta),
      );
    } else if (isInserting) {
      context.missing(_givenNameMeta);
    }
    if (data.containsKey('surname')) {
      context.handle(
        _surnameMeta,
        surname.isAcceptableOrUnknown(data['surname']!, _surnameMeta),
      );
    } else if (isInserting) {
      context.missing(_surnameMeta);
    }
    if (data.containsKey('nickname')) {
      context.handle(
        _nicknameMeta,
        nickname.isAcceptableOrUnknown(data['nickname']!, _nicknameMeta),
      );
    }
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('birth_date')) {
      context.handle(
        _birthDateMeta,
        birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta),
      );
    }
    if (data.containsKey('death_date')) {
      context.handle(
        _deathDateMeta,
        deathDate.isAcceptableOrUnknown(data['death_date']!, _deathDateMeta),
      );
    }
    if (data.containsKey('is_living')) {
      context.handle(
        _isLivingMeta,
        isLiving.isAcceptableOrUnknown(data['is_living']!, _isLivingMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PersonRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PersonRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}project_id'],
      )!,
      gedcomXref: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gedcom_xref'],
      ),
      givenName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}given_name'],
      )!,
      surname: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}surname'],
      )!,
      nickname: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nickname'],
      ),
      gender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gender'],
      )!,
      birthDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}birth_date'],
      ),
      deathDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}death_date'],
      ),
      isLiving: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_living'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $PersonsTable createAlias(String alias) {
    return $PersonsTable(attachedDatabase, alias);
  }
}

class PersonRow extends DataClass implements Insertable<PersonRow> {
  final int id;
  final int projectId;
  final String? gedcomXref;
  final String givenName;
  final String surname;
  final String? nickname;
  final String gender;
  final String? birthDate;
  final String? deathDate;
  final int isLiving;
  final String? notes;
  const PersonRow({
    required this.id,
    required this.projectId,
    this.gedcomXref,
    required this.givenName,
    required this.surname,
    this.nickname,
    required this.gender,
    this.birthDate,
    this.deathDate,
    required this.isLiving,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['project_id'] = Variable<int>(projectId);
    if (!nullToAbsent || gedcomXref != null) {
      map['gedcom_xref'] = Variable<String>(gedcomXref);
    }
    map['given_name'] = Variable<String>(givenName);
    map['surname'] = Variable<String>(surname);
    if (!nullToAbsent || nickname != null) {
      map['nickname'] = Variable<String>(nickname);
    }
    map['gender'] = Variable<String>(gender);
    if (!nullToAbsent || birthDate != null) {
      map['birth_date'] = Variable<String>(birthDate);
    }
    if (!nullToAbsent || deathDate != null) {
      map['death_date'] = Variable<String>(deathDate);
    }
    map['is_living'] = Variable<int>(isLiving);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  PersonsCompanion toCompanion(bool nullToAbsent) {
    return PersonsCompanion(
      id: Value(id),
      projectId: Value(projectId),
      gedcomXref: gedcomXref == null && nullToAbsent
          ? const Value.absent()
          : Value(gedcomXref),
      givenName: Value(givenName),
      surname: Value(surname),
      nickname: nickname == null && nullToAbsent
          ? const Value.absent()
          : Value(nickname),
      gender: Value(gender),
      birthDate: birthDate == null && nullToAbsent
          ? const Value.absent()
          : Value(birthDate),
      deathDate: deathDate == null && nullToAbsent
          ? const Value.absent()
          : Value(deathDate),
      isLiving: Value(isLiving),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory PersonRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PersonRow(
      id: serializer.fromJson<int>(json['id']),
      projectId: serializer.fromJson<int>(json['projectId']),
      gedcomXref: serializer.fromJson<String?>(json['gedcomXref']),
      givenName: serializer.fromJson<String>(json['givenName']),
      surname: serializer.fromJson<String>(json['surname']),
      nickname: serializer.fromJson<String?>(json['nickname']),
      gender: serializer.fromJson<String>(json['gender']),
      birthDate: serializer.fromJson<String?>(json['birthDate']),
      deathDate: serializer.fromJson<String?>(json['deathDate']),
      isLiving: serializer.fromJson<int>(json['isLiving']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'projectId': serializer.toJson<int>(projectId),
      'gedcomXref': serializer.toJson<String?>(gedcomXref),
      'givenName': serializer.toJson<String>(givenName),
      'surname': serializer.toJson<String>(surname),
      'nickname': serializer.toJson<String?>(nickname),
      'gender': serializer.toJson<String>(gender),
      'birthDate': serializer.toJson<String?>(birthDate),
      'deathDate': serializer.toJson<String?>(deathDate),
      'isLiving': serializer.toJson<int>(isLiving),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  PersonRow copyWith({
    int? id,
    int? projectId,
    Value<String?> gedcomXref = const Value.absent(),
    String? givenName,
    String? surname,
    Value<String?> nickname = const Value.absent(),
    String? gender,
    Value<String?> birthDate = const Value.absent(),
    Value<String?> deathDate = const Value.absent(),
    int? isLiving,
    Value<String?> notes = const Value.absent(),
  }) => PersonRow(
    id: id ?? this.id,
    projectId: projectId ?? this.projectId,
    gedcomXref: gedcomXref.present ? gedcomXref.value : this.gedcomXref,
    givenName: givenName ?? this.givenName,
    surname: surname ?? this.surname,
    nickname: nickname.present ? nickname.value : this.nickname,
    gender: gender ?? this.gender,
    birthDate: birthDate.present ? birthDate.value : this.birthDate,
    deathDate: deathDate.present ? deathDate.value : this.deathDate,
    isLiving: isLiving ?? this.isLiving,
    notes: notes.present ? notes.value : this.notes,
  );
  PersonRow copyWithCompanion(PersonsCompanion data) {
    return PersonRow(
      id: data.id.present ? data.id.value : this.id,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      gedcomXref: data.gedcomXref.present
          ? data.gedcomXref.value
          : this.gedcomXref,
      givenName: data.givenName.present ? data.givenName.value : this.givenName,
      surname: data.surname.present ? data.surname.value : this.surname,
      nickname: data.nickname.present ? data.nickname.value : this.nickname,
      gender: data.gender.present ? data.gender.value : this.gender,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
      deathDate: data.deathDate.present ? data.deathDate.value : this.deathDate,
      isLiving: data.isLiving.present ? data.isLiving.value : this.isLiving,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PersonRow(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('gedcomXref: $gedcomXref, ')
          ..write('givenName: $givenName, ')
          ..write('surname: $surname, ')
          ..write('nickname: $nickname, ')
          ..write('gender: $gender, ')
          ..write('birthDate: $birthDate, ')
          ..write('deathDate: $deathDate, ')
          ..write('isLiving: $isLiving, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    projectId,
    gedcomXref,
    givenName,
    surname,
    nickname,
    gender,
    birthDate,
    deathDate,
    isLiving,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PersonRow &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.gedcomXref == this.gedcomXref &&
          other.givenName == this.givenName &&
          other.surname == this.surname &&
          other.nickname == this.nickname &&
          other.gender == this.gender &&
          other.birthDate == this.birthDate &&
          other.deathDate == this.deathDate &&
          other.isLiving == this.isLiving &&
          other.notes == this.notes);
}

class PersonsCompanion extends UpdateCompanion<PersonRow> {
  final Value<int> id;
  final Value<int> projectId;
  final Value<String?> gedcomXref;
  final Value<String> givenName;
  final Value<String> surname;
  final Value<String?> nickname;
  final Value<String> gender;
  final Value<String?> birthDate;
  final Value<String?> deathDate;
  final Value<int> isLiving;
  final Value<String?> notes;
  const PersonsCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.gedcomXref = const Value.absent(),
    this.givenName = const Value.absent(),
    this.surname = const Value.absent(),
    this.nickname = const Value.absent(),
    this.gender = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.deathDate = const Value.absent(),
    this.isLiving = const Value.absent(),
    this.notes = const Value.absent(),
  });
  PersonsCompanion.insert({
    this.id = const Value.absent(),
    required int projectId,
    this.gedcomXref = const Value.absent(),
    required String givenName,
    required String surname,
    this.nickname = const Value.absent(),
    required String gender,
    this.birthDate = const Value.absent(),
    this.deathDate = const Value.absent(),
    this.isLiving = const Value.absent(),
    this.notes = const Value.absent(),
  }) : projectId = Value(projectId),
       givenName = Value(givenName),
       surname = Value(surname),
       gender = Value(gender);
  static Insertable<PersonRow> custom({
    Expression<int>? id,
    Expression<int>? projectId,
    Expression<String>? gedcomXref,
    Expression<String>? givenName,
    Expression<String>? surname,
    Expression<String>? nickname,
    Expression<String>? gender,
    Expression<String>? birthDate,
    Expression<String>? deathDate,
    Expression<int>? isLiving,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (gedcomXref != null) 'gedcom_xref': gedcomXref,
      if (givenName != null) 'given_name': givenName,
      if (surname != null) 'surname': surname,
      if (nickname != null) 'nickname': nickname,
      if (gender != null) 'gender': gender,
      if (birthDate != null) 'birth_date': birthDate,
      if (deathDate != null) 'death_date': deathDate,
      if (isLiving != null) 'is_living': isLiving,
      if (notes != null) 'notes': notes,
    });
  }

  PersonsCompanion copyWith({
    Value<int>? id,
    Value<int>? projectId,
    Value<String?>? gedcomXref,
    Value<String>? givenName,
    Value<String>? surname,
    Value<String?>? nickname,
    Value<String>? gender,
    Value<String?>? birthDate,
    Value<String?>? deathDate,
    Value<int>? isLiving,
    Value<String?>? notes,
  }) {
    return PersonsCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      gedcomXref: gedcomXref ?? this.gedcomXref,
      givenName: givenName ?? this.givenName,
      surname: surname ?? this.surname,
      nickname: nickname ?? this.nickname,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      deathDate: deathDate ?? this.deathDate,
      isLiving: isLiving ?? this.isLiving,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<int>(projectId.value);
    }
    if (gedcomXref.present) {
      map['gedcom_xref'] = Variable<String>(gedcomXref.value);
    }
    if (givenName.present) {
      map['given_name'] = Variable<String>(givenName.value);
    }
    if (surname.present) {
      map['surname'] = Variable<String>(surname.value);
    }
    if (nickname.present) {
      map['nickname'] = Variable<String>(nickname.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<String>(birthDate.value);
    }
    if (deathDate.present) {
      map['death_date'] = Variable<String>(deathDate.value);
    }
    if (isLiving.present) {
      map['is_living'] = Variable<int>(isLiving.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonsCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('gedcomXref: $gedcomXref, ')
          ..write('givenName: $givenName, ')
          ..write('surname: $surname, ')
          ..write('nickname: $nickname, ')
          ..write('gender: $gender, ')
          ..write('birthDate: $birthDate, ')
          ..write('deathDate: $deathDate, ')
          ..write('isLiving: $isLiving, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $FamiliesTable extends Families
    with TableInfo<$FamiliesTable, FamilyRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FamiliesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<int> projectId = GeneratedColumn<int>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _gedcomXrefMeta = const VerificationMeta(
    'gedcomXref',
  );
  @override
  late final GeneratedColumn<String> gedcomXref = GeneratedColumn<String>(
    'gedcom_xref',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _husbandIdMeta = const VerificationMeta(
    'husbandId',
  );
  @override
  late final GeneratedColumn<int> husbandId = GeneratedColumn<int>(
    'husband_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES persons (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _wifeIdMeta = const VerificationMeta('wifeId');
  @override
  late final GeneratedColumn<int> wifeId = GeneratedColumn<int>(
    'wife_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES persons (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _marriageDateMeta = const VerificationMeta(
    'marriageDate',
  );
  @override
  late final GeneratedColumn<String> marriageDate = GeneratedColumn<String>(
    'marriage_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _divorceDateMeta = const VerificationMeta(
    'divorceDate',
  );
  @override
  late final GeneratedColumn<String> divorceDate = GeneratedColumn<String>(
    'divorce_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    projectId,
    gedcomXref,
    husbandId,
    wifeId,
    marriageDate,
    divorceDate,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'families';
  @override
  VerificationContext validateIntegrity(
    Insertable<FamilyRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('gedcom_xref')) {
      context.handle(
        _gedcomXrefMeta,
        gedcomXref.isAcceptableOrUnknown(data['gedcom_xref']!, _gedcomXrefMeta),
      );
    }
    if (data.containsKey('husband_id')) {
      context.handle(
        _husbandIdMeta,
        husbandId.isAcceptableOrUnknown(data['husband_id']!, _husbandIdMeta),
      );
    }
    if (data.containsKey('wife_id')) {
      context.handle(
        _wifeIdMeta,
        wifeId.isAcceptableOrUnknown(data['wife_id']!, _wifeIdMeta),
      );
    }
    if (data.containsKey('marriage_date')) {
      context.handle(
        _marriageDateMeta,
        marriageDate.isAcceptableOrUnknown(
          data['marriage_date']!,
          _marriageDateMeta,
        ),
      );
    }
    if (data.containsKey('divorce_date')) {
      context.handle(
        _divorceDateMeta,
        divorceDate.isAcceptableOrUnknown(
          data['divorce_date']!,
          _divorceDateMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FamilyRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FamilyRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}project_id'],
      )!,
      gedcomXref: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gedcom_xref'],
      ),
      husbandId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}husband_id'],
      ),
      wifeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wife_id'],
      ),
      marriageDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}marriage_date'],
      ),
      divorceDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}divorce_date'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $FamiliesTable createAlias(String alias) {
    return $FamiliesTable(attachedDatabase, alias);
  }
}

class FamilyRow extends DataClass implements Insertable<FamilyRow> {
  final int id;
  final int projectId;
  final String? gedcomXref;
  final int? husbandId;
  final int? wifeId;
  final String? marriageDate;
  final String? divorceDate;
  final String? notes;
  const FamilyRow({
    required this.id,
    required this.projectId,
    this.gedcomXref,
    this.husbandId,
    this.wifeId,
    this.marriageDate,
    this.divorceDate,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['project_id'] = Variable<int>(projectId);
    if (!nullToAbsent || gedcomXref != null) {
      map['gedcom_xref'] = Variable<String>(gedcomXref);
    }
    if (!nullToAbsent || husbandId != null) {
      map['husband_id'] = Variable<int>(husbandId);
    }
    if (!nullToAbsent || wifeId != null) {
      map['wife_id'] = Variable<int>(wifeId);
    }
    if (!nullToAbsent || marriageDate != null) {
      map['marriage_date'] = Variable<String>(marriageDate);
    }
    if (!nullToAbsent || divorceDate != null) {
      map['divorce_date'] = Variable<String>(divorceDate);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  FamiliesCompanion toCompanion(bool nullToAbsent) {
    return FamiliesCompanion(
      id: Value(id),
      projectId: Value(projectId),
      gedcomXref: gedcomXref == null && nullToAbsent
          ? const Value.absent()
          : Value(gedcomXref),
      husbandId: husbandId == null && nullToAbsent
          ? const Value.absent()
          : Value(husbandId),
      wifeId: wifeId == null && nullToAbsent
          ? const Value.absent()
          : Value(wifeId),
      marriageDate: marriageDate == null && nullToAbsent
          ? const Value.absent()
          : Value(marriageDate),
      divorceDate: divorceDate == null && nullToAbsent
          ? const Value.absent()
          : Value(divorceDate),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory FamilyRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FamilyRow(
      id: serializer.fromJson<int>(json['id']),
      projectId: serializer.fromJson<int>(json['projectId']),
      gedcomXref: serializer.fromJson<String?>(json['gedcomXref']),
      husbandId: serializer.fromJson<int?>(json['husbandId']),
      wifeId: serializer.fromJson<int?>(json['wifeId']),
      marriageDate: serializer.fromJson<String?>(json['marriageDate']),
      divorceDate: serializer.fromJson<String?>(json['divorceDate']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'projectId': serializer.toJson<int>(projectId),
      'gedcomXref': serializer.toJson<String?>(gedcomXref),
      'husbandId': serializer.toJson<int?>(husbandId),
      'wifeId': serializer.toJson<int?>(wifeId),
      'marriageDate': serializer.toJson<String?>(marriageDate),
      'divorceDate': serializer.toJson<String?>(divorceDate),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  FamilyRow copyWith({
    int? id,
    int? projectId,
    Value<String?> gedcomXref = const Value.absent(),
    Value<int?> husbandId = const Value.absent(),
    Value<int?> wifeId = const Value.absent(),
    Value<String?> marriageDate = const Value.absent(),
    Value<String?> divorceDate = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => FamilyRow(
    id: id ?? this.id,
    projectId: projectId ?? this.projectId,
    gedcomXref: gedcomXref.present ? gedcomXref.value : this.gedcomXref,
    husbandId: husbandId.present ? husbandId.value : this.husbandId,
    wifeId: wifeId.present ? wifeId.value : this.wifeId,
    marriageDate: marriageDate.present ? marriageDate.value : this.marriageDate,
    divorceDate: divorceDate.present ? divorceDate.value : this.divorceDate,
    notes: notes.present ? notes.value : this.notes,
  );
  FamilyRow copyWithCompanion(FamiliesCompanion data) {
    return FamilyRow(
      id: data.id.present ? data.id.value : this.id,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      gedcomXref: data.gedcomXref.present
          ? data.gedcomXref.value
          : this.gedcomXref,
      husbandId: data.husbandId.present ? data.husbandId.value : this.husbandId,
      wifeId: data.wifeId.present ? data.wifeId.value : this.wifeId,
      marriageDate: data.marriageDate.present
          ? data.marriageDate.value
          : this.marriageDate,
      divorceDate: data.divorceDate.present
          ? data.divorceDate.value
          : this.divorceDate,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FamilyRow(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('gedcomXref: $gedcomXref, ')
          ..write('husbandId: $husbandId, ')
          ..write('wifeId: $wifeId, ')
          ..write('marriageDate: $marriageDate, ')
          ..write('divorceDate: $divorceDate, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    projectId,
    gedcomXref,
    husbandId,
    wifeId,
    marriageDate,
    divorceDate,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FamilyRow &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.gedcomXref == this.gedcomXref &&
          other.husbandId == this.husbandId &&
          other.wifeId == this.wifeId &&
          other.marriageDate == this.marriageDate &&
          other.divorceDate == this.divorceDate &&
          other.notes == this.notes);
}

class FamiliesCompanion extends UpdateCompanion<FamilyRow> {
  final Value<int> id;
  final Value<int> projectId;
  final Value<String?> gedcomXref;
  final Value<int?> husbandId;
  final Value<int?> wifeId;
  final Value<String?> marriageDate;
  final Value<String?> divorceDate;
  final Value<String?> notes;
  const FamiliesCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.gedcomXref = const Value.absent(),
    this.husbandId = const Value.absent(),
    this.wifeId = const Value.absent(),
    this.marriageDate = const Value.absent(),
    this.divorceDate = const Value.absent(),
    this.notes = const Value.absent(),
  });
  FamiliesCompanion.insert({
    this.id = const Value.absent(),
    required int projectId,
    this.gedcomXref = const Value.absent(),
    this.husbandId = const Value.absent(),
    this.wifeId = const Value.absent(),
    this.marriageDate = const Value.absent(),
    this.divorceDate = const Value.absent(),
    this.notes = const Value.absent(),
  }) : projectId = Value(projectId);
  static Insertable<FamilyRow> custom({
    Expression<int>? id,
    Expression<int>? projectId,
    Expression<String>? gedcomXref,
    Expression<int>? husbandId,
    Expression<int>? wifeId,
    Expression<String>? marriageDate,
    Expression<String>? divorceDate,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (gedcomXref != null) 'gedcom_xref': gedcomXref,
      if (husbandId != null) 'husband_id': husbandId,
      if (wifeId != null) 'wife_id': wifeId,
      if (marriageDate != null) 'marriage_date': marriageDate,
      if (divorceDate != null) 'divorce_date': divorceDate,
      if (notes != null) 'notes': notes,
    });
  }

  FamiliesCompanion copyWith({
    Value<int>? id,
    Value<int>? projectId,
    Value<String?>? gedcomXref,
    Value<int?>? husbandId,
    Value<int?>? wifeId,
    Value<String?>? marriageDate,
    Value<String?>? divorceDate,
    Value<String?>? notes,
  }) {
    return FamiliesCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      gedcomXref: gedcomXref ?? this.gedcomXref,
      husbandId: husbandId ?? this.husbandId,
      wifeId: wifeId ?? this.wifeId,
      marriageDate: marriageDate ?? this.marriageDate,
      divorceDate: divorceDate ?? this.divorceDate,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<int>(projectId.value);
    }
    if (gedcomXref.present) {
      map['gedcom_xref'] = Variable<String>(gedcomXref.value);
    }
    if (husbandId.present) {
      map['husband_id'] = Variable<int>(husbandId.value);
    }
    if (wifeId.present) {
      map['wife_id'] = Variable<int>(wifeId.value);
    }
    if (marriageDate.present) {
      map['marriage_date'] = Variable<String>(marriageDate.value);
    }
    if (divorceDate.present) {
      map['divorce_date'] = Variable<String>(divorceDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FamiliesCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('gedcomXref: $gedcomXref, ')
          ..write('husbandId: $husbandId, ')
          ..write('wifeId: $wifeId, ')
          ..write('marriageDate: $marriageDate, ')
          ..write('divorceDate: $divorceDate, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $ContactsTable extends Contacts
    with TableInfo<$ContactsTable, ContactRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<int> projectId = GeneratedColumn<int>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _personIdMeta = const VerificationMeta(
    'personId',
  );
  @override
  late final GeneratedColumn<int> personId = GeneratedColumn<int>(
    'person_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES persons (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _providerMeta = const VerificationMeta(
    'provider',
  );
  @override
  late final GeneratedColumn<String> provider = GeneratedColumn<String>(
    'provider',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contactTypeMeta = const VerificationMeta(
    'contactType',
  );
  @override
  late final GeneratedColumn<String> contactType = GeneratedColumn<String>(
    'contact_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _providerContactIdMeta = const VerificationMeta(
    'providerContactId',
  );
  @override
  late final GeneratedColumn<String> providerContactId =
      GeneratedColumn<String>(
        'provider_contact_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    projectId,
    personId,
    provider,
    contactType,
    value,
    label,
    providerContactId,
    sortOrder,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contacts';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContactRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('person_id')) {
      context.handle(
        _personIdMeta,
        personId.isAcceptableOrUnknown(data['person_id']!, _personIdMeta),
      );
    } else if (isInserting) {
      context.missing(_personIdMeta);
    }
    if (data.containsKey('provider')) {
      context.handle(
        _providerMeta,
        provider.isAcceptableOrUnknown(data['provider']!, _providerMeta),
      );
    } else if (isInserting) {
      context.missing(_providerMeta);
    }
    if (data.containsKey('contact_type')) {
      context.handle(
        _contactTypeMeta,
        contactType.isAcceptableOrUnknown(
          data['contact_type']!,
          _contactTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contactTypeMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    if (data.containsKey('provider_contact_id')) {
      context.handle(
        _providerContactIdMeta,
        providerContactId.isAcceptableOrUnknown(
          data['provider_contact_id']!,
          _providerContactIdMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContactRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContactRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}project_id'],
      )!,
      personId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}person_id'],
      )!,
      provider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider'],
      )!,
      contactType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_type'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      ),
      providerContactId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider_contact_id'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $ContactsTable createAlias(String alias) {
    return $ContactsTable(attachedDatabase, alias);
  }
}

class ContactRow extends DataClass implements Insertable<ContactRow> {
  final int id;
  final int projectId;
  final int personId;
  final String provider;
  final String contactType;
  final String value;
  final String? label;
  final String? providerContactId;
  final int sortOrder;
  final String? notes;
  final int? createdAt;
  final int? updatedAt;
  const ContactRow({
    required this.id,
    required this.projectId,
    required this.personId,
    required this.provider,
    required this.contactType,
    required this.value,
    this.label,
    this.providerContactId,
    required this.sortOrder,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['project_id'] = Variable<int>(projectId);
    map['person_id'] = Variable<int>(personId);
    map['provider'] = Variable<String>(provider);
    map['contact_type'] = Variable<String>(contactType);
    map['value'] = Variable<String>(value);
    if (!nullToAbsent || label != null) {
      map['label'] = Variable<String>(label);
    }
    if (!nullToAbsent || providerContactId != null) {
      map['provider_contact_id'] = Variable<String>(providerContactId);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<int>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<int>(updatedAt);
    }
    return map;
  }

  ContactsCompanion toCompanion(bool nullToAbsent) {
    return ContactsCompanion(
      id: Value(id),
      projectId: Value(projectId),
      personId: Value(personId),
      provider: Value(provider),
      contactType: Value(contactType),
      value: Value(value),
      label: label == null && nullToAbsent
          ? const Value.absent()
          : Value(label),
      providerContactId: providerContactId == null && nullToAbsent
          ? const Value.absent()
          : Value(providerContactId),
      sortOrder: Value(sortOrder),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory ContactRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContactRow(
      id: serializer.fromJson<int>(json['id']),
      projectId: serializer.fromJson<int>(json['projectId']),
      personId: serializer.fromJson<int>(json['personId']),
      provider: serializer.fromJson<String>(json['provider']),
      contactType: serializer.fromJson<String>(json['contactType']),
      value: serializer.fromJson<String>(json['value']),
      label: serializer.fromJson<String?>(json['label']),
      providerContactId: serializer.fromJson<String?>(
        json['providerContactId'],
      ),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<int?>(json['createdAt']),
      updatedAt: serializer.fromJson<int?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'projectId': serializer.toJson<int>(projectId),
      'personId': serializer.toJson<int>(personId),
      'provider': serializer.toJson<String>(provider),
      'contactType': serializer.toJson<String>(contactType),
      'value': serializer.toJson<String>(value),
      'label': serializer.toJson<String?>(label),
      'providerContactId': serializer.toJson<String?>(providerContactId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<int?>(createdAt),
      'updatedAt': serializer.toJson<int?>(updatedAt),
    };
  }

  ContactRow copyWith({
    int? id,
    int? projectId,
    int? personId,
    String? provider,
    String? contactType,
    String? value,
    Value<String?> label = const Value.absent(),
    Value<String?> providerContactId = const Value.absent(),
    int? sortOrder,
    Value<String?> notes = const Value.absent(),
    Value<int?> createdAt = const Value.absent(),
    Value<int?> updatedAt = const Value.absent(),
  }) => ContactRow(
    id: id ?? this.id,
    projectId: projectId ?? this.projectId,
    personId: personId ?? this.personId,
    provider: provider ?? this.provider,
    contactType: contactType ?? this.contactType,
    value: value ?? this.value,
    label: label.present ? label.value : this.label,
    providerContactId: providerContactId.present
        ? providerContactId.value
        : this.providerContactId,
    sortOrder: sortOrder ?? this.sortOrder,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  ContactRow copyWithCompanion(ContactsCompanion data) {
    return ContactRow(
      id: data.id.present ? data.id.value : this.id,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      personId: data.personId.present ? data.personId.value : this.personId,
      provider: data.provider.present ? data.provider.value : this.provider,
      contactType: data.contactType.present
          ? data.contactType.value
          : this.contactType,
      value: data.value.present ? data.value.value : this.value,
      label: data.label.present ? data.label.value : this.label,
      providerContactId: data.providerContactId.present
          ? data.providerContactId.value
          : this.providerContactId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContactRow(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('personId: $personId, ')
          ..write('provider: $provider, ')
          ..write('contactType: $contactType, ')
          ..write('value: $value, ')
          ..write('label: $label, ')
          ..write('providerContactId: $providerContactId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    projectId,
    personId,
    provider,
    contactType,
    value,
    label,
    providerContactId,
    sortOrder,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContactRow &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.personId == this.personId &&
          other.provider == this.provider &&
          other.contactType == this.contactType &&
          other.value == this.value &&
          other.label == this.label &&
          other.providerContactId == this.providerContactId &&
          other.sortOrder == this.sortOrder &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ContactsCompanion extends UpdateCompanion<ContactRow> {
  final Value<int> id;
  final Value<int> projectId;
  final Value<int> personId;
  final Value<String> provider;
  final Value<String> contactType;
  final Value<String> value;
  final Value<String?> label;
  final Value<String?> providerContactId;
  final Value<int> sortOrder;
  final Value<String?> notes;
  final Value<int?> createdAt;
  final Value<int?> updatedAt;
  const ContactsCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.personId = const Value.absent(),
    this.provider = const Value.absent(),
    this.contactType = const Value.absent(),
    this.value = const Value.absent(),
    this.label = const Value.absent(),
    this.providerContactId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ContactsCompanion.insert({
    this.id = const Value.absent(),
    required int projectId,
    required int personId,
    required String provider,
    required String contactType,
    required String value,
    this.label = const Value.absent(),
    this.providerContactId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : projectId = Value(projectId),
       personId = Value(personId),
       provider = Value(provider),
       contactType = Value(contactType),
       value = Value(value);
  static Insertable<ContactRow> custom({
    Expression<int>? id,
    Expression<int>? projectId,
    Expression<int>? personId,
    Expression<String>? provider,
    Expression<String>? contactType,
    Expression<String>? value,
    Expression<String>? label,
    Expression<String>? providerContactId,
    Expression<int>? sortOrder,
    Expression<String>? notes,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (personId != null) 'person_id': personId,
      if (provider != null) 'provider': provider,
      if (contactType != null) 'contact_type': contactType,
      if (value != null) 'value': value,
      if (label != null) 'label': label,
      if (providerContactId != null) 'provider_contact_id': providerContactId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ContactsCompanion copyWith({
    Value<int>? id,
    Value<int>? projectId,
    Value<int>? personId,
    Value<String>? provider,
    Value<String>? contactType,
    Value<String>? value,
    Value<String?>? label,
    Value<String?>? providerContactId,
    Value<int>? sortOrder,
    Value<String?>? notes,
    Value<int?>? createdAt,
    Value<int?>? updatedAt,
  }) {
    return ContactsCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      personId: personId ?? this.personId,
      provider: provider ?? this.provider,
      contactType: contactType ?? this.contactType,
      value: value ?? this.value,
      label: label ?? this.label,
      providerContactId: providerContactId ?? this.providerContactId,
      sortOrder: sortOrder ?? this.sortOrder,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<int>(projectId.value);
    }
    if (personId.present) {
      map['person_id'] = Variable<int>(personId.value);
    }
    if (provider.present) {
      map['provider'] = Variable<String>(provider.value);
    }
    if (contactType.present) {
      map['contact_type'] = Variable<String>(contactType.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (providerContactId.present) {
      map['provider_contact_id'] = Variable<String>(providerContactId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactsCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('personId: $personId, ')
          ..write('provider: $provider, ')
          ..write('contactType: $contactType, ')
          ..write('value: $value, ')
          ..write('label: $label, ')
          ..write('providerContactId: $providerContactId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PlacesTable extends Places with TableInfo<$PlacesTable, PlaceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlacesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, latitude, longitude];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'places';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlaceRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlaceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaceRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
    );
  }

  @override
  $PlacesTable createAlias(String alias) {
    return $PlacesTable(attachedDatabase, alias);
  }
}

class PlaceRow extends DataClass implements Insertable<PlaceRow> {
  final int id;
  final String name;
  final double? latitude;
  final double? longitude;
  const PlaceRow({
    required this.id,
    required this.name,
    this.latitude,
    this.longitude,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    return map;
  }

  PlacesCompanion toCompanion(bool nullToAbsent) {
    return PlacesCompanion(
      id: Value(id),
      name: Value(name),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
    );
  }

  factory PlaceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaceRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
    };
  }

  PlaceRow copyWith({
    int? id,
    String? name,
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
  }) => PlaceRow(
    id: id ?? this.id,
    name: name ?? this.name,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
  );
  PlaceRow copyWithCompanion(PlacesCompanion data) {
    return PlaceRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaceRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, latitude, longitude);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaceRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude);
}

class PlacesCompanion extends UpdateCompanion<PlaceRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<double?> latitude;
  final Value<double?> longitude;
  const PlacesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
  });
  PlacesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
  }) : name = Value(name);
  static Insertable<PlaceRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<double>? latitude,
    Expression<double>? longitude,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
    });
  }

  PlacesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<double?>? latitude,
    Value<double?>? longitude,
  }) {
    return PlacesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlacesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude')
          ..write(')'))
        .toString();
  }
}

class $PersonRelationsTable extends PersonRelations
    with TableInfo<$PersonRelationsTable, PersonRelationRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonRelationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<int> projectId = GeneratedColumn<int>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _personIdMeta = const VerificationMeta(
    'personId',
  );
  @override
  late final GeneratedColumn<int> personId = GeneratedColumn<int>(
    'person_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES persons (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _relatedPersonIdMeta = const VerificationMeta(
    'relatedPersonId',
  );
  @override
  late final GeneratedColumn<int> relatedPersonId = GeneratedColumn<int>(
    'related_person_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES persons (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    projectId,
    personId,
    relatedPersonId,
    kind,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'person_relations';
  @override
  VerificationContext validateIntegrity(
    Insertable<PersonRelationRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('person_id')) {
      context.handle(
        _personIdMeta,
        personId.isAcceptableOrUnknown(data['person_id']!, _personIdMeta),
      );
    } else if (isInserting) {
      context.missing(_personIdMeta);
    }
    if (data.containsKey('related_person_id')) {
      context.handle(
        _relatedPersonIdMeta,
        relatedPersonId.isAcceptableOrUnknown(
          data['related_person_id']!,
          _relatedPersonIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_relatedPersonIdMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PersonRelationRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PersonRelationRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}project_id'],
      )!,
      personId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}person_id'],
      )!,
      relatedPersonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}related_person_id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
    );
  }

  @override
  $PersonRelationsTable createAlias(String alias) {
    return $PersonRelationsTable(attachedDatabase, alias);
  }
}

class PersonRelationRow extends DataClass
    implements Insertable<PersonRelationRow> {
  final int id;
  final int projectId;
  final int personId;
  final int relatedPersonId;
  final String kind;
  const PersonRelationRow({
    required this.id,
    required this.projectId,
    required this.personId,
    required this.relatedPersonId,
    required this.kind,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['project_id'] = Variable<int>(projectId);
    map['person_id'] = Variable<int>(personId);
    map['related_person_id'] = Variable<int>(relatedPersonId);
    map['kind'] = Variable<String>(kind);
    return map;
  }

  PersonRelationsCompanion toCompanion(bool nullToAbsent) {
    return PersonRelationsCompanion(
      id: Value(id),
      projectId: Value(projectId),
      personId: Value(personId),
      relatedPersonId: Value(relatedPersonId),
      kind: Value(kind),
    );
  }

  factory PersonRelationRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PersonRelationRow(
      id: serializer.fromJson<int>(json['id']),
      projectId: serializer.fromJson<int>(json['projectId']),
      personId: serializer.fromJson<int>(json['personId']),
      relatedPersonId: serializer.fromJson<int>(json['relatedPersonId']),
      kind: serializer.fromJson<String>(json['kind']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'projectId': serializer.toJson<int>(projectId),
      'personId': serializer.toJson<int>(personId),
      'relatedPersonId': serializer.toJson<int>(relatedPersonId),
      'kind': serializer.toJson<String>(kind),
    };
  }

  PersonRelationRow copyWith({
    int? id,
    int? projectId,
    int? personId,
    int? relatedPersonId,
    String? kind,
  }) => PersonRelationRow(
    id: id ?? this.id,
    projectId: projectId ?? this.projectId,
    personId: personId ?? this.personId,
    relatedPersonId: relatedPersonId ?? this.relatedPersonId,
    kind: kind ?? this.kind,
  );
  PersonRelationRow copyWithCompanion(PersonRelationsCompanion data) {
    return PersonRelationRow(
      id: data.id.present ? data.id.value : this.id,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      personId: data.personId.present ? data.personId.value : this.personId,
      relatedPersonId: data.relatedPersonId.present
          ? data.relatedPersonId.value
          : this.relatedPersonId,
      kind: data.kind.present ? data.kind.value : this.kind,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PersonRelationRow(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('personId: $personId, ')
          ..write('relatedPersonId: $relatedPersonId, ')
          ..write('kind: $kind')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, projectId, personId, relatedPersonId, kind);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PersonRelationRow &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.personId == this.personId &&
          other.relatedPersonId == this.relatedPersonId &&
          other.kind == this.kind);
}

class PersonRelationsCompanion extends UpdateCompanion<PersonRelationRow> {
  final Value<int> id;
  final Value<int> projectId;
  final Value<int> personId;
  final Value<int> relatedPersonId;
  final Value<String> kind;
  const PersonRelationsCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.personId = const Value.absent(),
    this.relatedPersonId = const Value.absent(),
    this.kind = const Value.absent(),
  });
  PersonRelationsCompanion.insert({
    this.id = const Value.absent(),
    required int projectId,
    required int personId,
    required int relatedPersonId,
    required String kind,
  }) : projectId = Value(projectId),
       personId = Value(personId),
       relatedPersonId = Value(relatedPersonId),
       kind = Value(kind);
  static Insertable<PersonRelationRow> custom({
    Expression<int>? id,
    Expression<int>? projectId,
    Expression<int>? personId,
    Expression<int>? relatedPersonId,
    Expression<String>? kind,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (personId != null) 'person_id': personId,
      if (relatedPersonId != null) 'related_person_id': relatedPersonId,
      if (kind != null) 'kind': kind,
    });
  }

  PersonRelationsCompanion copyWith({
    Value<int>? id,
    Value<int>? projectId,
    Value<int>? personId,
    Value<int>? relatedPersonId,
    Value<String>? kind,
  }) {
    return PersonRelationsCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      personId: personId ?? this.personId,
      relatedPersonId: relatedPersonId ?? this.relatedPersonId,
      kind: kind ?? this.kind,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<int>(projectId.value);
    }
    if (personId.present) {
      map['person_id'] = Variable<int>(personId.value);
    }
    if (relatedPersonId.present) {
      map['related_person_id'] = Variable<int>(relatedPersonId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonRelationsCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('personId: $personId, ')
          ..write('relatedPersonId: $relatedPersonId, ')
          ..write('kind: $kind')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProjectsTable projects = $ProjectsTable(this);
  late final $PersonsTable persons = $PersonsTable(this);
  late final $FamiliesTable families = $FamiliesTable(this);
  late final $ContactsTable contacts = $ContactsTable(this);
  late final $PlacesTable places = $PlacesTable(this);
  late final $PersonRelationsTable personRelations = $PersonRelationsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    projects,
    persons,
    families,
    contacts,
    places,
    personRelations,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'projects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('persons', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'projects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('families', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'projects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('contacts', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'persons',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('contacts', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'projects',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('person_relations', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'persons',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('person_relations', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'persons',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('person_relations', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$ProjectsTableCreateCompanionBuilder =
    ProjectsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      Value<String?> locale,
      Value<DateTime> createdAt,
    });
typedef $$ProjectsTableUpdateCompanionBuilder =
    ProjectsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<String?> locale,
      Value<DateTime> createdAt,
    });

final class $$ProjectsTableReferences
    extends BaseReferences<_$AppDatabase, $ProjectsTable, ProjectRow> {
  $$ProjectsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PersonsTable, List<PersonRow>> _personsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.persons,
    aliasName: $_aliasNameGenerator(db.projects.id, db.persons.projectId),
  );

  $$PersonsTableProcessedTableManager get personsRefs {
    final manager = $$PersonsTableTableManager(
      $_db,
      $_db.persons,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_personsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FamiliesTable, List<FamilyRow>>
  _familiesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.families,
    aliasName: $_aliasNameGenerator(db.projects.id, db.families.projectId),
  );

  $$FamiliesTableProcessedTableManager get familiesRefs {
    final manager = $$FamiliesTableTableManager(
      $_db,
      $_db.families,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_familiesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ContactsTable, List<ContactRow>>
  _contactsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.contacts,
    aliasName: $_aliasNameGenerator(db.projects.id, db.contacts.projectId),
  );

  $$ContactsTableProcessedTableManager get contactsRefs {
    final manager = $$ContactsTableTableManager(
      $_db,
      $_db.contacts,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_contactsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PersonRelationsTable, List<PersonRelationRow>>
  _personRelationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.personRelations,
    aliasName: $_aliasNameGenerator(
      db.projects.id,
      db.personRelations.projectId,
    ),
  );

  $$PersonRelationsTableProcessedTableManager get personRelationsRefs {
    final manager = $$PersonRelationsTableTableManager(
      $_db,
      $_db.personRelations,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _personRelationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProjectsTableFilterComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> personsRefs(
    Expression<bool> Function($$PersonsTableFilterComposer f) f,
  ) {
    final $$PersonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableFilterComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> familiesRefs(
    Expression<bool> Function($$FamiliesTableFilterComposer f) f,
  ) {
    final $$FamiliesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.families,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FamiliesTableFilterComposer(
            $db: $db,
            $table: $db.families,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> contactsRefs(
    Expression<bool> Function($$ContactsTableFilterComposer f) f,
  ) {
    final $$ContactsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contacts,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContactsTableFilterComposer(
            $db: $db,
            $table: $db.contacts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> personRelationsRefs(
    Expression<bool> Function($$PersonRelationsTableFilterComposer f) f,
  ) {
    final $$PersonRelationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.personRelations,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonRelationsTableFilterComposer(
            $db: $db,
            $table: $db.personRelations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locale =>
      $composableBuilder(column: $table.locale, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> personsRefs<T extends Object>(
    Expression<T> Function($$PersonsTableAnnotationComposer a) f,
  ) {
    final $$PersonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableAnnotationComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> familiesRefs<T extends Object>(
    Expression<T> Function($$FamiliesTableAnnotationComposer a) f,
  ) {
    final $$FamiliesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.families,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FamiliesTableAnnotationComposer(
            $db: $db,
            $table: $db.families,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> contactsRefs<T extends Object>(
    Expression<T> Function($$ContactsTableAnnotationComposer a) f,
  ) {
    final $$ContactsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contacts,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContactsTableAnnotationComposer(
            $db: $db,
            $table: $db.contacts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> personRelationsRefs<T extends Object>(
    Expression<T> Function($$PersonRelationsTableAnnotationComposer a) f,
  ) {
    final $$PersonRelationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.personRelations,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonRelationsTableAnnotationComposer(
            $db: $db,
            $table: $db.personRelations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProjectsTable,
          ProjectRow,
          $$ProjectsTableFilterComposer,
          $$ProjectsTableOrderingComposer,
          $$ProjectsTableAnnotationComposer,
          $$ProjectsTableCreateCompanionBuilder,
          $$ProjectsTableUpdateCompanionBuilder,
          (ProjectRow, $$ProjectsTableReferences),
          ProjectRow,
          PrefetchHooks Function({
            bool personsRefs,
            bool familiesRefs,
            bool contactsRefs,
            bool personRelationsRefs,
          })
        > {
  $$ProjectsTableTableManager(_$AppDatabase db, $ProjectsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> locale = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ProjectsCompanion(
                id: id,
                name: name,
                description: description,
                locale: locale,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String?> locale = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ProjectsCompanion.insert(
                id: id,
                name: name,
                description: description,
                locale: locale,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProjectsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                personsRefs = false,
                familiesRefs = false,
                contactsRefs = false,
                personRelationsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (personsRefs) db.persons,
                    if (familiesRefs) db.families,
                    if (contactsRefs) db.contacts,
                    if (personRelationsRefs) db.personRelations,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (personsRefs)
                        await $_getPrefetchedData<
                          ProjectRow,
                          $ProjectsTable,
                          PersonRow
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._personsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).personsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.projectId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (familiesRefs)
                        await $_getPrefetchedData<
                          ProjectRow,
                          $ProjectsTable,
                          FamilyRow
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._familiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).familiesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.projectId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (contactsRefs)
                        await $_getPrefetchedData<
                          ProjectRow,
                          $ProjectsTable,
                          ContactRow
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._contactsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).contactsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.projectId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (personRelationsRefs)
                        await $_getPrefetchedData<
                          ProjectRow,
                          $ProjectsTable,
                          PersonRelationRow
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._personRelationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).personRelationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.projectId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProjectsTable,
      ProjectRow,
      $$ProjectsTableFilterComposer,
      $$ProjectsTableOrderingComposer,
      $$ProjectsTableAnnotationComposer,
      $$ProjectsTableCreateCompanionBuilder,
      $$ProjectsTableUpdateCompanionBuilder,
      (ProjectRow, $$ProjectsTableReferences),
      ProjectRow,
      PrefetchHooks Function({
        bool personsRefs,
        bool familiesRefs,
        bool contactsRefs,
        bool personRelationsRefs,
      })
    >;
typedef $$PersonsTableCreateCompanionBuilder =
    PersonsCompanion Function({
      Value<int> id,
      required int projectId,
      Value<String?> gedcomXref,
      required String givenName,
      required String surname,
      Value<String?> nickname,
      required String gender,
      Value<String?> birthDate,
      Value<String?> deathDate,
      Value<int> isLiving,
      Value<String?> notes,
    });
typedef $$PersonsTableUpdateCompanionBuilder =
    PersonsCompanion Function({
      Value<int> id,
      Value<int> projectId,
      Value<String?> gedcomXref,
      Value<String> givenName,
      Value<String> surname,
      Value<String?> nickname,
      Value<String> gender,
      Value<String?> birthDate,
      Value<String?> deathDate,
      Value<int> isLiving,
      Value<String?> notes,
    });

final class $$PersonsTableReferences
    extends BaseReferences<_$AppDatabase, $PersonsTable, PersonRow> {
  $$PersonsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProjectsTable _projectIdTable(_$AppDatabase db) => db.projects
      .createAlias($_aliasNameGenerator(db.persons.projectId, db.projects.id));

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<int>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ContactsTable, List<ContactRow>>
  _contactsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.contacts,
    aliasName: $_aliasNameGenerator(db.persons.id, db.contacts.personId),
  );

  $$ContactsTableProcessedTableManager get contactsRefs {
    final manager = $$ContactsTableTableManager(
      $_db,
      $_db.contacts,
    ).filter((f) => f.personId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_contactsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PersonsTableFilterComposer
    extends Composer<_$AppDatabase, $PersonsTable> {
  $$PersonsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gedcomXref => $composableBuilder(
    column: $table.gedcomXref,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get givenName => $composableBuilder(
    column: $table.givenName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get surname => $composableBuilder(
    column: $table.surname,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deathDate => $composableBuilder(
    column: $table.deathDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isLiving => $composableBuilder(
    column: $table.isLiving,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> contactsRefs(
    Expression<bool> Function($$ContactsTableFilterComposer f) f,
  ) {
    final $$ContactsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contacts,
      getReferencedColumn: (t) => t.personId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContactsTableFilterComposer(
            $db: $db,
            $table: $db.contacts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PersonsTableOrderingComposer
    extends Composer<_$AppDatabase, $PersonsTable> {
  $$PersonsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gedcomXref => $composableBuilder(
    column: $table.gedcomXref,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get givenName => $composableBuilder(
    column: $table.givenName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get surname => $composableBuilder(
    column: $table.surname,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deathDate => $composableBuilder(
    column: $table.deathDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isLiving => $composableBuilder(
    column: $table.isLiving,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PersonsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PersonsTable> {
  $$PersonsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get gedcomXref => $composableBuilder(
    column: $table.gedcomXref,
    builder: (column) => column,
  );

  GeneratedColumn<String> get givenName =>
      $composableBuilder(column: $table.givenName, builder: (column) => column);

  GeneratedColumn<String> get surname =>
      $composableBuilder(column: $table.surname, builder: (column) => column);

  GeneratedColumn<String> get nickname =>
      $composableBuilder(column: $table.nickname, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);

  GeneratedColumn<String> get deathDate =>
      $composableBuilder(column: $table.deathDate, builder: (column) => column);

  GeneratedColumn<int> get isLiving =>
      $composableBuilder(column: $table.isLiving, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> contactsRefs<T extends Object>(
    Expression<T> Function($$ContactsTableAnnotationComposer a) f,
  ) {
    final $$ContactsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contacts,
      getReferencedColumn: (t) => t.personId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContactsTableAnnotationComposer(
            $db: $db,
            $table: $db.contacts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PersonsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PersonsTable,
          PersonRow,
          $$PersonsTableFilterComposer,
          $$PersonsTableOrderingComposer,
          $$PersonsTableAnnotationComposer,
          $$PersonsTableCreateCompanionBuilder,
          $$PersonsTableUpdateCompanionBuilder,
          (PersonRow, $$PersonsTableReferences),
          PersonRow,
          PrefetchHooks Function({bool projectId, bool contactsRefs})
        > {
  $$PersonsTableTableManager(_$AppDatabase db, $PersonsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PersonsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PersonsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PersonsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> projectId = const Value.absent(),
                Value<String?> gedcomXref = const Value.absent(),
                Value<String> givenName = const Value.absent(),
                Value<String> surname = const Value.absent(),
                Value<String?> nickname = const Value.absent(),
                Value<String> gender = const Value.absent(),
                Value<String?> birthDate = const Value.absent(),
                Value<String?> deathDate = const Value.absent(),
                Value<int> isLiving = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PersonsCompanion(
                id: id,
                projectId: projectId,
                gedcomXref: gedcomXref,
                givenName: givenName,
                surname: surname,
                nickname: nickname,
                gender: gender,
                birthDate: birthDate,
                deathDate: deathDate,
                isLiving: isLiving,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int projectId,
                Value<String?> gedcomXref = const Value.absent(),
                required String givenName,
                required String surname,
                Value<String?> nickname = const Value.absent(),
                required String gender,
                Value<String?> birthDate = const Value.absent(),
                Value<String?> deathDate = const Value.absent(),
                Value<int> isLiving = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => PersonsCompanion.insert(
                id: id,
                projectId: projectId,
                gedcomXref: gedcomXref,
                givenName: givenName,
                surname: surname,
                nickname: nickname,
                gender: gender,
                birthDate: birthDate,
                deathDate: deathDate,
                isLiving: isLiving,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PersonsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({projectId = false, contactsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (contactsRefs) db.contacts],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (projectId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.projectId,
                                referencedTable: $$PersonsTableReferences
                                    ._projectIdTable(db),
                                referencedColumn: $$PersonsTableReferences
                                    ._projectIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (contactsRefs)
                    await $_getPrefetchedData<
                      PersonRow,
                      $PersonsTable,
                      ContactRow
                    >(
                      currentTable: table,
                      referencedTable: $$PersonsTableReferences
                          ._contactsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$PersonsTableReferences(db, table, p0).contactsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.personId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PersonsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PersonsTable,
      PersonRow,
      $$PersonsTableFilterComposer,
      $$PersonsTableOrderingComposer,
      $$PersonsTableAnnotationComposer,
      $$PersonsTableCreateCompanionBuilder,
      $$PersonsTableUpdateCompanionBuilder,
      (PersonRow, $$PersonsTableReferences),
      PersonRow,
      PrefetchHooks Function({bool projectId, bool contactsRefs})
    >;
typedef $$FamiliesTableCreateCompanionBuilder =
    FamiliesCompanion Function({
      Value<int> id,
      required int projectId,
      Value<String?> gedcomXref,
      Value<int?> husbandId,
      Value<int?> wifeId,
      Value<String?> marriageDate,
      Value<String?> divorceDate,
      Value<String?> notes,
    });
typedef $$FamiliesTableUpdateCompanionBuilder =
    FamiliesCompanion Function({
      Value<int> id,
      Value<int> projectId,
      Value<String?> gedcomXref,
      Value<int?> husbandId,
      Value<int?> wifeId,
      Value<String?> marriageDate,
      Value<String?> divorceDate,
      Value<String?> notes,
    });

final class $$FamiliesTableReferences
    extends BaseReferences<_$AppDatabase, $FamiliesTable, FamilyRow> {
  $$FamiliesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProjectsTable _projectIdTable(_$AppDatabase db) => db.projects
      .createAlias($_aliasNameGenerator(db.families.projectId, db.projects.id));

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<int>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PersonsTable _husbandIdTable(_$AppDatabase db) => db.persons
      .createAlias($_aliasNameGenerator(db.families.husbandId, db.persons.id));

  $$PersonsTableProcessedTableManager? get husbandId {
    final $_column = $_itemColumn<int>('husband_id');
    if ($_column == null) return null;
    final manager = $$PersonsTableTableManager(
      $_db,
      $_db.persons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_husbandIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PersonsTable _wifeIdTable(_$AppDatabase db) => db.persons.createAlias(
    $_aliasNameGenerator(db.families.wifeId, db.persons.id),
  );

  $$PersonsTableProcessedTableManager? get wifeId {
    final $_column = $_itemColumn<int>('wife_id');
    if ($_column == null) return null;
    final manager = $$PersonsTableTableManager(
      $_db,
      $_db.persons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wifeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FamiliesTableFilterComposer
    extends Composer<_$AppDatabase, $FamiliesTable> {
  $$FamiliesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gedcomXref => $composableBuilder(
    column: $table.gedcomXref,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get marriageDate => $composableBuilder(
    column: $table.marriageDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get divorceDate => $composableBuilder(
    column: $table.divorceDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonsTableFilterComposer get husbandId {
    final $$PersonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.husbandId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableFilterComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonsTableFilterComposer get wifeId {
    final $$PersonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wifeId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableFilterComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FamiliesTableOrderingComposer
    extends Composer<_$AppDatabase, $FamiliesTable> {
  $$FamiliesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gedcomXref => $composableBuilder(
    column: $table.gedcomXref,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get marriageDate => $composableBuilder(
    column: $table.marriageDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get divorceDate => $composableBuilder(
    column: $table.divorceDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonsTableOrderingComposer get husbandId {
    final $$PersonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.husbandId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableOrderingComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonsTableOrderingComposer get wifeId {
    final $$PersonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wifeId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableOrderingComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FamiliesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FamiliesTable> {
  $$FamiliesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get gedcomXref => $composableBuilder(
    column: $table.gedcomXref,
    builder: (column) => column,
  );

  GeneratedColumn<String> get marriageDate => $composableBuilder(
    column: $table.marriageDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get divorceDate => $composableBuilder(
    column: $table.divorceDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonsTableAnnotationComposer get husbandId {
    final $$PersonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.husbandId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableAnnotationComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonsTableAnnotationComposer get wifeId {
    final $$PersonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wifeId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableAnnotationComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FamiliesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FamiliesTable,
          FamilyRow,
          $$FamiliesTableFilterComposer,
          $$FamiliesTableOrderingComposer,
          $$FamiliesTableAnnotationComposer,
          $$FamiliesTableCreateCompanionBuilder,
          $$FamiliesTableUpdateCompanionBuilder,
          (FamilyRow, $$FamiliesTableReferences),
          FamilyRow,
          PrefetchHooks Function({bool projectId, bool husbandId, bool wifeId})
        > {
  $$FamiliesTableTableManager(_$AppDatabase db, $FamiliesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FamiliesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FamiliesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FamiliesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> projectId = const Value.absent(),
                Value<String?> gedcomXref = const Value.absent(),
                Value<int?> husbandId = const Value.absent(),
                Value<int?> wifeId = const Value.absent(),
                Value<String?> marriageDate = const Value.absent(),
                Value<String?> divorceDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => FamiliesCompanion(
                id: id,
                projectId: projectId,
                gedcomXref: gedcomXref,
                husbandId: husbandId,
                wifeId: wifeId,
                marriageDate: marriageDate,
                divorceDate: divorceDate,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int projectId,
                Value<String?> gedcomXref = const Value.absent(),
                Value<int?> husbandId = const Value.absent(),
                Value<int?> wifeId = const Value.absent(),
                Value<String?> marriageDate = const Value.absent(),
                Value<String?> divorceDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => FamiliesCompanion.insert(
                id: id,
                projectId: projectId,
                gedcomXref: gedcomXref,
                husbandId: husbandId,
                wifeId: wifeId,
                marriageDate: marriageDate,
                divorceDate: divorceDate,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FamiliesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({projectId = false, husbandId = false, wifeId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (projectId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.projectId,
                                    referencedTable: $$FamiliesTableReferences
                                        ._projectIdTable(db),
                                    referencedColumn: $$FamiliesTableReferences
                                        ._projectIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (husbandId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.husbandId,
                                    referencedTable: $$FamiliesTableReferences
                                        ._husbandIdTable(db),
                                    referencedColumn: $$FamiliesTableReferences
                                        ._husbandIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (wifeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.wifeId,
                                    referencedTable: $$FamiliesTableReferences
                                        ._wifeIdTable(db),
                                    referencedColumn: $$FamiliesTableReferences
                                        ._wifeIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$FamiliesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FamiliesTable,
      FamilyRow,
      $$FamiliesTableFilterComposer,
      $$FamiliesTableOrderingComposer,
      $$FamiliesTableAnnotationComposer,
      $$FamiliesTableCreateCompanionBuilder,
      $$FamiliesTableUpdateCompanionBuilder,
      (FamilyRow, $$FamiliesTableReferences),
      FamilyRow,
      PrefetchHooks Function({bool projectId, bool husbandId, bool wifeId})
    >;
typedef $$ContactsTableCreateCompanionBuilder =
    ContactsCompanion Function({
      Value<int> id,
      required int projectId,
      required int personId,
      required String provider,
      required String contactType,
      required String value,
      Value<String?> label,
      Value<String?> providerContactId,
      Value<int> sortOrder,
      Value<String?> notes,
      Value<int?> createdAt,
      Value<int?> updatedAt,
    });
typedef $$ContactsTableUpdateCompanionBuilder =
    ContactsCompanion Function({
      Value<int> id,
      Value<int> projectId,
      Value<int> personId,
      Value<String> provider,
      Value<String> contactType,
      Value<String> value,
      Value<String?> label,
      Value<String?> providerContactId,
      Value<int> sortOrder,
      Value<String?> notes,
      Value<int?> createdAt,
      Value<int?> updatedAt,
    });

final class $$ContactsTableReferences
    extends BaseReferences<_$AppDatabase, $ContactsTable, ContactRow> {
  $$ContactsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProjectsTable _projectIdTable(_$AppDatabase db) => db.projects
      .createAlias($_aliasNameGenerator(db.contacts.projectId, db.projects.id));

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<int>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PersonsTable _personIdTable(_$AppDatabase db) => db.persons
      .createAlias($_aliasNameGenerator(db.contacts.personId, db.persons.id));

  $$PersonsTableProcessedTableManager get personId {
    final $_column = $_itemColumn<int>('person_id')!;

    final manager = $$PersonsTableTableManager(
      $_db,
      $_db.persons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_personIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ContactsTableFilterComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactType => $composableBuilder(
    column: $table.contactType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get providerContactId => $composableBuilder(
    column: $table.providerContactId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonsTableFilterComposer get personId {
    final $$PersonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableFilterComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContactsTableOrderingComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactType => $composableBuilder(
    column: $table.contactType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get providerContactId => $composableBuilder(
    column: $table.providerContactId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonsTableOrderingComposer get personId {
    final $$PersonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableOrderingComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContactsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get provider =>
      $composableBuilder(column: $table.provider, builder: (column) => column);

  GeneratedColumn<String> get contactType => $composableBuilder(
    column: $table.contactType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get providerContactId => $composableBuilder(
    column: $table.providerContactId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonsTableAnnotationComposer get personId {
    final $$PersonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableAnnotationComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContactsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ContactsTable,
          ContactRow,
          $$ContactsTableFilterComposer,
          $$ContactsTableOrderingComposer,
          $$ContactsTableAnnotationComposer,
          $$ContactsTableCreateCompanionBuilder,
          $$ContactsTableUpdateCompanionBuilder,
          (ContactRow, $$ContactsTableReferences),
          ContactRow,
          PrefetchHooks Function({bool projectId, bool personId})
        > {
  $$ContactsTableTableManager(_$AppDatabase db, $ContactsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContactsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContactsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContactsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> projectId = const Value.absent(),
                Value<int> personId = const Value.absent(),
                Value<String> provider = const Value.absent(),
                Value<String> contactType = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<String?> label = const Value.absent(),
                Value<String?> providerContactId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int?> createdAt = const Value.absent(),
                Value<int?> updatedAt = const Value.absent(),
              }) => ContactsCompanion(
                id: id,
                projectId: projectId,
                personId: personId,
                provider: provider,
                contactType: contactType,
                value: value,
                label: label,
                providerContactId: providerContactId,
                sortOrder: sortOrder,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int projectId,
                required int personId,
                required String provider,
                required String contactType,
                required String value,
                Value<String?> label = const Value.absent(),
                Value<String?> providerContactId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int?> createdAt = const Value.absent(),
                Value<int?> updatedAt = const Value.absent(),
              }) => ContactsCompanion.insert(
                id: id,
                projectId: projectId,
                personId: personId,
                provider: provider,
                contactType: contactType,
                value: value,
                label: label,
                providerContactId: providerContactId,
                sortOrder: sortOrder,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ContactsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({projectId = false, personId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (projectId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.projectId,
                                referencedTable: $$ContactsTableReferences
                                    ._projectIdTable(db),
                                referencedColumn: $$ContactsTableReferences
                                    ._projectIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (personId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.personId,
                                referencedTable: $$ContactsTableReferences
                                    ._personIdTable(db),
                                referencedColumn: $$ContactsTableReferences
                                    ._personIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ContactsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ContactsTable,
      ContactRow,
      $$ContactsTableFilterComposer,
      $$ContactsTableOrderingComposer,
      $$ContactsTableAnnotationComposer,
      $$ContactsTableCreateCompanionBuilder,
      $$ContactsTableUpdateCompanionBuilder,
      (ContactRow, $$ContactsTableReferences),
      ContactRow,
      PrefetchHooks Function({bool projectId, bool personId})
    >;
typedef $$PlacesTableCreateCompanionBuilder =
    PlacesCompanion Function({
      Value<int> id,
      required String name,
      Value<double?> latitude,
      Value<double?> longitude,
    });
typedef $$PlacesTableUpdateCompanionBuilder =
    PlacesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<double?> latitude,
      Value<double?> longitude,
    });

class $$PlacesTableFilterComposer
    extends Composer<_$AppDatabase, $PlacesTable> {
  $$PlacesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlacesTableOrderingComposer
    extends Composer<_$AppDatabase, $PlacesTable> {
  $$PlacesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlacesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlacesTable> {
  $$PlacesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);
}

class $$PlacesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlacesTable,
          PlaceRow,
          $$PlacesTableFilterComposer,
          $$PlacesTableOrderingComposer,
          $$PlacesTableAnnotationComposer,
          $$PlacesTableCreateCompanionBuilder,
          $$PlacesTableUpdateCompanionBuilder,
          (PlaceRow, BaseReferences<_$AppDatabase, $PlacesTable, PlaceRow>),
          PlaceRow,
          PrefetchHooks Function()
        > {
  $$PlacesTableTableManager(_$AppDatabase db, $PlacesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlacesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlacesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlacesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
              }) => PlacesCompanion(
                id: id,
                name: name,
                latitude: latitude,
                longitude: longitude,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
              }) => PlacesCompanion.insert(
                id: id,
                name: name,
                latitude: latitude,
                longitude: longitude,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlacesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlacesTable,
      PlaceRow,
      $$PlacesTableFilterComposer,
      $$PlacesTableOrderingComposer,
      $$PlacesTableAnnotationComposer,
      $$PlacesTableCreateCompanionBuilder,
      $$PlacesTableUpdateCompanionBuilder,
      (PlaceRow, BaseReferences<_$AppDatabase, $PlacesTable, PlaceRow>),
      PlaceRow,
      PrefetchHooks Function()
    >;
typedef $$PersonRelationsTableCreateCompanionBuilder =
    PersonRelationsCompanion Function({
      Value<int> id,
      required int projectId,
      required int personId,
      required int relatedPersonId,
      required String kind,
    });
typedef $$PersonRelationsTableUpdateCompanionBuilder =
    PersonRelationsCompanion Function({
      Value<int> id,
      Value<int> projectId,
      Value<int> personId,
      Value<int> relatedPersonId,
      Value<String> kind,
    });

final class $$PersonRelationsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PersonRelationsTable,
          PersonRelationRow
        > {
  $$PersonRelationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProjectsTable _projectIdTable(_$AppDatabase db) =>
      db.projects.createAlias(
        $_aliasNameGenerator(db.personRelations.projectId, db.projects.id),
      );

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<int>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PersonsTable _personIdTable(_$AppDatabase db) =>
      db.persons.createAlias(
        $_aliasNameGenerator(db.personRelations.personId, db.persons.id),
      );

  $$PersonsTableProcessedTableManager get personId {
    final $_column = $_itemColumn<int>('person_id')!;

    final manager = $$PersonsTableTableManager(
      $_db,
      $_db.persons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_personIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PersonsTable _relatedPersonIdTable(_$AppDatabase db) =>
      db.persons.createAlias(
        $_aliasNameGenerator(db.personRelations.relatedPersonId, db.persons.id),
      );

  $$PersonsTableProcessedTableManager get relatedPersonId {
    final $_column = $_itemColumn<int>('related_person_id')!;

    final manager = $$PersonsTableTableManager(
      $_db,
      $_db.persons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_relatedPersonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PersonRelationsTableFilterComposer
    extends Composer<_$AppDatabase, $PersonRelationsTable> {
  $$PersonRelationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonsTableFilterComposer get personId {
    final $$PersonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableFilterComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonsTableFilterComposer get relatedPersonId {
    final $$PersonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.relatedPersonId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableFilterComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PersonRelationsTableOrderingComposer
    extends Composer<_$AppDatabase, $PersonRelationsTable> {
  $$PersonRelationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonsTableOrderingComposer get personId {
    final $$PersonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableOrderingComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonsTableOrderingComposer get relatedPersonId {
    final $$PersonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.relatedPersonId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableOrderingComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PersonRelationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PersonRelationsTable> {
  $$PersonRelationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonsTableAnnotationComposer get personId {
    final $$PersonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.personId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableAnnotationComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PersonsTableAnnotationComposer get relatedPersonId {
    final $$PersonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.relatedPersonId,
      referencedTable: $db.persons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PersonsTableAnnotationComposer(
            $db: $db,
            $table: $db.persons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PersonRelationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PersonRelationsTable,
          PersonRelationRow,
          $$PersonRelationsTableFilterComposer,
          $$PersonRelationsTableOrderingComposer,
          $$PersonRelationsTableAnnotationComposer,
          $$PersonRelationsTableCreateCompanionBuilder,
          $$PersonRelationsTableUpdateCompanionBuilder,
          (PersonRelationRow, $$PersonRelationsTableReferences),
          PersonRelationRow,
          PrefetchHooks Function({
            bool projectId,
            bool personId,
            bool relatedPersonId,
          })
        > {
  $$PersonRelationsTableTableManager(
    _$AppDatabase db,
    $PersonRelationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PersonRelationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PersonRelationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PersonRelationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> projectId = const Value.absent(),
                Value<int> personId = const Value.absent(),
                Value<int> relatedPersonId = const Value.absent(),
                Value<String> kind = const Value.absent(),
              }) => PersonRelationsCompanion(
                id: id,
                projectId: projectId,
                personId: personId,
                relatedPersonId: relatedPersonId,
                kind: kind,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int projectId,
                required int personId,
                required int relatedPersonId,
                required String kind,
              }) => PersonRelationsCompanion.insert(
                id: id,
                projectId: projectId,
                personId: personId,
                relatedPersonId: relatedPersonId,
                kind: kind,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PersonRelationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({projectId = false, personId = false, relatedPersonId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (projectId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.projectId,
                                    referencedTable:
                                        $$PersonRelationsTableReferences
                                            ._projectIdTable(db),
                                    referencedColumn:
                                        $$PersonRelationsTableReferences
                                            ._projectIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (personId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.personId,
                                    referencedTable:
                                        $$PersonRelationsTableReferences
                                            ._personIdTable(db),
                                    referencedColumn:
                                        $$PersonRelationsTableReferences
                                            ._personIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (relatedPersonId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.relatedPersonId,
                                    referencedTable:
                                        $$PersonRelationsTableReferences
                                            ._relatedPersonIdTable(db),
                                    referencedColumn:
                                        $$PersonRelationsTableReferences
                                            ._relatedPersonIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$PersonRelationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PersonRelationsTable,
      PersonRelationRow,
      $$PersonRelationsTableFilterComposer,
      $$PersonRelationsTableOrderingComposer,
      $$PersonRelationsTableAnnotationComposer,
      $$PersonRelationsTableCreateCompanionBuilder,
      $$PersonRelationsTableUpdateCompanionBuilder,
      (PersonRelationRow, $$PersonRelationsTableReferences),
      PersonRelationRow,
      PrefetchHooks Function({
        bool projectId,
        bool personId,
        bool relatedPersonId,
      })
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db, _db.projects);
  $$PersonsTableTableManager get persons =>
      $$PersonsTableTableManager(_db, _db.persons);
  $$FamiliesTableTableManager get families =>
      $$FamiliesTableTableManager(_db, _db.families);
  $$ContactsTableTableManager get contacts =>
      $$ContactsTableTableManager(_db, _db.contacts);
  $$PlacesTableTableManager get places =>
      $$PlacesTableTableManager(_db, _db.places);
  $$PersonRelationsTableTableManager get personRelations =>
      $$PersonRelationsTableTableManager(_db, _db.personRelations);
}
