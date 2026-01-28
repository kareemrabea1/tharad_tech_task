import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tharad_tech/core/constants/app_colors.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/gradient_button.dart';
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
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Gap(80.h),
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
                      debugPrint("Open Image Picker");
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
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                              Text(
                                "الحد الاقصي : 5MB",
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'اسم المستخدم مطلوب';
                      }
                      return null;
                    },
                    suffixIcon: null,
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
                    suffixIcon: null,
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
                    isPassword: !isPasswordVisible,
                    fontSize: 12.sp,
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
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
                    isPassword: !isConfirmPasswordVisible,
                    fontSize: 12.sp,
                    suffixIcon: IconButton(
                      icon: Icon(
                        isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                        size: 20.sp,
                      ),
                      onPressed: () {
                        setState(() {
                          isConfirmPasswordVisible = !isConfirmPasswordVisible;
                        });
                      },
                    ),
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
                  GradientButton(
                    text: 'إنشاء حساب جديد',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        debugPrint('Signup Success: ${nameController.text}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OtpView(email: emailController.text),
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
        ),
      ),
    );
  }
}
