class ProjectEntity {
  final String? id;
  final String name;
  final String category;
  final DateTime startDate;
  final DateTime? endDate;
  final String description;
  final String imageUrl;

  ProjectEntity({
    this.id,
    required this.name,
    required this.category,
    required this.startDate,
    this.endDate,
    required this.description,
    required this.imageUrl,
  });
}
