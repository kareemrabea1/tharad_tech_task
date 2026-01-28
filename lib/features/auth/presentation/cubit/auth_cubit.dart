import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/app_colors.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  bool isLoginPasswordShowing = true;
  IconData suffixIcon = Icons.visibility_off;

  bool isSignupPasswordShowing = true;
  IconData suffixIconSignup = Icons.visibility_off;

  bool isConfirmPasswordShowing = true;
  IconData suffixIconConfirm = Icons.visibility_off;

  XFile? profileImage;

  void changeLoginPasswordVisibility() {
    isLoginPasswordShowing = !isLoginPasswordShowing;
    suffixIcon = isLoginPasswordShowing
        ? Icons.visibility_off
        : Icons.visibility;
    emit(AuthPasswordVisibilityChanged());
  }

  void changeSignupPasswordVisibility() {
    isSignupPasswordShowing = !isSignupPasswordShowing;
    suffixIconSignup = isSignupPasswordShowing
        ? Icons.visibility_off
        : Icons.visibility;
    emit(AuthPasswordVisibilityChanged());
  }

  void changeConfirmPasswordVisibility() {
    isConfirmPasswordShowing = !isConfirmPasswordShowing;
    suffixIconConfirm = isConfirmPasswordShowing
        ? Icons.visibility_off
        : Icons.visibility;
    emit(AuthPasswordVisibilityChanged());
  }

  Future<void> uploadProfileImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'تعديل الصورة',
            toolbarColor: AppColors.primary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
          IOSUiSettings(title: 'تعديل الصورة', aspectRatioLockEnabled: true),
        ],
      );

      if (croppedFile != null) {
        profileImage = XFile(croppedFile.path);
        emit(AuthImageSelected(imagePath: profileImage!.path));
      }
    }
  }

  void userLogin({required String email, required String password}) {
    emit(AuthLoading());
    Future.delayed(const Duration(seconds: 2), () {
      if (email == 'test@gmail.com' && password == '123456') {
        emit(AuthSuccess());
      } else {
        emit(
          const AuthFailure(
            errMessage: 'البريد الإلكتروني أو كلمة المرور غير صحيحة',
          ),
        );
      }
    });
  }

  void userSignup({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    emit(SignupLoading());
    Future.delayed(const Duration(seconds: 2), () {
      emit(SignupSuccess());
    });
  }

  void verifyOtp({required String otpCode}) {
    emit(OtpLoading());
    Future.delayed(const Duration(seconds: 2), () {
      if (otpCode.length == 5) {
        emit(OtpSuccess());
      } else {
        emit(const OtpFailure(errMessage: "الكود غير صحيح، حاول مرة أخرى"));
      }
    });
  }
}
