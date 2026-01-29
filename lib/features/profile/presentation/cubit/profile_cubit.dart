import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tharad_tech/core/constants/app_colors.dart';
import 'package:tharad_tech/core/utils/pref_helper.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  XFile? profileImage;

  void getProfileData() {
    nameController.text = PrefHelper.getData(key: 'username') ?? "";
    emailController.text = PrefHelper.getData(key: 'email') ?? "";

    String? localImagePath = PrefHelper.getData(key: 'userImageLocal');
    if (localImagePath != null) {
      profileImage = XFile(localImagePath);
    }
    emit(ProfileDataLoaded());
  }

  Future<void> uploadProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      var imageBytes = await image.length();
      if (imageBytes > 5 * 1024 * 1024) {
        emit(
          ProfileUpdateFailure(
            errMessage: "حجم الصورة كبير جداً، الحد الأقصى 5 ميجا",
          ),
        );
        return;
      }

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
        emit(ProfileImageSelected(imagePath: profileImage!.path));
      }
    }
  }

  void updateProfileData() async {
    emit(ProfileUpdateLoading());
    try {
      await PrefHelper.saveData(key: 'username', value: nameController.text);
      await PrefHelper.saveData(key: 'email', value: emailController.text);

      if (profileImage != null) {
        await PrefHelper.saveData(
          key: 'userImageLocal',
          value: profileImage!.path,
        );
      }

      await Future.delayed(const Duration(milliseconds: 500));
      emit(ProfileUpdateSuccess());
    } catch (e) {
      emit(ProfileUpdateFailure(errMessage: "فشل تحديث البيانات محلياً"));
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
