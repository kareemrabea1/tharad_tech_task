import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xff42867B);
  static const Color background = Colors.white;
  static const Color textPrimary = Colors.black87;
  static const Color textSecondary = Colors.grey;
  static const Color inputBorder = Color(0xFFEEEEEE);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF265355), Color(0xFF54B7BB)],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );
}
