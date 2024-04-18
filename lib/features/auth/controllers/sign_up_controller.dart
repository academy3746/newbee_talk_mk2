import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newbee_talk_mk2/app_router.dart';
import 'package:newbee_talk_mk2/common/widgets/app_snackbar.dart';
import 'package:newbee_talk_mk2/common/widgets/form_field_validator.dart';
import 'package:newbee_talk_mk2/dao/dao.dart';
import 'package:newbee_talk_mk2/features/auth/models/user.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpCont extends GetxController {
  static SignUpCont get to => Get.find<SignUpCont>();

  /// User Profile Img
  final _profileImg = Rxn<File>();

  /// Profile Img URL
  final _imgUrl = Rxn<String>();

  /// Validate TextField
  final _validation = InputFieldValidator();

  /// Global FormField Key
  final _formKey = GlobalKey<FormState>().obs;

  /// Name InputField
  final _nameCont = TextEditingController().obs;

  /// E-mail InputField
  final _mailCont = TextEditingController().obs;

  /// Password InputField
  final _passwordCont = TextEditingController().obs;

  /// Password Confirm InputField
  final _pwdReCont = TextEditingController().obs;

  /// Introduce InputField
  final _introCont = TextEditingController().obs;

  /// Instances Supabse Authentication Access
  final _dao = SupabaseService.init;

  /// Getter (_profileImg)
  File? get profileImg => _profileImg.value;

  /// Getter (_imgUrl)
  String? get imgUrl => _imgUrl.value;

  /// Getter (_validation)
  InputFieldValidator get validation => _validation;

  /// Getter (_formKey)
  GlobalKey<FormState> get formKey => _formKey.value;

  /// Getter (_nameCont)
  TextEditingController get nameCont => _nameCont.value;

  /// Getter (_mailCont)
  TextEditingController get mailCont => _mailCont.value;

  /// Getter (_passwordCont)
  TextEditingController get passwordCont => _passwordCont.value;

  /// Getter (_pwdReCont)
  TextEditingController get pwdReCont => _pwdReCont.value;

  /// Getter (_introCont)
  TextEditingController get introCont => _introCont.value;

  /// Getter (_dao)
  SupabaseClient get dao => _dao;

  /// Camera Access Permission
  Future<void> _cameraPermission() async {
    var camera = await Permission.camera.request();

    var snackbar = AppSnackbar(
      msg: '설정 > 앱 > 권한 목록에서 카메라 접근 권한을 수락해 주세요',
    );

    if (camera.isDenied || camera.isPermanentlyDenied) {
      snackbar.showSnackbar();

      openAppSettings();
    }
  }

  /// Initialize ImageUpload Callback
  void _onImageUploaded(File? file) {
    _profileImg(file);
  }

  /// Take Photo
  Future<void> takePhoto() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (image != null) {
      _onImageUploaded(File(image.path));
    }

    await _cameraPermission();
  }

  /// Select Image from Gallery
  Future<void> selectImage() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      _onImageUploaded(File(image.path));
    }
  }

  /// Delete Selected Image
  void deleteImage() {
    _profileImg.value = null;
  }

  /// SignUp with Email Address
  Future<bool> signUpWithEmail(String email, String password) async {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    var success = false;

    var res = await dao.auth.signUp(
      email: email,
      password: password,
    );

    if (res.user != null) {
      if (profileImg != null) {
        var now = DateTime.now();

        var path = 'profiles/${res.user!.id}_$now.jpg';

        await dao.storage.from('newbee_talk').upload(path, profileImg!,
            fileOptions: const FileOptions(
              cacheControl: '3600',
              upsert: true,
            ));

        var uploadUrl = dao.storage.from('newbee_talk').getPublicUrl(path);

        _imgUrl(uploadUrl);
      }

      await dao.from('user').insert(UserModel(
            name: nameCont.text,
            email: email,
            introduce: introCont.text,
            profileUrl: profileImg != null ? imgUrl : '',
            uid: res.user!.id,
          ).toMap());

      _profileImg.value = null;

      _nameCont.value.clear();

      _mailCont.value.clear();

      _passwordCont.value.clear();

      _pwdReCont.value.clear();

      _introCont.value.clear();

      var snackbar = AppSnackbar(
        msg: '뉴비톡톡과 함께 해줘서 기뻐요 💕',
      );

      snackbar.showSnackbar();

      AppRouter.main().offAll();

      success = true;
    } else {
      var snackbar = AppSnackbar(
        msg: '올바른 양식을 제출해 주세요!',
      );

      snackbar.showSnackbar();

      Get.back();

      success = false;
    }

    return success;
  }

  @override
  void onInit() {
    super.onInit();

    validation;
  }
}
