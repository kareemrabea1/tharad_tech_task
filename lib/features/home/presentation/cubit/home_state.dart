abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeDataSuccess extends HomeState {}

class HomeDataError extends HomeState {
  final String errMessage;
  HomeDataError(this.errMessage);
}

class HomeChangeBottomNavState extends HomeState {}
