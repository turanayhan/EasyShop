import 'package:case1/features/auth/presentation/screen/register.dart';
import 'package:case1/features/main/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';
import '../features/auth/presentation/screen/login_screen.dart';
import '../features/splash/presentation/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/main';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const MainScreen());

      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("404 - Sayfa bulunamadı")),
          ),
        );
    }
  }
}
