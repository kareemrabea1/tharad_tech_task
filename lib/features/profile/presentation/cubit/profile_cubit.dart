import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tharad_tech/core/constants/app_colors.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  final TextEditingController nameController = TextEditingController(
    text: "thar22",
  );
  final TextEditingController emailController = TextEditingController(
    text: "Tharad@gmail.com",
  );

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  XFile? profileImage;

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
        emit(ProfileImageSelected(imagePath: profileImage!.path));
      }
    }
  }

  void updateProfileData() {
    emit(ProfileUpdateLoading());
    Future.delayed(const Duration(seconds: 2), () {
      emit(ProfileUpdateSuccess());
    });
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
