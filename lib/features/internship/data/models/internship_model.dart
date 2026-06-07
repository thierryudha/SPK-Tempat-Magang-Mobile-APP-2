class CategoryModel {
  final int id;
  final String name;

  const CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
    );
  }
}

class InternshipModel {
  final int id;
  final String name;
  final String? websiteLink;
  final int? categoryId;
  final CategoryModel? category;

  const InternshipModel({
    required this.id,
    required this.name,
    this.websiteLink,
    this.categoryId,
    this.category,
  });

  factory InternshipModel.fromJson(Map<String, dynamic> json) {
    return InternshipModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      websiteLink: json['website_link'] as String?,
      categoryId: json['category_id'] as int?,
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'] as Map<String, dynamic>)
          : null,
    );
  }
}
