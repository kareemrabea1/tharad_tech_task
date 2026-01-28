import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'features/auth/presentation/view/login_view.dart';
import 'features/home/presentation/view/home_view.dart';
import 'features/main_layout/presentation/view/main_layout_view.dart';
import 'features/profile/presentation/view/profile_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tharad Tech',
          theme: ThemeData(
            // تصحيح ColorScheme
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            fontFamily: 'Tajawal',
            // تفعيل Material 3
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: const ProfileView(),
        );
      },
    );
  }
}
