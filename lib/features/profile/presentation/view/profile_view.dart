import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/widgets/language_switcher.dart';
import '../../../auth/widget/custom_text_field.dart';
import '../../../auth/widget/gradient_button.dart';
import '../../../home/widget/custom_background.dart';
import '../../widget/custom_label.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final nameController = TextEditingController(text: "thar22");
  final emailController = TextEditingController(text: "Tharad@gmail.com");

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CustomBackgroundLayout(
        title: "الملف الشخصي",
        centerTitle: true,
        actions: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
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
            children: [
              const LanguageSwitcher(),

              const Gap(10),
              buildLabel(text: "اسم المستخدم"),
              CustomTextField(
                label: "اسم المستخدم",
                controller: nameController,
                fontSize: 10,
              ),
              const Gap(16),

              buildLabel(text: "البريد الإلكتروني"),
              CustomTextField(
                label: "البريد الإلكتروني",
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                fontSize: 10,
              ),
              const Gap(24),

              buildLabel(text: "الصورة الشخصية"),
              GestureDetector(
                onTap: () {},
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  padding: const EdgeInsets.all(2),
                  color: const Color(0xFF2D8B86),
                  strokeWidth: 1.5,
                  dashPattern: const <double>[8, 4],
                  strokeCap: StrokeCap.round,
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F9F9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.camera_alt_outlined,
                          color: Color(0xFF2D8B86),
                          size: 35,
                        ),
                        Gap(8),
                        Text(
                          "الملفات المسموح بها : JPEG , PNG",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                        Text(
                          "الحد الاقصي : 5MB",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Gap(24),

              buildLabel(text: "كلمة المرور القديمة"),
              const CustomTextField(label: "********", isPassword: true),
              const Gap(16),

              buildLabel(text: "كلمة المرور الجديدة"),
              const CustomTextField(label: "********", isPassword: true),
              const Gap(16),

              buildLabel(text: "تأكيد كلمة المرور الجديدة"),
              const CustomTextField(label: "********", isPassword: true),

              const Gap(40),
              SizedBox(
                height: 48,
                width: 234,
                child: GradientButton(
                  text: 'حفظ التغيرات',
                  onPressed: () {
                    final double screenHeight = MediaQuery.of(
                      context,
                    ).size.height;
                    final double screenWidth = MediaQuery.of(
                      context,
                    ).size.width;
                    final double sideMargin = (screenWidth - 250) / 2;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.only(
                          bottom: screenHeight - 130,
                          left: sideMargin,
                          right: sideMargin,
                        ),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        content: const Center(
                          child: Text(
                            "تم حفظ التغيرات بنجاح",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Tajawal',
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
