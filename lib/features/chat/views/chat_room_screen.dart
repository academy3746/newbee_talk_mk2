import 'package:flutter/material.dart';
import 'package:newbee_talk_mk2/common/widgets/common_app_bar.dart';
import 'package:newbee_talk_mk2/features/chat/controllers/chat_room_controller.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key});

  static const String routeName = '/chat';

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final cont = ChatRoomCont.to;

  PreferredSizeWidget _buildAppBar() {
    return CommonAppBar(
      title: cont.models!.$2.name,
      implyLeading: true,
      backgroundColor: Colors.black87,
      iconColor: Colors.grey.shade200,
      fontColor: Colors.grey.shade200,
    );
  }

  Widget _buildPageBody(BuildContext context) {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildPageBody(context),
    );
  }
}
