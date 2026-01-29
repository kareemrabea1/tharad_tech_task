import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_layout_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  static MainCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(MainChangeBottomNav());
  }
}
