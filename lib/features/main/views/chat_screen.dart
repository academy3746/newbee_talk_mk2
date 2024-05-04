import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newbee_talk_mk2/common/constant/gaps.dart';
import 'package:newbee_talk_mk2/common/constant/sizes.dart';
import 'package:newbee_talk_mk2/common/widgets/common_app_bar.dart';
import 'package:newbee_talk_mk2/common/widgets/common_text.dart';
import 'package:newbee_talk_mk2/features/chat/models/chat_message.dart';
import 'package:newbee_talk_mk2/features/main/controllers/chat_controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final cont = ChatCont.to;

  PreferredSizeWidget _buildAppBar() {
    return const CommonAppBar(
      title: '채팅',
      implyLeading: false,
      backgroundColor: Colors.white,
      iconColor: Colors.black87,
      fontColor: Colors.black87,
    );
  }

  Widget _buildPageBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: Sizes.size16,
        horizontal: Sizes.size20,
      ),
      child: _buildChatRoom(),
    );
  }

  /// 대화방 UI
  Widget _buildChatRoom() {
    return FutureBuilder(
      future: cont.fetchChatRooms(),
      builder: (context, snapshot) {
        var rooms = snapshot.data ?? [];

        if (snapshot.hasError) {
          return Center(
            child: CommonText(
              textContent: snapshot.error.toString(),
              textColor: Colors.black87,
              textSize: Sizes.size16,
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: rooms.length,
          separatorBuilder: (context, index) => Gaps.v12,
          itemBuilder: (context, index) {
            var model = rooms[index];

            return _buildSingleChatRoom(
              model,
              index,
            );
          },
        );
      },
    );
  }

  /// 단일 대화방 UI
  Widget _buildSingleChatRoom(ChatMessageModel model, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size16,
        horizontal: Sizes.size8,
      ),
      decoration: ShapeDecoration(
        color: index % 2 == 0 ? Colors.white : Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.size4),
          side: BorderSide.none,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: Sizes.size58,
            height: Sizes.size58,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(360),
              child: model.profileUrl != null && model.profileUrl != ""
                  ? Image.network(
                      model.profileUrl!,
                      fit: BoxFit.cover,
                    )
                  : const FaIcon(
                      FontAwesomeIcons.user,
                      size: Sizes.size18,
                    ),
            ),
          ),
          Gaps.h8,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CommonText(
                  textContent: model.name,
                  textSize: Sizes.size16,
                  textColor: Colors.black87,
                  textWeight: FontWeight.w700,
                ),
                Gaps.v4,
                CommonText(
                  textContent: model.message,
                  textSize: Sizes.size12,
                  textColor: Colors.black87,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Colors.white,
      body: _buildPageBody(context),
    );
  }
}
