import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:newbee_talk_mk2/common/constant/date.dart';
import 'package:newbee_talk_mk2/common/widgets/app_snackbar.dart';
import 'package:newbee_talk_mk2/dao/dao.dart';
import 'package:newbee_talk_mk2/features/auth/models/user.dart';
import 'package:newbee_talk_mk2/features/chat/models/chat_room.dart';

class ChatRoomCont extends GetxController {
  static ChatRoomCont get to => Get.find<ChatRoomCont>();

  /// Models Records
  final _models = Rxn<(ChatRoomModel, UserModel)>();

  /// Current DateTime
  final _now = DateTime.now().obs;

  /// Instances Supabase DTO Class
  final _dto = SupabaseService();

  /// Message Editing Field Controller
  final _messageCont = TextEditingController().obs;

  /// Make Current Screen Scrollable
  final _onScroll = ScrollController().obs;

  /// [Getter] Models Records
  (ChatRoomModel, UserModel)? get models => _models.value;

  /// [Getter] Current DateTime
  DateTime get now => _now.value;

  /// [Getter] Supabase DTO Class
  SupabaseService get dto => _dto;

  /// [Getter] Message Editing Field Controller
  TextEditingController get messageCont => _messageCont.value;

  /// [Getter] Make Current Screen Scrollable
  ScrollController get onScroll => _onScroll.value;

  /// Set Models Records
  void setRecords((ChatRoomModel, UserModel) models) {
    _models.value = models;
  }

  /// Formatted Datetime
  String currentTime() => date.format(now);

  /// Streaming Chat Messages
  Stream<List<Map<String, dynamic>>> streamChatMessages() {
    var res = dto.fetchChatMessages(
      uid: models!.$2.uid,
      chatRoomId: models!.$1.id!,
    );

    return res;
  }

  /// Get My UID
  String myUid() => dto.getMyUid();

  /// Send Direct Message
  Future<void> sendDM() async {
    if (messageCont.text.isEmpty) {
      var snackbar = AppSnackbar(msg: '메시지를 입력해 주세요!');

      snackbar.showSnackbar();

      return;
    }

    await dto.sendDirectMessage(
      messageCont.text,
      models!.$1.id!,
    );

    FocusManager.instance.primaryFocus?.unfocus();

    messageCont.clear();
  }

  /// Keyboard OnScroll Automatically
  void keyboardOnScroll(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Future.delayed(
          const Duration(milliseconds: 300),
          () {
            if (onScroll.hasClients) {
              onScroll.jumpTo(onScroll.position.maxScrollExtent);
            }
          },
        );
      },
    );
  }
}
