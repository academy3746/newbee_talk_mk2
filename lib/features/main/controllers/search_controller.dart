import 'package:get/get.dart';
import 'package:newbee_talk_mk2/dao/dao.dart';
import 'package:newbee_talk_mk2/features/favorite/models/favorite.dart';
import 'package:newbee_talk_mk2/features/store/models/store.dart';

class SearchCont extends GetxController {
  static SearchCont get to => Get.find<SearchCont>();

  /// Search List
  final _searchList = RxList<FoodStoreModel>();

  /// Instances DTO Class
  final _dto = SupabaseService();

  /// Store Id
  final _id = 0.obs;

  /// Getter (_searchList)
  List<FoodStoreModel> get searchList => _searchList;

  /// Getter (_dto)
  SupabaseService get dto => _dto;

  /// Getter (_id)
  int get id => _id.value;

  /// Set Store Id
  void setStoreId(int id) {
    _id.value = id;
  }

  /// Favorite Status
  Future<List<FavoriteModel>> favoriteStatus() async {
    var res = await dto.fetchFavorite(storeId: id);

    return res;
  }

  /// SetState Search Keyword
  void setSearchKeyWord(List<FoodStoreModel> list) {
    _searchList.value = list;
  }
}