import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String errMessage;
  const AuthFailure({required this.errMessage});
}

class SignupLoading extends AuthState {}

class SignupSuccess extends AuthState {}

class SignupFailure extends AuthState {
  final String errMessage;
  const SignupFailure({required this.errMessage});
}

class OtpLoading extends AuthState {}

class OtpSuccess extends AuthState {}

class OtpFailure extends AuthState {
  final String errMessage;
  const OtpFailure({required this.errMessage});
}

final class NeedOtpVerification extends AuthState {
  final String email;
  const NeedOtpVerification({required this.email});
}

class AuthPasswordVisibilityChanged extends AuthState {}

class AuthImageSelected extends AuthState {
  final String imagePath;

  const AuthImageSelected({required this.imagePath});

  @override
  List<Object> get props => [imagePath];
}
