import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/network/dio_client.dart';
import 'core/utils/pref_helper.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/splash/presentation/view/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PrefHelper.init();
  DioClient.init();
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
        return BlocProvider(
          create: (context) => AuthCubit(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Tharad Tech',
            locale: const Locale('ar'),
            supportedLocales: const [Locale('ar')],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
              fontFamily: 'Tajawal',
              useMaterial3: true,
              scaffoldBackgroundColor: Colors.white,
            ),
            home: const SplashView(),
          ),
        );
      },
    );
  }
}
