import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbee_talk_mk2/dao/dao.dart';
import 'package:newbee_talk_mk2/features/store/models/store.dart';

class DetailCont extends GetxController {
  static DetailCont get to => Get.find<DetailCont>();

  /// Store Name
  final _storeName = ''.obs;

  /// Store Address
  final _storeAddress = ''.obs;

  /// Store Description
  final _storeInfo = ''.obs;

  /// Store Image Url
  final _storeImgUrl = Rxn<String>();

  /// Bookmark Status
  final _bookMarkStatus = false.obs;

  /// Instances Data Transfer Object
  final _dto = SupabaseService();

  /// Store Uploader Name
  final _uploaderName = ''.obs;

  /// Store Uploader Uid
  final _uid = ''.obs;

  /// Getter (_storeName)
  String get storeName => _storeName.value;

  /// Getter (_storeAddress)
  String get storeAddress => _storeAddress.value;

  /// Getter (_storeInfo)
  String get storeInfo => _storeInfo.value;

  /// Getter (_storeImgUrl)
  String? get storeImgUrl => _storeImgUrl.value;

  /// Getter (_bookMarkStatus)
  bool get bookMarkStatus => _bookMarkStatus.value;

  /// Getter (_dto)
  SupabaseService get dto => _dto;

  /// Getter (_uploaderName)
  String get uploaderName => _uploaderName.value;

  /// Getter (_uid)
  String get uid => _uid.value;

  /// Get Query Parameter From MapCont
  void setState(FoodStoreModel model) {
    _storeName.value = model.storeName;

    _storeAddress.value = model.storeAddress;

    _storeInfo.value = model.storeInfo;

    _storeImgUrl.value = model.storeImgUrl;

    _uid.value = model.uid;
  }

  /// BookMark Toggle Button
  void bookMarkOnPressed() {
    _bookMarkStatus(!_bookMarkStatus.value);
  }

  /// Get Store Uploader Name
  Future<void> getStoreUploader(BuildContext context) async {
    final userModel = await dto.fetchStoreUploaderName(uid);

    _uploaderName.value = userModel.name;
  }

  @override
  void onInit() async {
    super.onInit();

    _bookMarkStatus(false);
  }
}
