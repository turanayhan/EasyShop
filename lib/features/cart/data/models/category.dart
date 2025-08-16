import 'package:case1/features/home/data/models/product.dart';

class Category {
  final String name;
  final List<Product> products;

  Category({required this.name, required this.products});

  factory Category.fromJson(Map<String, dynamic> json) {
    var productsJson = json['products'] as List;
    List<Product> products = productsJson
        .map((p) => Product.fromJson(p))
        .toList();

    return Category(name: json['name'], products: products);
  }
}
