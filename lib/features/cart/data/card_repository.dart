import 'package:case1/features/home/data/models/product.dart';
import 'package:hive/hive.dart';

class CartRepository {
  final Box<Product> cartBox;

  CartRepository(this.cartBox);

  List<Product> getCartProducts() {
    return cartBox.values.toList();
  }

  void addProduct(Product product) {
    if (!cartBox.containsKey(product.id)) {
      cartBox.put(product.id, product);
    }
  }

  void updateProduct(Product product) {
    if (cartBox.containsKey(product.id)) {
      cartBox.put(product.id, product); // var olanı günceller
    }
  }

  void removeProduct(Product product) {
    cartBox.delete(product.id);
  }

  bool isInCart(Product product) {
    return cartBox.containsKey(product.id);
  }

  void clearCart() {
    cartBox.clear();
  }
}
