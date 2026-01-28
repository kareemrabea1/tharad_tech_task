import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 1. اعمل Import للشاشتين اللي هتبدل بينهم
import '../../../home/presentation/view/home_view.dart';
import '../../../profile/presentation/view/profile_view.dart';

class MainLayoutView extends StatefulWidget {
  const MainLayoutView({super.key});

  @override
  State<MainLayoutView> createState() => _MainLayoutViewState();
}

class _MainLayoutViewState extends State<MainLayoutView> {
  // المتغير اللي بيحدد احنا واقفين على انهي تاب (0 = الرئيسية)
  int _currentIndex = 0;

  // قائمة الشاشات اللي هنبدل بينها
  final List<Widget> _screens = [
    const HomeView(), // index 0
    const ProfileView(), // index 1
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // عرض الشاشة المختارة حالياً
        body: _screens[_currentIndex],

        // شريط التنقل السفلي
        bottomNavigationBar: Container(
          // إضافة ضل خفيف فوق البار عشان يفصله عن المحتوى (Design Touch)
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: BottomNavigationBar(
            // الخصائص الأساسية
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },

            // الألوان والستايل
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFF2D8B86), // لون البراند (Active)
            unselectedItemColor: Colors.grey, // لون الرمادي (Inactive)
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Tajawal',
            ),
            unselectedLabelStyle: const TextStyle(fontFamily: 'Tajawal'),
            type: BottomNavigationBarType
                .fixed, // عشان الأيقونات متتحركش لما تختار
            elevation: 0, // شيلنا الضل الافتراضي عشان حطينا ضل مخصص فوق
            // العناصر (Tabs)
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'الرئيسية',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: 'حسابي',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
