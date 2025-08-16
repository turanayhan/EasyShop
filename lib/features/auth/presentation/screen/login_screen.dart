import 'package:case1/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:case1/features/auth/presentation/bloc/auth_event.dart';
import 'package:case1/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/app_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Login", style: TextStyle(fontSize: 20.sp)),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.isSuccess) {
              Navigator.pushReplacementNamed(context, AppRoutes.home);
            }
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                // Logo
                Padding(
                  padding: EdgeInsets.only(bottom: 32.h),
                  child: Image.asset('assets/logo.png', height: 100.h),
                ),
                TextField(
                  controller: emailController,
                  onChanged: (value) =>
                      context.read<AuthBloc>().add(LoginEmailChanged(value)),
                  decoration: InputDecoration(
                    labelText: "E-posta",
                    labelStyle: TextStyle(fontSize: 16.sp),
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16.h),
                TextField(
                  controller: passwordController,
                  onChanged: (value) =>
                      context.read<AuthBloc>().add(LoginPasswordChanged(value)),
                  decoration: InputDecoration(
                    labelText: "Şifre",
                    labelStyle: TextStyle(fontSize: 16.sp),
                    border: const OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: state.isLoading
                        ? null
                        : () {
                            context.read<AuthBloc>().add(LoginSubmitted());
                          },
                    child: state.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text("Giriş Yap", style: TextStyle(fontSize: 18.sp)),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Hesabınız yoksa? ",
                      style: TextStyle(fontSize: 15.sp),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.register);
                      },
                      child: Text(
                        "Kaydol",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
