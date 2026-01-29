import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/widgets/language_switcher.dart';
import '../../../auth/widget/custom_text_field.dart';
import '../../../auth/widget/gradient_button.dart';
import '../../../home/widget/custom_background.dart';
import '../../widget/custom_label.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getProfileData(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdateSuccess) {
            final double screenHeight = MediaQuery.of(context).size.height;
            final double screenWidth = MediaQuery.of(context).size.width;
            final double sideMargin = (screenWidth - 250.w) / 2;

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(
                  bottom: screenHeight - 250.h,
                  left: sideMargin,
                  right: sideMargin,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
                content: Center(
                  child: Text(
                    "تم حفظ التغيرات بنجاح",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
            );
          } else if (state is ProfileUpdateFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          var cubit = ProfileCubit.get(context);

          return Directionality(
            textDirection: TextDirection.rtl,
            child: CustomBackgroundLayout(
              title: "الملف الشخصي",
              centerTitle: true,
              actions: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_none,
                      color: Colors.white,
                      size: 24.sp,
                    ),
                  ),
                ),
              ],
              body: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    const LanguageSwitcher(),

                    Gap(10.h),
                    buildLabel(text: "اسم المستخدم"),
                    CustomTextField(
                      label: "اسم المستخدم",
                      controller: cubit.nameController,
                      fontSize: 10.sp,
                    ),
                    Gap(16.h),

                    buildLabel(text: "البريد الإلكتروني"),
                    CustomTextField(
                      label: "البريد الإلكتروني",
                      controller: cubit.emailController,
                      keyboardType: TextInputType.emailAddress,
                      fontSize: 10.sp,
                    ),
                    Gap(24.h),

                    buildLabel(text: "الصورة الشخصية"),
                    GestureDetector(
                      onTap: () {
                        cubit.uploadProfileImage();
                      },
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(12.r),
                        padding: EdgeInsets.all(2.w),
                        color: const Color(0xFF2D8B86),
                        strokeWidth: 1.5.w,
                        dashPattern: [8.w, 4.w],
                        strokeCap: StrokeCap.round,
                        child: Container(
                          height: 120.h,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF9F9F9),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.camera_alt_outlined,
                                      color: const Color(0xFF2D8B86),
                                      size: 35.sp,
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
                    Gap(24.h),

                    buildLabel(text: "كلمة المرور القديمة"),
                    CustomTextField(
                      label: "********",
                      isPassword: true,
                      controller: cubit.oldPasswordController,
                      fontSize: 12.sp,
                    ),
                    Gap(16.h),

                    buildLabel(text: "كلمة المرور الجديدة"),
                    CustomTextField(
                      label: "********",
                      isPassword: true,
                      controller: cubit.newPasswordController,
                      fontSize: 12.sp,
                    ),
                    Gap(16.h),

                    buildLabel(text: "تأكيد كلمة المرور الجديدة"),
                    CustomTextField(
                      label: "********",
                      isPassword: true,
                      controller: cubit.confirmPasswordController,
                      fontSize: 12.sp,
                    ),

                    Gap(40.h),

                    state is ProfileUpdateLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                            height: 48.h,
                            width: 234.w,
                            child: GradientButton(
                              text: 'حفظ التغيرات',
                              onPressed: () {
                                cubit.updateProfileData();
                              },
                            ),
                          ),
                    Gap(20.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
