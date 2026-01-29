abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeDataSuccess extends HomeState {}

class HomeChangeBottomNavState extends HomeState {}

class HomeDataError extends HomeState {
  final String message;
  HomeDataError(this.message);
}
