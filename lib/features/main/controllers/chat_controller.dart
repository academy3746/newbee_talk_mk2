import 'package:get/get.dart';
import 'package:newbee_talk_mk2/dao/dao.dart';
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
}