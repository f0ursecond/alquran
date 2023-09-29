class Product {
  final int id;
  final int userId;
  final String title;
  final bool completed;

  Product(
      {required this.id,
      required this.userId,
      required this.title,
      required this.completed});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      completed: json['completed'],
    );
  }
}
