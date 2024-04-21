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
  final _favorite = <int, bool>{}.obs;

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
  Map<int, bool> get favorite => _favorite;

  /// Getter (_dto)
  SupabaseService get dto => _dto;

  /// Getter (_uploaderName)
  String get uploaderName => _uploaderName.value;

  /// Getter (_uid)
  String get uid => _uid.value;

  /// Favorite status from DB
  Future<void> setMyFavorite() async {
    var favorite = await dto.favoriteStatus(id);

    _favorite[id] = favorite;
  }

  /// Update Favorite State UI
  bool? getMyFavorite() {
    var res = _favorite[id] ?? false;

    return res;
  }

  /// Get Query Parameter From MapCont
  void setStoreData(FoodStoreModel model) {
    _id.value = model.id!;

    _storeName.value = model.storeName;

    _storeAddress.value = model.storeAddress;

    _storeInfo.value = model.storeInfo;

    _storeImgUrl.value = model.storeImgUrl;

    _uid.value = model.uid;
  }

  /// Favorite Button OnPressed
  Future<void> favoriteButtonOnPressed() async {
    var status = await dto.getMyFavorite(
      storeId: id,
    );

    status.isNotEmpty == true ? _deleteStore() : _upsertStore();
  }

  /// INSERT & UPDATE Store
  void _upsertStore() {
    var selected = _favorite[id];

    _favorite[id] = true;

    dto.upsertFavorite(
      storeId: id,
      isFavorite: selected,
    );

    Get.showSnackbar(
      const GetSnackBar(
        message: '플레이스를 찜했어요!',
        duration: Duration(seconds: 2),
      ),
    );
  }

  /// DELETE Store
  void _deleteStore() {
    _favorite[id] = false;

    dto.deleteFavorite(
      storeId: id,
    );

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
}
