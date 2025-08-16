import 'package:case1/features/home/data/models/product.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../features/auth/data/model/user_model.dart';

class AppInitializer {
  static Future<void> initHive() async {
    await Hive.initFlutter();

    // Hive Adapter kayıtları
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(ProductAdapter());

    // Box açılışları
    await Hive.openBox<User>('usersBox');
    await Hive.openBox('settingsBox');
    await Hive.openBox<Product>('productBox');
  }
}
