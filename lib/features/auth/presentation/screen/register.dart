import 'package:case1/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:case1/features/auth/presentation/bloc/auth_event.dart';
import 'package:case1/features/auth/presentation/bloc/auth_state.dart';
import 'package:case1/config/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Kayıt Ol", style: TextStyle(fontSize: 20.sp)),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.isSuccess) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Kayıt başarılı!")));
              Navigator.pushReplacementNamed(context, AppRoutes.home);
            }
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 32.h),
                  TextField(
                    controller: nameController,
                    onChanged: (value) => context.read<AuthBloc>().add(
                      RegisterNameChanged(value),
                    ),
                    decoration: InputDecoration(
                      labelText: "Ad Soyad",
                      labelStyle: TextStyle(fontSize: 16.sp),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    controller: phoneController,
                    onChanged: (value) => context.read<AuthBloc>().add(
                      RegisterPhoneChanged(value),
                    ),
                    decoration: InputDecoration(
                      labelText: "Telefon",
                      labelStyle: TextStyle(fontSize: 16.sp),
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    controller: emailController,
                    onChanged: (value) => context.read<AuthBloc>().add(
                      RegisterEmailChanged(value),
                    ),
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
                    onChanged: (value) => context.read<AuthBloc>().add(
                      RegisterPasswordChanged(value),
                    ),
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
                              context.read<AuthBloc>().add(RegisterSubmitted());
                            },
                      child: state.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text("Kayıt Ol", style: TextStyle(fontSize: 18.sp)),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
