import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tharad_tech/core/constants/app_colors.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/gradient_button.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'otp_view.dart';

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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is SignupSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OtpView(email: emailController.text),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("تم إنشاء الحساب بنجاح، يرجى تفعيل الحساب"),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is SignupFailure) {
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

            return SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Gap(20.h),
                      Image.asset(
                        'assets/images/logo.png',
                        width: 178.w,
                        height: 58.h,
                      ),
                      Gap(30.h),

                      Text(
                        'إنشاء حساب جديد',
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
                          'الصورة الشخصية',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                      ),
                      Gap(8.h),
                      GestureDetector(
                        onTap: () {
                          cubit.uploadProfileImage();
                        },
                        child: SizedBox(
                          width: double.infinity,
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            dashPattern: [10.w, 10.w],
                            color: AppColors.primary,
                            strokeWidth: 1.5.w,
                            radius: Radius.circular(12.r),
                            padding: EdgeInsets.all(2.w),
                            child: Container(
                              height: 100.h,
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F7F6),
                                borderRadius: BorderRadius.circular(12.r),
                                image: cubit.profileImage != null
                                    ? DecorationImage(
                                        image: FileImage(
                                          File(cubit.profileImage!.path),
                                        ),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: cubit.profileImage != null
                                  ? null
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.camera_alt_outlined,
                                          color: AppColors.primary,
                                          size: 30.sp,
                                        ),
                                        Gap(8.h),
                                        Text(
                                          "الملفات المسموح بها : JPEG , PNG",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.grey,
                                            fontFamily: 'Tajawal',
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ),
                      Gap(24.h),

                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          'اسم المستخدم',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                      ),
                      Gap(8.h),
                      CustomTextField(
                        label: 'User123',
                        controller: nameController,
                        fontSize: 12.sp,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'اسم المستخدم مطلوب';
                          }
                          return null;
                        },
                      ),
                      Gap(16.h),

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
                      Gap(16.h),

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
                        isPassword: cubit.isSignupPasswordShowing,
                        textInputAction: TextInputAction.next,
                        fontSize: 12.sp,
                        suffixIcon: IconButton(
                          icon: Icon(
                            cubit.suffixIconSignup,
                            color: Colors.grey,
                            size: 20.sp,
                          ),
                          onPressed: () {
                            cubit.changeSignupPasswordVisibility();
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'كلمة المرور مطلوبة';
                          }
                          if (value.length < 6) {
                            return 'يجب أن تكون 6 أحرف على الأقل';
                          }
                          return null;
                        },
                      ),
                      Gap(16.h),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          'تأكيد كلمة المرور',
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
                        controller: confirmPasswordController,
                        isPassword: cubit.isConfirmPasswordShowing,
                        textInputAction: TextInputAction.done,
                        fontSize: 12.sp,
                        suffixIcon: IconButton(
                          icon: Icon(
                            cubit.suffixIconConfirm,
                            color: Colors.grey,
                            size: 20.sp,
                          ),
                          onPressed: () {
                            cubit.changeConfirmPasswordVisibility();
                          },
                        ),
                        onFieldSubmitted: (_) {
                          if (_formKey.currentState!.validate()) {
                            cubit.userSignup(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              confirmPassword: confirmPasswordController.text,
                            );
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'تأكيد كلمة المرور مطلوب';
                          }
                          if (value != passwordController.text) {
                            return 'كلمات المرور غير متطابقة';
                          }
                          return null;
                        },
                      ),
                      Gap(32.h),

                      state is SignupLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            )
                          : GradientButton(
                              text: 'إنشاء حساب جديد',
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  FocusScope.of(context).unfocus();
                                  cubit.userSignup(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    confirmPassword:
                                        confirmPasswordController.text,
                                  );
                                }
                              },
                            ),

                      Gap(16.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'لديك حساب ؟',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'Tajawal',
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap(20.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
