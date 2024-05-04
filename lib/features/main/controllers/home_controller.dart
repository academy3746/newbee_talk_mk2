import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbee_talk_mk2/app_router.dart';
import 'package:newbee_talk_mk2/dao/dao.dart';
import 'package:newbee_talk_mk2/features/auth/models/user.dart';
import 'package:newbee_talk_mk2/features/chat/controllers/chat_room_controller.dart';

class HomeCont extends GetxController {
  static HomeCont get to => Get.find<HomeCont>();

  /// Instances Supabase Service Class
  final _dto = SupabaseService();

  /// GridView Scroll Controller
  final _scroll = ScrollController().obs;

  /// Users List
  final _data = Rxn<List<UserModel>>();

  /// [Getter] Supabase Service Class
  SupabaseService get dto => _dto;

  /// [Getter] GridView Scroll Controller
  ScrollController get scroll => _scroll.value;

  /// [Getter] Users List
  List<UserModel>? get data => _data.value;

  /// Fetch App User Profiles
  Future<List<UserModel>> fetchProfiles() async {
    var res = await dto.fetchProfiles();

    return res;
  }

  /// Navigate To ChatRoom
  Future<void> enterChatRoom(String otherUid, UserModel userModel) async {
    final chatCont = ChatRoomCont.to;

    final chatRoomModel = await SupabaseService().fetchOrInsertChatRoom(
      otherUid,
    );

    chatCont.setRecords((
      chatRoomModel,
      userModel,
    ));

    AppRouter.chat().to();
  }

  /// Fetch More Data
  Future<void> fetchMoreUsers() async {
    var users = await SupabaseService().fetchProfiles();

    if (users.isNotEmpty) {
      _data.update(
        (val) => val?.addAll(users),
      );
    }
  }

  @override
  void onInit() async {
    super.onInit();

    await fetchMoreUsers();

    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        fetchMoreUsers();
      }
    });
  }
}
