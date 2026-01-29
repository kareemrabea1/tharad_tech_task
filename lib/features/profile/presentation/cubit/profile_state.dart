abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileUpdateLoading extends ProfileState {}

class ProfileUpdateSuccess extends ProfileState {}

class ProfileUpdateFailure extends ProfileState {
  final String errMessage;
  ProfileUpdateFailure({required this.errMessage});
}

class ProfileImageSelected extends ProfileState {
  final String imagePath;
  ProfileImageSelected({required this.imagePath});
}

class ProfilePasswordVisibilityChanged extends ProfileState {}
