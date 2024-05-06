import 'package:get/get.dart';
import 'package:newbee_talk_mk2/app_router.dart';
import 'package:newbee_talk_mk2/features/auth/models/user.dart';
import 'package:newbee_talk_mk2/features/chat/models/chat_message.dart';
import 'package:newbee_talk_mk2/features/chat/models/chat_room.dart';
import 'package:newbee_talk_mk2/features/main/models/favorite.dart';
import 'package:newbee_talk_mk2/features/store/models/store.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static SupabaseClient init = Supabase.instance.client;

  SupabaseService._();

  static final SupabaseService _internal = SupabaseService._();

  factory SupabaseService() => _internal;

  /// Get My UID
  String getMyUid() {
    var res = init.auth.currentUser!.id;

    return res;
  }

  /// Logout Current User
  Future<void> logout() async {
    await init.auth.signOut();

    AppRouter.login().off();

    Get.showSnackbar(
      const GetSnackBar(
        message: '정상적으로 로그아웃 되었습니다!',
        duration: Duration(seconds: 2),
      ),
    );
  }

  /// Fetch Current User Info
  Future<UserModel> fetchUserInfo() async {
    final userMap = await init.from('user').select().eq(
          'uid',
          getMyUid(),
        );

    var res = userMap
        .map(
          (data) => UserModel.fromJson(data),
        )
        .single;

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
    final favoriteMap = await init.from('favorite').select().eq(
          'favorite_uid',
          getMyUid(),
        );

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
    final favoriteMap = await init
        .from('favorite')
        .select()
        .eq('food_store_id', storeId)
        .eq('favorite_uid', getMyUid());

    var res = favoriteMap
        .map(
          (e) => FavoriteModel.fromJson(e),
        )
        .toList();

    return res;
  }

  /// INSERT & UPDATE Favorite Store
  Future<void> upsertFavorite({
    required int storeId,
    bool? isFavorite,
  }) async {
    await init.from('favorite').upsert(
          FavoriteModel(
            foodStoreId: storeId,
            favoriteUid: getMyUid(),
            isFavorite: isFavorite,
          ).toMap(),
        );
  }

  /// Delete Favorite Store
  Future<void> deleteFavorite({
    required int storeId,
  }) async {
    await init
        .from('favorite')
        .delete()
        .eq('food_store_id', storeId)
        .eq('favorite_uid', getMyUid());
  }

  /// Get Favorite Status Value
  Future<bool> favoriteStatus(int storeId) async {
    var map = await init
        .from('favorite')
        .select()
        .eq('food_store_id', storeId)
        .eq('favorite_uid', getMyUid());

    var model = map
        .map(
          (e) => FavoriteModel.fromJson(e),
        )
        .toList()
        .firstOrNull;

    var res = model?.isFavorite ?? false;

    return res;
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

  /// Fetch My Favorite Store
  Future<List<FoodStoreModel>> fetchMyFavoriteStore() async {
    final storeMap = await init
        .from('food_store')
        .select('*, favorite!inner(*)')
        .eq('favorite.favorite_uid', getMyUid());

    var res = storeMap
        .map(
          (data) => FoodStoreModel.fromJson(data),
        )
        .toList();

    return res;
  }

  /// Fetch All User Info For Chat
  Future<List<UserModel>> fetchProfiles() async {
    final profileMap = await init.from('user').select().neq(
          'uid',
          getMyUid(),
        );

    var res = profileMap
        .map(
          (data) => UserModel.fromJson(data),
        )
        .toList();

    return res;
  }

  /// Fetch My Chat Rooms Including Last Chat Messages
  Future<List<ChatMessageModel>> fetchChatRooms() async {
    List<ChatMessageModel> res = [];

    final roomMap = await init.from('chat_room').select();

    var rooms = roomMap
        .map(
          (data) => ChatRoomModel.fromJson(data),
        )
        .toList();

    for (var room in rooms) {
      final messageMap = await init
          .from('chat_message')
          .select()
          .eq('chat_room_id', room.id!)
          .order('created_at', ascending: true);

      if (messageMap.isEmpty) continue;

      var messages = messageMap
          .map(
            (data) => ChatMessageModel.fromJson(data),
          )
          .toList();

      res.add(messages.last);
    }

    return res;
  }

  /// Encounter Current ChatRoom Or Create New ChatRoom
  Future<ChatRoomModel> fetchOrInsertChatRoom(String otherUid) async {
    final roomMap = await init.from('chat_room').select().contains(
          'members_uid',
          '{$otherUid, ${getMyUid()}}',
        );

    if (roomMap.isEmpty) {
      ChatRoomModel chatRoomModel;

      List<Map<String, dynamic>> chatRoomList = await init
          .from('chat_room')
          .insert(ChatRoomModel(membersUid: [otherUid, getMyUid()]).toMap())
          .select();

      chatRoomModel = chatRoomList
          .map(
            (data) => ChatRoomModel.fromJson(data),
          )
          .single;

      return chatRoomModel;
    }

    return roomMap
        .map(
          (data) => ChatRoomModel.fromJson(data),
        )
        .toList()
        .single;
  }

  /// Fetch Chat Messages
  Stream<List<Map<String, dynamic>>> fetchChatMessages({
    required String uid,
    required int chatRoomId,
  }) {
    final res = init
        .from('chat_message')
        .stream(primaryKey: ['id'])
        .eq('chat_room_id', chatRoomId)
        .order('created_at', ascending: true);

    return res;
  }

  /// Fetch My User Info
  Future<UserModel> _fetchMyUserInfo() async {
    final userMap = await init.from('user').select().eq(
          'uid',
          getMyUid(),
        );

    var res = userMap
        .map(
          (data) => UserModel.fromJson(data),
        )
        .single;

    return res;
  }

  /// Send Direct Messages
  Future<void> sendDirectMessage(String message, int chatRoomId) async {
    var userModel = await _fetchMyUserInfo();

    await init.from('chat_message').insert(
          ChatMessageModel(
            message: message,
            uid: userModel.uid,
            profileUrl: userModel.profileUrl ?? '',
            chatRoomId: chatRoomId,
            name: userModel.name,
          ).toMap(),
        );
  }
}
