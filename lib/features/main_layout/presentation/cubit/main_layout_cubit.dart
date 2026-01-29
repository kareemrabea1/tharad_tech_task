import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tharad_tech/features/profile/presentation/view/profile_view.dart';
import '../../../home/presentation/view/home_view.dart';
import 'main_layout_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  static MainCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [const HomeView(), const ProfileView()];

  List<String> titles = ["الرئيسية", "ملفي الشخصي"];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(MainChangeBottomNav());
  }
}
