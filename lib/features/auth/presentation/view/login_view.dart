import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tharad_tech/features/auth/presentation/view/signup_view.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/language_switcher.dart';
import '../../../main_layout/presentation/view/main_layout_view.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/gradient_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool rememberMe = false;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Gap(80),
                const LanguageSwitcher(),
                Gap(90.h),

                Image.asset(
                  'assets/images/logo.png',
                  width: 178.w,
                  height: 58.h,
                ),
                Gap(100.h),
                Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Tajawal',
                  ),
                ),
                Gap(24.h),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'البريد الإلكتروني',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ),
                Gap(8.h),
                CustomTextField(
                  label: 'Tharad@gmail.com',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  fontSize: 12.sp,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'البريد الإلكتروني مطلوب';
                    }
                    if (!value.contains('@')) {
                      return 'أدخل بريد إلكتروني صالح';
                    }
                    return null;
                  },
                ),
                Gap(24.h),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'كلمة المرور',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ),
                Gap(8.h),
                CustomTextField(
                  label: '********',
                  controller: passwordController,
                  isPassword: true,
                  fontSize: 12.sp,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.primary,
                      size: 20.sp,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'كلمة المرور مطلوبة';
                    }
                    if (value.length < 6) {
                      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          onChanged: (value) {
                            setState(() {
                              rememberMe = value ?? false;
                            });
                          },
                        ),
                        Text(
                          'تذكرني',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'هل نسيت كلمة المرور؟',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(24.h),
                GradientButton(
                  text: 'تسجيل الدخول',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainLayoutView(),
                        ),
                      );
                    }
                  },
                ),
                Gap(16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ليس لديك حساب؟',
                      style: TextStyle(fontSize: 12.sp, fontFamily: 'Tajawal'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupView(),
                          ),
                        );
                      },
                      child: Text(
                        'إنشاء حساب جديد',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
