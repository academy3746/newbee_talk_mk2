import 'dart:convert';
import 'dart:io';
import 'package:daum_postcode_search/daum_postcode_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newbee_talk_mk2/app_router.dart';
import 'package:newbee_talk_mk2/common/widgets/app_snackbar.dart';
import 'package:newbee_talk_mk2/common/widgets/form_field_validator.dart';
import 'package:newbee_talk_mk2/dao/dao.dart';
import 'package:newbee_talk_mk2/features/store/models/store.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;

class EditCont extends GetxController {
  static EditCont get to => Get.find<EditCont>();

  /// Instances Data Access Class
  final _dao = SupabaseService.init;

  /// Instances Data Transfer Class
  final _dto = SupabaseService();

  /// Instances TextField Validator
  final _validation = InputFieldValidator();

  /// Uploaded Image File
  final _storeImgFile = Rxn<File>();

  /// Uploaded Image File Url
  final _storeImgUrl = Rxn<String>();

  /// Global Key to validate FormField
  final _formKey = GlobalKey<FormState>().obs;

  /// Store Address Field
  final _addrCont = TextEditingController().obs;

  /// Store Name Field
  final _nameCont = TextEditingController().obs;

  /// Store Info Field
  final _infoCont = TextEditingController().obs;

  /// Instances Daum PostCode
  final _postModel = Rxn<DataModel>();

  /// Getter (_dao)
  SupabaseClient get dao => _dao;

  /// Getter (_dto)
  SupabaseService get dto => _dto;

  /// Getter (_validation)
  InputFieldValidator get validation => _validation;

  /// Getter (_storeImg)
  File? get storeImgFile => _storeImgFile.value;

  /// Getter (_storeImgUrl)
  String? get storeImgUrl => _storeImgUrl.value;

  /// Getter (_formKey)
  GlobalKey<FormState> get formKey => _formKey.value;

  /// Getter (_addrCont)
  TextEditingController get addrCont => _addrCont.value;

  /// Getter (_nameCont)
  TextEditingController get nameCont => _nameCont.value;

  /// Getter (_infoCont)
  TextEditingController get infoCont => _infoCont.value;

  /// Getter (_postModel)
  DataModel? get postModel => _postModel.value;

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
    _storeImgFile(file);
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
    _storeImgFile.value = null;
  }

  /// SetState PostCode Value
  void setPostCodeState(dynamic result) {
    _postModel.value = result;

    _addrCont.value.text = postModel?.roadAddress ?? '유효한 주소를 선택해 주세요!';
  }

  /// Post Written Store Data
  Future<bool> postStoreData() async {
    var success = false;

    if (!formKey.currentState!.validate()) {
      return false;
    }

    if (storeImgFile != null) {
      var now = DateTime.now();

      var path = 'stores/$now.jpg';

      await dao.storage.from('newbee_talk').upload(
            path,
            storeImgFile!,
          );

      var uploadUrl = dao.storage.from('newbee_talk').getPublicUrl(path);

      _storeImgUrl(uploadUrl);
    }

    await dotenv.load(fileName: '.env');

    var encode = dotenv.get('NAVER_API_URL');

    var apiUrl = '$encode?query=${addrCont.text}';

    var apiRes = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'X-NCP-APIGW-API-KEY-ID': dotenv.get('NAVER_CLIENT_ID'),
        'X-NCP-APIGW-API-KEY': dotenv.get('NAVER_CLIENT_SECRET'),
        'Accept': 'application/json',
      },
    );

    if (apiRes.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(apiRes.body);

      double latitude = double.parse(json['addresses'][0]['y']);

      double longitude = double.parse(json['addresses'][0]['x']);

      await dao.from('food_store').insert(FoodStoreModel(
            storeImgUrl: storeImgFile != null ? storeImgUrl : '',
            storeAddress: addrCont.text,
            storeName: nameCont.text,
            storeInfo: infoCont.text,
            uid: dao.auth.currentUser!.id,
            latitude: latitude,
            longitude: longitude,
          ).toMap());

      deleteImage();

      _addrCont.value.clear();

      _nameCont.value.clear();

      _infoCont.value.clear();

      var snackBar = AppSnackbar(
        msg: '플레이스가 정상적으로 등록되었어요! 💕',
      );

      snackBar.showSnackbar(Get.context!);

      AppRouter.main().off();

      success = true;
    } else {
      var snackBar = AppSnackbar(
        msg: '플레이스 등록이 실패하였습니다... 😱',
      );

      snackBar.showSnackbar(Get.context!);

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
