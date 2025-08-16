import 'dart:convert';
import 'package:case1/features/cart/data/models/category.dart';
import 'package:flutter/services.dart';

class ProductRepository {
  Future<List<Category>> fetchCategories() async {
    final String response = await rootBundle.loadString(
      'assets/product_data.json',
    );
    final data = json.decode(response);

    List<dynamic> categoriesJson = data['categories'];
    List<Category> categories = categoriesJson
        .map((json) => Category.fromJson(json))
        .toList();
    return categories;
  }
}
