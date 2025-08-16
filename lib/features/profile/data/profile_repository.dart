import 'package:case1/features/auth/data/model/user_model.dart';
import 'package:hive/hive.dart';


class UserRepository {
  final Box<User> userBox;

  UserRepository(this.userBox);

  Future<bool> register(User user) async {
    final exists = userBox.values.any((u) => u.email == user.email);
    if (exists) return false;

    await userBox.add(user);
    return true;
  }

  Future<User?> getUser() async {
    if (userBox.isEmpty) return null;
    return userBox.getAt(0);
  }
}
