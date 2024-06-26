import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbee_talk_mk2/common/widgets/back_handler_button.dart';
import 'package:newbee_talk_mk2/features/main/views/chat_screen.dart';
import 'package:newbee_talk_mk2/features/main/views/home_screen.dart';
import 'package:newbee_talk_mk2/features/main/views/like_screen.dart';
import 'package:newbee_talk_mk2/features/main/views/map_screen.dart';
import 'package:newbee_talk_mk2/features/main/views/user_info_screen.dart';

class MainCont extends GetxController {
  static MainCont get to => Get.find<MainCont>();

  /// Instances BackHandlerButton Widget
  final _backHandlerButton = BackHandlerButton();

  /// Screen List
  final _screenList = RxList<Widget>();

  /// Screens Index
  final _screenIndex = 0.obs;

  /// Getter (_backHandlerButton)
  BackHandlerButton? get backHandlerButton => _backHandlerButton;

  /// Getter (_screenList)
  List<Widget> get screenList => _screenList;

  /// Getter (_screenSelected)
  int get screenIndex => _screenIndex.value;

  /// Screen Selected Status
  void screenSelected(int value) {
    _screenIndex(value);
  }

  @override
  void onInit() {
    super.onInit();

    _screenList([
      const HomeScreen(),
      const MapScreen(),
      const ChatScreen(),
      const LikeScreen(),
      const UserInfoScreen(),
    ]);
  }
}
