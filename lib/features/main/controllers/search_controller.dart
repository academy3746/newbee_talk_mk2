import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:newbee_talk_mk2/common/constant/sizes.dart';
import 'package:newbee_talk_mk2/dao/dao.dart';
import 'package:newbee_talk_mk2/features/favorite/models/favorite.dart';
import 'package:newbee_talk_mk2/features/store/models/store.dart';

class SearchCont extends GetxController {
  static SearchCont get to => Get.find<SearchCont>();

  /// Search List
  final _searchList = RxList<FoodStoreModel>();

  /// Favorite List
  final _items = RxList<FavoriteModel>();

  /// Instances DTO Class
  final _dto = SupabaseService();

  /// Store Id
  final _id = 0.obs;

  /// Favorite Status
  final _isFavorite = false.obs;

  /// Getter (_searchList)
  List<FoodStoreModel> get searchList => _searchList;

  /// Getter (_items)
  List<FavoriteModel> get items => _items;

  /// Getter (_dto)
  SupabaseService get dto => _dto;

  /// Getter (_id)
  int get id => _id.value;

  /// Getter (_isFavorite)
  bool get isFavorite => _isFavorite.value;

  /// Set Store Id
  void setStoreId(int id) {
    _id.value = id;
  }

  /// Favorite Status
  Future<List<FavoriteModel>> asyncFavorite() async {
    var res = await dto.fetchFavorite(storeId: id);

    _items.value = res;

    return res;
  }

  /// SetState Search Keyword
  void setSearchKeyWord(List<FoodStoreModel> list) {
    _searchList.value = list;
  }

  /// Favorite Icon UI
  Widget favoriteIcon() {
    for (var item in items) {
      if (id == item.foodStoreId) {
        _isFavorite.value = true;

        break;
      }
    }

    if (isFavorite == true) {
      return const FaIcon(
        FontAwesomeIcons.solidHeart,
        color: Colors.pinkAccent,
        size: Sizes.size18,
      );
    }

    return const FaIcon(
      FontAwesomeIcons.heart,
      color: Colors.pinkAccent,
      size: Sizes.size18,
    );
  }
}
