import 'package:case1/core/init/app_initializer.dart';
import 'package:case1/features/auth/data/auth_repository.dart';
import 'package:case1/features/auth/data/model/user_model.dart';
import 'package:case1/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:case1/features/cart/data/card_repository.dart';
import 'package:case1/features/home/data/models/product.dart';
import 'package:case1/features/home/data/product_repository.dart';
import 'package:case1/features/profile/data/profile_repository.dart';
import 'package:case1/features/cart/presentation/bloc/card_bloc.dart';
import 'package:case1/features/home/presentation/bloc/product_bloc.dart';
import 'package:case1/features/home/presentation/bloc/product_event.dart';
import 'package:case1/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:case1/features/profile/presentation/bloc/profile_event.dart';
import 'package:case1/config/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive başlatılıyor
  await AppInitializer.initHive();

  final userBox = Hive.box<User>('usersBox');
  final settingsBox = Hive.box('settingsBox');
  final productBox = Hive.box<Product>('productBox');

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CartCubit(CartRepository(productBox)),
        ),
        BlocProvider(
          create: (context) => AuthBloc(
            authRepository: AuthRepository(
              userBox: userBox,
              settingsBox: settingsBox,
            ),
          ),
        ),
        BlocProvider(
          create: (context) =>
              ProductBloc(ProductRepository())..add(LoadProducts()),
        ),

        // Buraya UserBloc ekleniyor:
        BlocProvider(
          create: (context) => ProfileBloc(UserRepository(userBox))..add(LoadUser()),
        ),

       
      ],
      child: const MyApp(),
    ),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 915),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.splash,
          onGenerateRoute: AppRoutes.generateRoute,
          theme: ThemeData(primarySwatch: Colors.blue),
        );
      },
    );
  }
}
