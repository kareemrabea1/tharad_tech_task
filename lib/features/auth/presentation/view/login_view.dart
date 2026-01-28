import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tharad_tech/features/auth/presentation/view/signup_view.dart';
import '../../../../core/constants/app_colors.dart';
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
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Gap(100),

                Image.asset('assets/images/logo.png', width: 178, height: 58),
                const Gap(100),

                const Text(
                  'تسجيل الدخول',
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
                    'البريد الإلكتروني',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10),
                  ),
                ),
                const Gap(8),
                CustomTextField(
                  label: 'Tharad@gmail.com',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
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
                const Gap(24),

                const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'كلمة المرور',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10),
                  ),
                ),
                const Gap(8),
                CustomTextField(
                  label: '********',
                  controller: passwordController,
                  isPassword: true,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.primary,
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
                        const Text(
                          'تذكرني',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'هل نسيت كلمة المرور؟',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(24),

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

                const Gap(16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('ليس لديك حساب؟'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupView(),
                          ),
                        );
                      },
                      child: const Text('إنشاء حساب جديد'),
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
