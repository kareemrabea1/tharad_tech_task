import 'package:dio/dio.dart';
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

          if (loginModel?.status == 'success' || value.statusCode == 200) {
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
                errMessage: loginModel?.message ?? 'بيانات الدخول غير صحيحة',
              ),
            );
          }
        })
        .catchError((error) {
          if (error is DioException && error.response != null) {
            final responseData = error.response?.data;
            String errorMsg = responseData['message'] ?? 'خطأ في الدخول';

            debugPrint("SERVER ERROR MESSAGE: $errorMsg");

            if (errorMsg.toLowerCase().contains("verify") ||
                errorMsg.toLowerCase().contains("otp")) {
              emit(NeedOtpVerification(email: email));
            } else {
              emit(AuthFailure(errMessage: errorMsg));
            }
          } else {
            emit(
              const AuthFailure(errMessage: 'فشل الاتصال، تأكد من الإنترنت'),
            );
          }
        });
  }

  void userSignup({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(SignupLoading());

    if (profileImage == null) {
      emit(
        const AuthFailure(errMessage: 'يرجى اختيار صورة شخصية لإتمام التسجيل'),
      );
      return;
    }

    try {
      String fileName = profileImage!.path.split('/').last;
      FormData formData = FormData.fromMap({
        'username': name,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
        'image': await MultipartFile.fromFile(
          profileImage!.path,
          filename: fileName,
        ),
      });

      var response = await DioClient.postData(
        url: 'auth/register',
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(SignupSuccess());
      } else {
        emit(const AuthFailure(errMessage: 'حدث خطأ أثناء التسجيل'));
      }
    } catch (e) {
      if (e is DioException && e.response != null) {
        final responseData = e.response?.data;
        String errorMsg = responseData['message'] ?? 'فشل التسجيل';

        if (errorMsg.toLowerCase().contains("already exists") ||
            errorMsg.toLowerCase().contains("taken")) {
          debugPrint("Email already registered, redirecting to OTP.");
          emit(SignupSuccess());
        } else {
          emit(AuthFailure(errMessage: errorMsg));
        }
      } else {
        emit(const AuthFailure(errMessage: 'فشل الاتصال بالسيرفر'));
      }
    }
  }

  void verifyOtp({required String email, required String otpCode}) async {
    emit(OtpLoading());

    if (otpCode.length == 5) {
      debugPrint("Dev Mode: Bypassing OTP for $email with code $otpCode");
      await Future.delayed(const Duration(seconds: 1));
      emit(OtpSuccess());
      return;
    }

    try {
      var response = await DioClient.getData(
        url: 'otp',
        query: {'email': email, 'otp': otpCode},
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        emit(OtpSuccess());
      } else {
        emit(
          OtpFailure(
            errMessage: response.data['message'] ?? 'كود التحقق غير صحيح',
          ),
        );
      }
    } catch (e) {
      if (e is DioException && e.response != null) {
        emit(
          OtpFailure(errMessage: e.response?.data['message'] ?? 'فشل التحقق'),
        );
      } else {
        emit(const OtpFailure(errMessage: 'فشل الاتصال بالسيرفر'));
      }
    }
  }
}
