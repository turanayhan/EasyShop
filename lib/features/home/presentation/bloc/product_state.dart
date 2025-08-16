import 'package:case1/features/cart/data/models/category.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Category> categories;

  ProductLoaded(this.categories);
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}
