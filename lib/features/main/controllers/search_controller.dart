import 'package:get/get.dart';
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

  /// Favorite Status
  final _favorite = <int, bool>{}.obs;

  /// Getter (_searchList)
  List<FoodStoreModel> get searchList => _searchList;

  /// Getter (_items)
  List<FavoriteModel> get items => _items;

  /// Getter (_dto)
  SupabaseService get dto => _dto;

  /// Getter (_isFavorite)
  Map<int, bool> get favorite => _favorite;

  /// Set Favorite Value
  void setFavorite(int storeId, bool value) {
    _favorite[storeId] = value;
  }

  /// Set Favorite State in UI
  bool? getFavorite(int storeId) {
    var res = _favorite[storeId] ?? false;

    return res;
  }

  /// Favorite Status
  Future<List<FavoriteModel>> asyncFavorite() async {
    var res = await dto.fetchFavoriteList();

    _items.value = res;

    return res;
  }

  /// SetState Search Keyword
  void setSearchKeyWord(List<FoodStoreModel> list) {
    _searchList.value = list;
  }

  @override
  void onInit() {
    super.onInit();

    dto.fetchFavoriteList();
  }
}
