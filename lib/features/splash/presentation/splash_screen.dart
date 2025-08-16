import 'package:case1/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:case1/features/auth/presentation/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AppStarted());

    // Splash ekranını 2 saniye göster, sonra state kontrol et
    Future.delayed(const Duration(seconds: 2), () {
      final state = context.read<AuthBloc>().state;
      if (state.isSuccess) {
        Navigator.pushReplacementNamed(context, '/main');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100.w,
              height: 100.w,
              color: Colors.blue,
              child: Image.asset('assets/logo.png'),
            ),
            const SizedBox(height: 20),
            Text(
              'EasyShop',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
