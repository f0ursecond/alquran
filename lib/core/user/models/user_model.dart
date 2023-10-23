class UserModel {
  final String name;
  final String avatarUrl;
  final String age;
  final String id;

  UserModel({
    required this.name,
    required this.avatarUrl,
    required this.age,
    required this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      avatarUrl: json['avatarUrl'],
      age: json['age'],
      id: json['id'],
    );
  }
}
