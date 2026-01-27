import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              const Gap(8),
              CustomTextField(
                label: '********',
                controller: passwordController,
                isPassword: true,
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
                  TextButton(
                    onPressed: () {},
                    child: const Text('هل نسيت كلمة المرور؟'),
                  ),
                  Row(
                    children: [
                      const Text('تذكرني'),
                      Checkbox(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(24),

              GradientButton(
                text: 'تسجيل الدخول',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    debugPrint('Email: ${emailController.text}');
                    debugPrint('Password: ${passwordController.text}');
                    debugPrint('Remember Me: $rememberMe');
                  }
                },
              ),

              const Gap(16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('إنشاء حساب جديد'),
                  ),
                  const Text('ليس لديك حساب؟'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
