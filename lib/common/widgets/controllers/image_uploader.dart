import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newbee_talk_mk2/common/widgets/app_snackbar.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageUploaderCont extends GetxController {
  static ImageUploaderCont get to => Get.find<ImageUploaderCont>();

  /// Image File
  final _imgFile = Rxn<File>();

  /// Img URL
  final _imgUrl = Rxn<String>();

  /// Getter (_imgFile)
  File? get imgFile => _imgFile.value;

  /// Getter (_imgUrl)
  String? get imgUrl => _imgUrl.value;

  /// Camera Access Permission
  Future<void> _cameraPermission() async {
    var camera = await Permission.camera.request();

    var snackbar = AppSnackbar(
      msg: '설정 > 앱 > 권한 목록에서 카메라 접근 권한을 수락해 주세요',
    );

    if (camera.isDenied || camera.isPermanentlyDenied) {
      snackbar.showSnackbar(Get.context!);

      openAppSettings();
    }
  }

  /// Initialize ImageUpload Callback
  void _onImageUploaded(File? file) {
    _imgFile(file);
  }

  /// Take Photo
  Future<void> takePhoto() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 60,
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
      imageQuality: 60,
    );

    if (image != null) {
      _onImageUploaded(File(image.path));
    }
  }

  /// Delete Selected Image
  void deleteImage() {
    _imgFile.value = null;
  }
}