import 'dart:ui' as BorderType;

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tharad_tech/core/constants/app_colors.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/gradient_button.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Gap(20),
                  Image.asset('assets/images/logo.png', width: 178, height: 58),
                  const Gap(30),

                  const Text(
                    'إنشاء حساب جديد',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                  const Gap(24),

                  const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'الصورة الشخصية',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const Gap(8),

                  GestureDetector(
                    onTap: () {
                      debugPrint("Open Image Picker");
                    },
                    child: DottedBorder(
                      dashPattern: <double>[10, 10],
                      color: AppColors.primary,
                      strokeWidth: 1.5,
                      radius: Radius.circular(12),
                      padding: EdgeInsets.zero,
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xFFF4F7F6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.camera_alt_outlined,
                              color: AppColors.primary,
                              size: 30,
                            ),
                            Gap(8),
                            Text(
                              "الملفات المسموح بها : JPEG , PNG",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const Gap(24),

                  const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'اسم المستخدم',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const Gap(8),
                  CustomTextField(
                    label: 'User123',
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'اسم المستخدم مطلوب';
                      return null;
                    },
                    suffixIcon: null,
                  ),
                  const Gap(16),

                  const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'البريد الإلكتروني',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const Gap(8),
                  CustomTextField(
                    label: 'Tharad@gmail.com',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'البريد الإلكتروني مطلوب';
                      if (!value.contains('@'))
                        return 'أدخل بريد إلكتروني صالح';
                      return null;
                    },
                    suffixIcon: null,
                  ),
                  const Gap(16),

                  const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'كلمة المرور',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const Gap(8),
                  CustomTextField(
                    label: '********',
                    controller: passwordController,
                    isPassword: !isPasswordVisible, // Logic Toggle
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'كلمة المرور مطلوبة';
                      if (value.length < 6)
                        return 'يجب أن تكون 6 أحرف على الأقل';
                      return null;
                    },
                  ),
                  const Gap(16),

                  const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'تأكيد كلمة المرور',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const Gap(8),
                  CustomTextField(
                    label: '********',
                    controller: confirmPasswordController,
                    isPassword: !isConfirmPasswordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          isConfirmPasswordVisible = !isConfirmPasswordVisible;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'تأكيد كلمة المرور مطلوب';
                      if (value != passwordController.text)
                        return 'كلمات المرور غير متطابقة';
                      return null;
                    },
                  ),
                  const Gap(32),

                  GradientButton(
                    text: 'إنشاء حساب جديد',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        debugPrint('Signup Success: ${nameController.text}');
                        // Implement Sign up Logic here
                      }
                    },
                  ),

                  const Gap(16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('لديك حساب ؟'),
                      TextButton(
                        onPressed: () {},
                        child: const Text('تسجيل الدخول'),
                      ),
                    ],
                  ),
                  const Gap(20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
