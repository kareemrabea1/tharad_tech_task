import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharad_tech/core/constants/app_colors.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import '../cubit/main_layout_cubit.dart';
import '../cubit/main_layout_state.dart';

class MainLayoutView extends StatelessWidget {
  const MainLayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MainCubit()),
        BlocProvider(create: (context) => HomeCubit()..getUserData()),
      ],
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          var cubit = MainCubit.get(context);

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: cubit.screens[cubit.currentIndex],

              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10.r,
                      offset: Offset(0, -5.h),
                    ),
                  ],
                ),
                child: BottomNavigationBar(
                  currentIndex: cubit.currentIndex,
                  onTap: (index) {
                    cubit.changeBottomNav(index);
                  },
                  backgroundColor: Colors.white,
                  selectedItemColor: AppColors.primary,
                  unselectedItemColor: Colors.grey,
                  selectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Tajawal',
                    fontSize: 12.sp,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 12.sp,
                  ),
                  type: BottomNavigationBarType.fixed,
                  elevation: 0,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(
                        cubit.currentIndex == 0
                            ? Icons.home
                            : Icons.home_outlined,
                        size: 24.sp,
                      ),
                      label: 'الرئيسية',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        cubit.currentIndex == 1
                            ? Icons.account_circle
                            : Icons.account_circle_outlined,
                        size: 24.sp,
                      ),
                      label: 'حسابي',
                    ),
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
