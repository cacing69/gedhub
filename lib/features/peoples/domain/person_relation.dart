import 'package:gedhub/features/peoples/domain/person.dart';

/// Jenis relasi antar person (disimpan sebagai string di DB).
/// parent: personId = orang tua, relatedPersonId = anak.
enum PersonRelationKind {
  parent('parent', 'Orang tua', 'Anak'),
  spouse('spouse', 'Pasangan', 'Pasangan'),
  sibling('sibling', 'Saudara', 'Saudara');

  const PersonRelationKind(this.value, this.labelAsFrom, this.labelAsTo);
  final String value;
  final String labelAsFrom; // label bila person adalah "dari" (mis. orang tua)
  final String labelAsTo;   // label bila person adalah "ke" (mis. anak)

  static PersonRelationKind? fromString(String? v) {
    if (v == null) return null;
    for (final e in PersonRelationKind.values) {
      if (e.value == v) return e;
    }
    return null;
  }
}

/// Model domain untuk satu baris relasi (koneksi antar dua person).
class PersonRelation {
  const PersonRelation({
    required this.id,
    required this.projectId,
    required this.personId,
    required this.relatedPersonId,
    required this.kind,
  });

  final int id;
  final int projectId;
  final int personId;
  final int relatedPersonId;
  final String kind;

  PersonRelationKind? get kindEnum => PersonRelationKind.fromString(kind);
}

/// Satu entri relasi untuk ditampilkan di UI: relasi + person di sisi lain + label.
class PersonRelationDisplay {
  const PersonRelationDisplay({
    required this.relation,
    required this.otherPerson,
    required this.label,
  });

  final PersonRelation relation;
  final Person otherPerson;
  final String label;
}
