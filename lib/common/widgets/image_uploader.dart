import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newbee_talk_mk2/common/constant/sizes.dart';
import 'package:newbee_talk_mk2/common/widgets/app_snackbar.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageUploader {
  ImageUploader._void();

  static final ImageUploader _internal = ImageUploader._void();

  late File? imgFile;

  late String? imgUrl;

  late void Function(File? file)? onImageUploaded;

  late void Function()? onDeleteImage;

  factory ImageUploader({
    File? file,
    String? url,
    void Function(File? file)? onImageUploaded,
    void Function()? onDeleteImage,
  }) {
    _internal.imgFile = file;

    _internal.imgUrl = url;

    _internal.onImageUploaded = onImageUploaded;

    _internal.onDeleteImage = onDeleteImage;

    return _internal;
  }

  /// PopUp ImageUploader Widget
  Widget showImageUploader({
    required BuildContext context,
    required Widget child,
  }) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => _imageBottomSheet(),
        );
      },
      child: child,
    );
  }

  /// Show ImageUploader BottomSheet
  Widget _imageBottomSheet() {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      margin: const EdgeInsets.all(Sizes.size10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () {
              Get.back();

              _takePhoto();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
            ),
            child: const Text(
              '사진 촬영',
              style: TextStyle(
                color: Colors.black,
                fontSize: Sizes.size18,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();

              _selectImage();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
            ),
            child: const Text(
              '사진 선택',
              style: TextStyle(
                color: Colors.black,
                fontSize: Sizes.size18,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();

              onDeleteImage!.call();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
            ),
            child: const Text(
              '사진 삭제',
              style: TextStyle(
                color: Colors.black,
                fontSize: Sizes.size18,
              ),
            ),
          ),
        ],
      ),
    );
  }

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

  /// Take Photo
  Future<void> _takePhoto() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 60,
    );

    if (image != null) {
      onImageUploaded?.call(File(image.path));
    }

    await _cameraPermission();
  }

  /// Select Image from Gallery
  Future<void> _selectImage() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
    );

    if (image != null) {
      onImageUploaded?.call(File(image.path));
    }
  }
}
