import 'package:get/get.dart';
import 'package:newbee_talk_mk2/app_router.dart';
import 'package:newbee_talk_mk2/dao/dao.dart';
import 'package:newbee_talk_mk2/features/auth/models/user.dart';
import 'package:newbee_talk_mk2/features/chat/controllers/chat_room_controller.dart';

class HomeCont extends GetxController {
  static HomeCont get to => Get.find<HomeCont>();

  /// Instances Supabase Service Class
  final _dto = SupabaseService();

  /// [Getter] Supabase Service Class
  SupabaseService get dto => _dto;

  /// Fetch App User Profiles
  Future<List<UserModel>> fetchProfiles() async {
    var res = await dto.fetchProfiles();

    return res;
  }

  /// Navigate To ChatRoom
  Future enterChatRoom(String otherUid, UserModel userModel) async {
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
}
