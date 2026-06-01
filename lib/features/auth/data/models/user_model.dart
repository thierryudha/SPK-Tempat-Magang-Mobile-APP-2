class UserModel {
  final int id;
  final String name;
  final String email;
  final String? photo;
  final String role;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.photo,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      photo: json['photo'] as String?,
      role: json['role'] as String? ?? 'user',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'photo': photo,
        'role': role,
      };
}
