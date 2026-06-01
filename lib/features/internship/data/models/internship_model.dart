class CategoryModel {
  final int id;
  final String name;

  const CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}

class InternshipModel {
  final int id;
  final String name;
  final String city;
  final int? categoryId;
  final String? description;
  final CategoryModel? category;

  const InternshipModel({
    required this.id,
    required this.name,
    required this.city,
    this.categoryId,
    this.description,
    this.category,
  });

  factory InternshipModel.fromJson(Map<String, dynamic> json) {
    return InternshipModel(
      id: json['id'] as int,
      name: json['name'] as String,
      city: json['city'] as String,
      categoryId: json['category_id'] as int?,
      description: json['description'] as String?,
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'] as Map<String, dynamic>)
          : null,
    );
  }
}
