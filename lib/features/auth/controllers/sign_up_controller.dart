import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newbee_talk_mk2/common/widgets/form_field_validator.dart';

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

  /// Initialize ImageUpload Callback
  void onImageUploaded(File? file) {
    _profileImg(file);
  }

  /// Take Photo
  Future<void> takePhoto() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (image != null) {
      onImageUploaded(File(image.path));
    }
  }

  /// Select Image from Gallery
  Future<void> selectImage() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      onImageUploaded(File(image.path));
    }
  }

  /// Delete Selected Image
  void deleteImage() {
    _profileImg.value = null;
  }

  @override
  void onInit() {
    super.onInit();

    validation;
  }
}
