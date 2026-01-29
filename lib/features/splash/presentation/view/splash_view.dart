import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/pref_helper.dart';
import '../../../auth/presentation/view/login_view.dart';
import '../../../main_layout/presentation/view/main_layout_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    Future.delayed(const Duration(seconds: 2), () {
      var isLogin = PrefHelper.getData(key: 'isLogin');

      if (isLogin == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainLayoutView()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginView()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', width: 200.w, height: 200.h),
            Gap(20.h),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
