import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbee_talk_mk2/dao/dao.dart';
import 'package:newbee_talk_mk2/features/store/models/store.dart';

class DetailCont extends GetxController {
  static DetailCont get to => Get.find<DetailCont>();

  /// Store ID
  final _id = 0.obs;

  /// Store Name
  final _storeName = ''.obs;

  /// Store Address
  final _storeAddress = ''.obs;

  /// Store Description
  final _storeInfo = ''.obs;

  /// Store Image Url
  final _storeImgUrl = Rxn<String>();

  /// Bookmark Status
  final _isFavorite = false.obs;

  /// Instances Data Transfer Object
  final _dto = SupabaseService();

  /// Store Uploader Name
  final _uploaderName = ''.obs;

  /// Store Uploader Uid
  final _uid = ''.obs;

  /// Getter
  int get id => _id.value;

  /// Getter (_storeName)
  String get storeName => _storeName.value;

  /// Getter (_storeAddress)
  String get storeAddress => _storeAddress.value;

  /// Getter (_storeInfo)
  String get storeInfo => _storeInfo.value;

  /// Getter (_storeImgUrl)
  String? get storeImgUrl => _storeImgUrl.value;

  /// Getter (_bookMarkStatus)
  bool get isFavorite => _isFavorite.value;

  /// Getter (_dto)
  SupabaseService get dto => _dto;

  /// Getter (_uploaderName)
  String get uploaderName => _uploaderName.value;

  /// Getter (_uid)
  String get uid => _uid.value;

  /// Get Query Parameter From MapCont
  void setState(FoodStoreModel model) {
    _id.value = model.id!;

    _storeName.value = model.storeName;

    _storeAddress.value = model.storeAddress;

    _storeInfo.value = model.storeInfo;

    _storeImgUrl.value = model.storeImgUrl;

    _uid.value = model.uid;
  }

  /// Bookmark Button onPressed
  Future<void> bookMarkButtonOnPressed() async {
    var status = await _favoriteStatus();

    status == true ? _deleteStore() : _upsertStore();

    _isFavorite(!isFavorite);
  }

  /// Async Favorite Status with DB
  Future<bool> _favoriteStatus() async {
    var res = await dto.setFavoriteState(
      storeId: id,
      isFavorite: isFavorite,
    );

    return res;
  }

  /// INSERT & UPDATE Favorite Store
  void _upsertStore() {
    dto.upsertFavorite(storeId: id);

    Get.showSnackbar(
      const GetSnackBar(
        message: '플레이스를 찜했어요!',
        duration: Duration(seconds: 2),
      ),
    );
  }

  /// DELETE Store
  void _deleteStore() {
    dto.deleteFavorite(storeId: id);

    Get.showSnackbar(
      const GetSnackBar(
        message: '플레이스 찜하기를 취소했어요!',
        duration: Duration(seconds: 2),
      ),
    );
  }

  /// Get Store Uploader Name
  Future<void> getStoreUploader(BuildContext context) async {
    final userModel = await dto.fetchStoreUploaderName(
      otherUid: uid,
    );

    _uploaderName.value = userModel.name;
  }

  @override
  void onInit() {
    super.onInit();

    _isFavorite.value = false;

    _favoriteStatus();
  }
}
