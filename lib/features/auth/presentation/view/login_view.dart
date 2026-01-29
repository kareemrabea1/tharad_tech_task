import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tharad_tech/features/auth/presentation/view/signup_view.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../main_layout/presentation/view/main_layout_view.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/gradient_button.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'otp_view.dart';

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
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MainLayoutView()),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("تم تسجيل الدخول بنجاح"),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is NeedOtpVerification) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OtpView(email: state.email),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("يرجى تفعيل الحساب بالكود المرسل إليك"),
                  backgroundColor: Colors.orange,
                ),
              );
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errMessage),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            var cubit = AuthCubit.get(context);

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Gap(100.h),
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
                      textInputAction: TextInputAction.next,
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
                      isPassword: cubit.isLoginPasswordShowing,
                      suffixIcon: IconButton(
                        icon: Icon(
                          cubit.suffixIcon,
                          color: AppColors.primary,
                          size: 20.sp,
                        ),
                        onPressed: () {
                          cubit.changeLoginPasswordVisibility();
                        },
                      ),
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) {
                        if (_formKey.currentState!.validate()) {
                          cubit.userLogin(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        }
                      },
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
                              activeColor: AppColors.primary,
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

                    state is AuthLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          )
                        : GradientButton(
                            text: 'تسجيل الدخول',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
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
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'Tajawal',
                          ),
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
            );
          },
        ),
      ),
    );
  }
}
