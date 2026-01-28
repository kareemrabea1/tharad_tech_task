import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tharad_tech/core/constants/app_colors.dart';

import '../../widget/custom_background.dart';
import '../../widget/feature_item.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
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
                """تدريب Flutter ده مش كورس تعليمي تقليدي،  ده برنامج عملي معمول علشان يجهز المتدرب يشتغل فعليًا على مشاريع حقيقية داخل الشركة.
خلال فترة التدريب، المتدرب هيكون جزء من فريق العمل،  وهيتعامل مع كود حقيقي، متطلبات حقيقية، ومشاكل بتتحل يوميًا في مشاريع قائمة بالفعل  مش مجرد تطبيقات تجريبية أو أمثلة للتعلم.
التدريب بيعتمد على إن المتدرب:
يفهم طريقة الشغل داخل الشركة
يلتزم بمعايير كتابة كود احترافي
يتعامل مع Git وإدارة الإصدارات
يشتغل ضمن فريق ويستقبل Feedback بشكل مستمر
الهدف الأساسي من التدريب هو تحويل المتدرب من مستوى متعلم  إلى مطور Flutter قادر يدخل أي مشروع ويشتغل عليه بثقة.""",
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
              const FeatureItem(
                text: "المشاركة في تطوير تطبيقات موبايل حقيقية",
              ),
              const FeatureItem(text: "تنفيذ Features مطلوبة في مشاريع قائمة"),
              const FeatureItem(text: "التعامل مع APIs و Backends فعلية"),
              const FeatureItem(text: '"إصلاح Bugs وتحسين الأداء"'),
              const FeatureItem(
                text: "الالتزام بـ Clean Code و Architecture واضحة",
              ),
              Gap(100.h),
            ],
          ),
        ),
      ),
    );
  }
}
