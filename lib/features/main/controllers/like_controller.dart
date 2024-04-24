import 'package:get/get.dart';
import 'package:newbee_talk_mk2/dao/dao.dart';
import 'package:newbee_talk_mk2/features/store/models/store.dart';

class LikeCont extends GetxController {
  static LikeCont get to => Get.find<LikeCont>();

  /// Food Store Items List
  final _items = RxList<FoodStoreModel>();

  /// Supabase Service DTO Class
  final _dto = SupabaseService();

  /// Favorite Status
  final _favorite = <int, bool>{}.obs;

  /// [Getter] Food Store Items List
  List<FoodStoreModel> get items => _items;

  /// [Getter] Supabase Service DTO Class
  SupabaseService get dto => _dto;

  /// [Getter] Favorite Status
  Map<int, bool> get favorite => _favorite;

  /// Async with FoodStore Model
  Future<List<FoodStoreModel>> asyncFoodStoreBuilder() async {
    var res = await dto.fetchMyFavoriteStore();

    _items(res);

    return res;
  }

  /// Set Favorite Value
  setFavorite(int storeId, bool value) {
    _favorite[storeId] = value;
  }

  /// Set Favorite State on UI
  bool? isFavorite(int storeId) {
    var res = _favorite[storeId] ?? false;

    return res;
  }
}