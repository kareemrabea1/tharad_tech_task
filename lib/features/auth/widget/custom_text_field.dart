import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart'; // تأكد من مسار الألوان

class CustomTextField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final bool isPassword; // هل الحقل ده باسورد؟
  final Widget? suffixIcon; // لو عايز أيقونة تانية غير العين
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final double? fontSize;

  const CustomTextField({
    super.key,
    required this.label,
    this.controller,
    this.isPassword = false, // القيمة الافتراضية: مش باسورد
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.fontSize,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // متغير داخلي للتحكم في ظهور النص
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    // لو مش باسورد أصلاً، خلي النص ظاهر علطول
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      // هنا السر: بنتحكم في الإخفاء بناءً على المتغير
      obscureText: widget.isPassword ? _obscureText : false,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      style: TextStyle(
        color: Colors.black,
        fontSize: widget.fontSize ?? 14.0,
        fontFamily: 'Tajawal',
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF9F9F9),
        hintText: widget.label,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
          fontFamily: 'Tajawal',
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2D8B86)), // لون البراند
        ),
        // اللوجيك بتاع الأيقونة
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText; // اعكس الحالة
                  });
                },
                icon: Icon(
                  // غير شكل العين حسب الحالة
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.primary, // أو اللون اللي تحبه
                ),
              )
            : widget.suffixIcon,
      ),
    );
  }
}
