class Project {
  const Project({
    required this.id,
    required this.name,
    this.description,
    this.locale,
    required this.createdAt,
  });

  final int id;
  final String name;
  final String? description;
  final String? locale;
  final DateTime createdAt;
}

