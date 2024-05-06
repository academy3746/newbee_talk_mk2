import 'package:get/get.dart';
import 'package:newbee_talk_mk2/app_router.dart';
import 'package:newbee_talk_mk2/dao/dao.dart';
import 'package:newbee_talk_mk2/features/chat/controllers/chat_room_controller.dart';
import 'package:newbee_talk_mk2/features/chat/models/chat_message.dart';

class ChatCont extends GetxController {
  static ChatCont get to => Get.find<ChatCont>();

  /// Instances Supabase Service Class
  final _dto = SupabaseService();

  /// [Getter] Supabase Service Class
  SupabaseService get dto => _dto;

  /// Fetch My Chat Rooms
  Future<List<ChatMessageModel>> fetchChatRooms() async {
    var res = await dto.fetchChatRooms();

    return res;
  }

  /// Get My UID
  String myUid() => dto.getMyUid();

  /// Enter Current Chat Room
  Future<void> enterCurrentChatRoom(int chatRoomId) async {
    final chatRoomCont = ChatRoomCont.to;

    var chatRoomModel = await dto.encounterCurrentChatRoom(chatRoomId);

    String? otherUid;

    for (var uid in chatRoomModel.membersUid) {
      if (uid != myUid()) {
        otherUid = uid;

        break;
      }
    }

    var userModel = await dto.fetchAnotherUser(otherUid!);

    chatRoomCont.setRecords((
      chatRoomModel,
      userModel,
    ));

    AppRouter.chat().to();
  }
}
