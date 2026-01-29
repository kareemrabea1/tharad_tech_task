import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/utils/pref_helper.dart';
import '../../data/model/login_model.dart';
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
  LoginModel? loginModel;

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

    DioClient.postData(
          url: 'auth/login',
          data: {'email': email, 'password': password},
        )
        .then((value) {
          loginModel = LoginModel.fromJson(value.data);

          if (loginModel?.status == 'success') {
            PrefHelper.saveData(key: 'token', value: loginModel?.data?.token);
            PrefHelper.saveData(key: 'isLogin', value: true);
            PrefHelper.saveData(
              key: 'username',
              value: loginModel?.data?.username,
            );
            PrefHelper.saveData(key: 'email', value: loginModel?.data?.email);

            emit(AuthSuccess());
          } else {
            emit(
              AuthFailure(
                errMessage:
                    loginModel?.message ??
                    'البريد الإلكتروني أو كلمة المرور غير صحيحة',
              ),
            );
          }
        })
        .catchError((error) {
          print("Login Error: $error");
          emit(
            AuthFailure(errMessage: 'فشل الاتصال بالسيرفر، تأكد من الإنترنت'),
          );
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
        emit(OtpFailure(errMessage: "الكود غير صحيح، حاول مرة أخرى"));
      }
    });
  }
}
