class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String imageUrl;
  final double? rating;
  final int? ratingCount;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.imageUrl,
    this.rating,
    this.ratingCount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final ratingObj = json['rating'] as Map<String, dynamic>?;
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      category: json['category'] as String,
      imageUrl: json['image'] as String,
      rating: ratingObj != null ? (ratingObj['rate'] as num?)?.toDouble() : null,
      ratingCount: ratingObj != null ? (ratingObj['count'] as num?)?.toInt() : null,
    );
  }
}
