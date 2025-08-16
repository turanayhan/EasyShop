import 'package:hive/hive.dart';
import 'model/user_model.dart';

class AuthRepository {
  static const String userBoxName = "usersBox";
  static const String settingsBoxName = "settingsBox";

  final Box<User> userBox;
  final Box settingsBox;

  AuthRepository({required this.userBox, required this.settingsBox});

  // Login işlemi
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // simülasyon
    final users = userBox.values.where(
      (u) => u.email == email && u.password == password,
    );
    final success = users.isNotEmpty;

    if (success) {
      // Login durumu kaydediliyor
      await settingsBox.put('isLoggedIn', true);
    }

    return success;
  }

  // Logout işlemi
  Future<void> logout() async {
    await settingsBox.put('isLoggedIn', false);
  }

  // Register işlemi
  Future<bool> register(
    String name,
    String phone,
    String email,
    String password,
  ) async {
    await Future.delayed(const Duration(seconds: 1)); // simülasyon
    final exists = userBox.values.any((u) => u.email == email);
    if (exists) return false;

    final user = User(
      name: name,
      phone: phone,
      email: email,
      password: password,
    );
    await userBox.add(user);

    // Kayıt sonrası otomatik login
    await settingsBox.put('isLoggedIn', true);

    return true;
  }

  // Login durumu sorgulama
  bool isLoggedIn() {
    return settingsBox.get('isLoggedIn', defaultValue: false) as bool;
  }
}
