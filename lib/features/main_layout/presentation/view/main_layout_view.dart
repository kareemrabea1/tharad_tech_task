import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../home/presentation/view/home_view.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import '../../../profile/presentation/view/profile_view.dart';
import '../cubit/main_layout_cubit.dart';
import '../cubit/main_layout_state.dart';

class MainLayoutView extends StatelessWidget {
  const MainLayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [const HomeView(), const ProfileView()];

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
              body: screens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeBottomNav(index);
                  if (index == 0) {
                    HomeCubit.get(context).refreshUserData();
                  }
                },
                selectedItemColor: AppColors.primary,
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
          );
        },
      ),
    );
  }
}
