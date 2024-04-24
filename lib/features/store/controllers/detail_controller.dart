import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbee_talk_mk2/dao/dao.dart';
import 'package:newbee_talk_mk2/features/main/models/favorite.dart';
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

  /// Set Favorite Value with UI
  void setMyFavorite(bool value) {
    _favorite[id] = value;
  }

  /// Update Favorite State UI
  bool? getMyFavorite(int storeId) {
    var res = _favorite[storeId] ?? false;

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
    var status = await dto.getMyFavorite(storeId: id);

    status.isNotEmpty == true ? _deleteStore() : _upsertStore();
  }

  /// INSERT & UPDATE Store
  Future<void> _upsertStore() async {
    var selected = _favorite[id];

    await dto.upsertFavorite(
      storeId: id,
      isFavorite: selected,
    );

    Get.showSnackbar(
      const GetSnackBar(
        message: '플레이스를 찜했어요!',
        duration: Duration(seconds: 1),
      ),
    );

    _favorite[id] = true;
  }

  /// DELETE Store
  Future<void> _deleteStore() async {
    await dto.deleteFavorite(
      storeId: id,
    );

    Get.showSnackbar(
      const GetSnackBar(
        message: '플레이스 찜하기를 취소했어요!',
        duration: Duration(seconds: 1),
      ),
    );

    _favorite[id] = false;
  }

  /// Get Store Uploader Name
  Future<void> getStoreUploader(BuildContext context) async {
    final userModel = await dto.fetchStoreUploaderName(
      otherUid: uid,
    );

    _uploaderName.value = userModel.name;
  }

  /// Async Favorite List
  Future<List<FavoriteModel>> asyncFavoriteList() async {
    var res = await dto.getMyFavorite(storeId: id);

    return res;
  }
}
