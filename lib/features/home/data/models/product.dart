import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 1)
class Product extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final int stock;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final String imageUrl;

  @HiveField(6)
  final double? discount;

  @HiveField(7)
  int? quantity; // Burada quantity ekleniyor

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.description,
    required this.imageUrl,
    this.discount,
    this.quantity = 1, // default 1 olarak
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      stock: json['stock'],
      description: json['description'],
      imageUrl: json['image_url'],
      discount: json['discount'] != null
          ? (json['discount'] as num).toDouble()
          : null,
      quantity: json['quantity'] ?? 1, // JSON'dan gelirse kullan, yoksa 1
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

extension ProductCopyWith on Product {
  Product copyWith({
    String? id,
    String? name,
    double? price,
    int? stock,
    String? description,
    String? imageUrl,
    double? discount,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      discount: discount ?? this.discount,
      quantity: quantity ?? this.quantity,
    );
  }
}
