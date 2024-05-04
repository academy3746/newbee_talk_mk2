import 'package:get/get.dart';
import 'package:newbee_talk_mk2/features/auth/models/user.dart';
import 'package:newbee_talk_mk2/features/chat/models/chat_room.dart';

class ChatRoomCont extends GetxController {
  static ChatRoomCont get to => Get.find<ChatRoomCont>();

  /// Models Records
  final _models = Rxn<(ChatRoomModel, UserModel)>();

  /// [Getter] Models Records
  (ChatRoomModel, UserModel)? get models => _models.value;

  /// Set Models Records
  void setRecords((ChatRoomModel, UserModel) models) {
    _models.value = models;
  }
}