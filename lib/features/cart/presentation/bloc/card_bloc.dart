import 'package:case1/features/cart/data/card_repository.dart';
import 'package:case1/features/home/data/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<List<Product>> {
  final CartRepository repository;

  CartCubit(this.repository) : super(repository.getCartProducts());

  /// Ürün sepette varsa quantity'yi artırır, yoksa ekler
  void addProduct(Product product) {
    repository.addProduct(product); // bu metot zaten quantity artırıyor
    emit(repository.getCartProducts());
  }

  /// Quantity güncellemesi (örneğin artır/azalt)
  void updateProductQuantity(Product product, int newQuantity) {
    if (newQuantity < 1) {
      removeProduct(product);
    } else {
      final updated = product.copyWith(quantity: newQuantity);
      repository.updateProduct(updated);
      emit(repository.getCartProducts());
    }
  }

  /// Ürünü sepetten tamamen kaldırır
  void removeProduct(Product product) {
    repository.removeProduct(product);
    emit(repository.getCartProducts());
  }

  /// Tüm sepeti temizler
  void clearCart() {
    repository.clearCart();
    emit(repository.getCartProducts());
  }

  /// Kontrol: Sepette var mı?
  bool isInCart(Product product) {
    return repository.isInCart(product);
  }
}
