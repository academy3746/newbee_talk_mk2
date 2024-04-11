import 'package:newbee_talk_mk2/features/auth/models/user.dart';
import 'package:newbee_talk_mk2/features/store/models/store.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static SupabaseClient init = Supabase.instance.client;

  SupabaseService._internal();

  static final SupabaseService _instance = SupabaseService._internal();

  factory SupabaseService() => _instance;

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

  /// Get Store Uploader Name Single
  Future<UserModel> fetchStoreUploaderName(String otherUid) async {
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
}
