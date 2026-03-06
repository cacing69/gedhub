/// Model domain untuk individu (Person).
/// Fields disesuaikan dengan DDL supports/data/persons.ddl.sql
class Person {
  const Person({
    required this.id,
    required this.projectId,
    this.gedcomXref,
    required this.givenName,
    required this.surname,
    this.nickname,
    this.gender,
    this.birthDate,
    this.deathDate,
    this.birthPlaceId,
    this.deathPlaceId,
    required this.isLiving,
    this.notes,
  });

  final int id;
  final int projectId;
  final String? gedcomXref;
  final String givenName;
  final String surname;
  final String? nickname;
  final String? gender;
  final String? birthDate;
  final String? deathDate;
  final int? birthPlaceId;
  final int? deathPlaceId;
  final bool isLiving;
  final String? notes;

  /// Nama lengkap untuk display (givenName + surname)
  String get fullName => '$givenName ${surname ?? ''}'.trim();

  Person copyWith({
    int? id,
    int? projectId,
    String? gedcomXref,
    String? givenName,
    String? surname,
    String? nickname,
    String? gender,
    String? birthDate,
    String? deathDate,
    int? birthPlaceId,
    int? deathPlaceId,
    bool? isLiving,
    String? notes,
  }) {
    return Person(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      gedcomXref: gedcomXref ?? this.gedcomXref,
      givenName: givenName ?? this.givenName,
      surname: surname ?? this.surname,
      nickname: nickname ?? this.nickname,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      deathDate: deathDate ?? this.deathDate,
      birthPlaceId: birthPlaceId ?? this.birthPlaceId,
      deathPlaceId: deathPlaceId ?? this.deathPlaceId,
      isLiving: isLiving ?? this.isLiving,
      notes: notes ?? this.notes,
    );
  }
}

/// Model domain untuk kontak (Contact).
/// Fields disesuaikan dengan DDL supports/data/contacts.ddl.sql
class Contact {
  const Contact({
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

  Contact copyWith({
    int? id,
    int? projectId,
    int? personId,
    String? provider,
    String? contactType,
    String? value,
    String? label,
    String? providerContactId,
    int? sortOrder,
    String? notes,
    int? createdAt,
    int? updatedAt,
  }) {
    return Contact(
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
}
