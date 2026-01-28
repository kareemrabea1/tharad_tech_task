import 'package:flutter/material.dart';
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
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none, color: Colors.white),
            ),
          ),
        ],
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Gap(15),
                    Image.asset(
                      'assets/images/Frame.png',
                      height: 52,
                      width: 181,
                    ),
                    const Gap(15),
                    const Text(
                      "تدريب Flutter لبناء تطبيقات موبايل حقيقية",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    Gap(24),
                  ],
                ),
              ),
              const Gap(24),

              const Text(
                "عن التدريب",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tajawal',
                ),
              ),
              const Gap(10),
              const Text(
                """تدريب Flutter ده مش كورس تعليمي تقليدي،  ده برنامج عملي معمول علشان يجهز المتدرب يشتغل فعليًا على مشاريع حقيقية داخل الشركة.
خلال فترة التدريب، المتدرب هيكون جزء من فريق العمل،  وهيتعامل مع كود حقيقي، متطلبات حقيقية، ومشاكل بتتحل يوميًا في مشاريع قائمة بالفعل  مش مجرد تطبيقات تجريبية أو أمثلة للتعلم.
التدريب بيعتمد على إن المتدرب:
يفهم طريقة الشغل داخل الشركة
يلتزم بمعايير كتابة كود احترافي
يتعامل مع Git وإدارة الإصدارات
يشتغل ضمن فريق ويستقبل Feedback بشكل مستمر
الهدف الأساسي من التدريب هو تحويل المتدرب من مستوى متعلم  إلى مطور Flutter قادر يدخل أي مشروع ويشتغل عليه بثقة.""",
                style: TextStyle(
                  color: Color(0xff998C8C),
                  height: 1.8,
                  fontSize: 13,
                  fontFamily: 'Tajawal',
                ),
              ),

              const Gap(24),

              const Text(
                "طبيعة الشغل أثناء التدريب",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tajawal',
                ),
              ),
              const Gap(16),

              FeatureItem(text: "المشاركة في تطوير تطبيقات موبايل حقيقية"),
              FeatureItem(text: "تنفيذ Features مطلوبة في مشاريع قائمة"),
              FeatureItem(text: "التعامل مع APIs و Backends فعلية"),
              FeatureItem(text: '"إصلاح Bugs وتحسين الأداء"'),
              FeatureItem(text: "الالتزام بـ Clean Code و Architecture واضحة"),

              const Gap(100),
            ],
          ),
        ),
      ),
    );
  }
}
