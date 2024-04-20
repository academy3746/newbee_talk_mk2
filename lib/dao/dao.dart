import 'package:newbee_talk_mk2/features/auth/models/user.dart';
import 'package:newbee_talk_mk2/features/favorite/models/favorite.dart';
import 'package:newbee_talk_mk2/features/store/models/store.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static SupabaseClient init = Supabase.instance.client;

  SupabaseService._internal();

  static final SupabaseService _instance = SupabaseService._internal();

  factory SupabaseService() => _instance;

  /// Get My UID
  String getMyUid() {
    var res = init.auth.currentUser!.id;

    return res;
  }

  /// SELECT * FROM `food_store` WHERE (1)
  Future<List<FoodStoreModel>>? fetchStoreInfo() async {
    List<FoodStoreModel> result = [];

    final foodMap = await init.from('food_store').select();

    result = foodMap
        .map(
          (data) => FoodStoreModel.fromJson(data),
        )
        .toList();

    return result;
  }

  /// Get Store Uploader Name
  Future<UserModel> fetchStoreUploaderName({
    required String otherUid,
  }) async {
    final userMap = await init.from('user').select().eq(
          'uid',
          otherUid,
        );

    var res = userMap
        .map(
          (data) => UserModel.fromJson(data),
        )
        .single;

    return res;
  }

  /// SELECT * FROM `favorite` ...
  Future<List<FavoriteModel>> fetchFavoriteList() async {
    final favoriteMap =
        await init.from('favorite').select().eq('favorite_uid', getMyUid());

    var res = favoriteMap
        .map(
          (data) => FavoriteModel.fromJson(data),
        )
        .toList();

    return res;
  }

  /// Get My Favorite
  Future<List<FavoriteModel>> getMyFavorite({
    required int storeId,
  }) async {
    final favoriteMap = await init.from('favorite').select().eq(
          'food_store_id',
          storeId,
        );

    var res = favoriteMap
        .map(
          (e) => FavoriteModel.fromJson(e),
        )
        .toList();

    return res;
  }

  /// INSERT & UPDATE Favorite Store
  Future<void> upsertFavorite({required int storeId}) async {
    await init.from('favorite').upsert(
          FavoriteModel(
            foodStoreId: storeId,
            favoriteUid: getMyUid(),
          ).toMap(),
        );
  }

  /// Delete Favorite Store
  void deleteFavorite({required int storeId}) {
    init.from('favorite').delete().eq(
          'food_store_id',
          storeId,
        );
  }

  /// Search by Keyword
  Future<List<FoodStoreModel>> searchByKeyword(String keyword) async {
    var foodMap = await init.from('food_store').select().like(
          'store_name',
          '%$keyword%',
        );

    var res = foodMap
        .map(
          (data) => FoodStoreModel.fromJson(data),
        )
        .toList();

    return res;
  }
}
