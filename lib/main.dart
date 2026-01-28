import 'package:flutter/material.dart';

import 'features/auth/presentation/view/login_view.dart';
import 'features/auth/presentation/view/otp_view.dart';
import 'features/auth/presentation/view/singup_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tharad Tech',

      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.white)),
      home: OtpView(email: ''),
    );
  }
}
