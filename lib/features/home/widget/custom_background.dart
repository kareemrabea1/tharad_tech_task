import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tharad_tech/core/constants/app_colors.dart';

class CustomBackgroundLayout extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;

  const CustomBackgroundLayout({
    super.key,
    required this.title,
    required this.body,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.primaryGradient),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Tajawal',
                      ),
                    ),

                    const Spacer(),
                    if (actions != null) ...actions!,
                  ],
                ),
              ),

              const Gap(10),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: body,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
