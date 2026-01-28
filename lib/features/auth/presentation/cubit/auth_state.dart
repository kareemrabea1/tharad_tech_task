import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

// --- Login States ---
class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String errMessage;
  const AuthFailure({required this.errMessage});
}

// --- Signup States ---
class SignupLoading extends AuthState {}

class SignupSuccess extends AuthState {}

class SignupFailure extends AuthState {
  final String errMessage;
  const SignupFailure({required this.errMessage});
}

// --- OTP States ---
class OtpLoading extends AuthState {}

class OtpSuccess extends AuthState {}

class OtpFailure extends AuthState {
  final String errMessage;
  const OtpFailure({required this.errMessage});
}

// --- Visibility State ---
class AuthPasswordVisibilityChanged extends AuthState {}

// --- Image State (التعديل الجديد هنا) ---
class AuthImageSelected extends AuthState {
  final String imagePath; // بنستقبل مسار الصورة عشان الـ UI يتحدث

  const AuthImageSelected({required this.imagePath});

  @override
  List<Object> get props => [imagePath]; // ضروري عشان المقارنة والتحديث
}
