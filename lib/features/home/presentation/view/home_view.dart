import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tharad_tech/core/constants/app_colors.dart';

import '../../widget/custom_background.dart';
import '../../widget/feature_item.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var cubit = HomeCubit.get(context);

          return Directionality(
            textDirection: TextDirection.rtl,
            child: CustomBackgroundLayout(
              title: "مرحبا ثراد تك !",
              actions: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(20),
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
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 15.h,
                      ),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/Frame.png',
                            height: 52.h,
                            width: 181.w,
                          ),
                          Gap(15.h),
                          Text(
                            "تدريب Flutter لبناء تطبيقات موبايل حقيقية",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                              fontFamily: 'Tajawal',
                            ),
                          ),
                          Gap(10.h),
                        ],
                      ),
                    ),
                    Gap(24.h),

                    Text(
                      "عن التدريب",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    Gap(10.h),
                    Text(
                      cubit.aboutTrainingText,
                      style: TextStyle(
                        color: const Color(0xff998C8C),
                        height: 1.8.h,
                        fontSize: 13.sp,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    Gap(24.h),

                    Text(
                      "طبيعة الشغل أثناء التدريب",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    Gap(16.h),

                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cubit.trainingFeatures.length,
                      separatorBuilder: (context, index) => Gap(8.h),
                      itemBuilder: (context, index) {
                        return FeatureItem(text: cubit.trainingFeatures[index]);
                      },
                    ),

                    Gap(100.h),
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
