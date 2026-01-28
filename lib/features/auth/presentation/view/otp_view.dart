import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../main_layout/presentation/view/main_layout_view.dart';
import '../../widget/gradient_button.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class OtpView extends StatefulWidget {
  final String email;

  const OtpView({super.key, required this.email});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  final TextEditingController pinController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50.w,
      height: 60.h,
      textStyle: TextStyle(
        fontSize: 22.sp,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColors.primary, width: 1.5.w),
      ),
    );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is OtpSuccess) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MainLayoutView()),
                (route) => false,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("تم تفعيل الحساب بنجاح"),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is OtpFailure) {
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
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Gap(80.h),
                      Image.asset(
                        'assets/images/logo.png',
                        width: 178.w,
                        height: 58.h,
                      ),
                      Gap(50.h),

                      Text(
                        'رمز التحقق',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                      Gap(10.h),

                      Text(
                        'لاستكمال فتح حسابك ادخل رمز التحقق المرسل عبر البريد الإلكتروني\n${widget.email}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xff998C8C),
                          fontSize: 14.sp,
                          height: 1.5.h,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                      Gap(40.h),

                      Form(
                        key: _formKey,
                        child: Pinput(
                          controller: pinController,
                          length: 5,
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: focusedPinTheme,
                          keyboardType: TextInputType.number,
                          validator: (pin) {
                            if (pin == null || pin.length < 5) {
                              return 'الرمز غير مكتمل';
                            }
                            return null;
                          },
                          pinputAutovalidateMode:
                              PinputAutovalidateMode.onSubmit,
                          showCursor: true,
                          onCompleted: (pin) {},
                        ),
                      ),

                      Gap(30.h),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("تم إعادة إرسال الرمز"),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'إعادة إرسال',
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp,
                                      fontFamily: 'Tajawal',
                                    ),
                                  ),
                                ),
                                Text(
                                  'لم يصلك رمز ؟ ',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.sp,
                                    fontFamily: 'Tajawal',
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '09:58 Sec',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10.sp,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(40.h),

                      state is OtpLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            )
                          : GradientButton(
                              text: 'المتابعة',
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  cubit.verifyOtp(otpCode: pinController.text);
                                }
                              },
                            ),
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
