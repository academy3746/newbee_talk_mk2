import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newbee_talk_mk2/common/constant/gaps.dart';
import 'package:newbee_talk_mk2/common/constant/sizes.dart';
import 'package:newbee_talk_mk2/common/widgets/common_app_bar.dart';
import 'package:newbee_talk_mk2/common/widgets/common_text.dart';
import 'package:newbee_talk_mk2/features/chat/controllers/chat_room_controller.dart';
import 'package:newbee_talk_mk2/features/chat/models/chat_message.dart';

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
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: Sizes.size16,
        horizontal: Sizes.size20,
      ),
      child: Column(
        children: [
          /// 오늘 날짜
          Center(
            child: CommonText(
              textContent: cont.currentTime(),
              textColor: Colors.black87,
              textSize: Sizes.size12,
            ),
          ),
          Gaps.v20,

          /// 채팅 영역
          Expanded(
            child: StreamBuilder(
              stream: cont.streamChatMessages(),
              builder: (context, snapshot) {
                var chatList = snapshot.data
                        ?.map(
                          (data) => ChatMessageModel.fromJson(data),
                        )
                        .toList() ??
                    [];

                if (snapshot.hasError) {
                  return Center(
                    child: CommonText(
                      textContent: snapshot.error.toString(),
                      textColor: Colors.black87,
                      textSize: Sizes.size16,
                    ),
                  );
                }

                return ListView.builder(
                  controller: cont.onScroll,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    var model = chatList[index];

                    return _buildChatMessages(model);
                  },
                  itemCount: chatList.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 채팅 메시지 UI
  Widget _buildChatMessages(ChatMessageModel model) {
    if (model.uid == cont.myUid()) {
      return _sender(model);
    }

    return _receiver(model);
  }

  /// 내 채팅 영역
  Widget _sender(ChatMessageModel model) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: Sizes.size8,
      ),
      child: Wrap(
        alignment: WrapAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: Sizes.size8,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size16,
              horizontal: Sizes.size12,
            ),
            decoration: ShapeDecoration(
              color: const Color(0xFF4DB6AC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Sizes.size10),
                side: BorderSide.none,
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4.0,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: CommonText(
              textContent: model.message,
              textColor: Colors.grey.shade200,
              textSize: Sizes.size12,
            ),
          ),
        ],
      ),
    );
  }

  /// 상대방 채팅 영역
  Widget _receiver(ChatMessageModel model) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: Sizes.size8,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          model.profileUrl != null && model.profileUrl != ""
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(360),
                  child: Image.network(
                    model.profileUrl!,
                    width: Sizes.size48,
                    height: Sizes.size48,
                    fit: BoxFit.cover,
                  ),
                )
              : const FaIcon(
                  FontAwesomeIcons.user,
                  size: Sizes.size38,
                ),
          Gaps.h16,
          Wrap(
            alignment: WrapAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: Sizes.size8,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size16,
                  horizontal: Sizes.size12,
                ),
                decoration: ShapeDecoration(
                  color: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Sizes.size10),
                    side: BorderSide.none,
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4.0,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: CommonText(
                  textContent: model.message,
                  textColor: Colors.black87,
                  textSize: Sizes.size12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 하단 전송 필드
  Widget _bottomSubmitField(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        color: Colors.black87,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: cont.messageCont,
                maxLines: 1,
                textInputAction: TextInputAction.done,
                maxLength: 300,
                style: TextStyle(color: Colors.grey.shade200),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintText: '메시지를 입력해 주세요!',
                  hintStyle: TextStyle(color: Colors.grey),
                  counterText: '',
                  counterStyle: TextStyle(fontSize: 0),
                ),
              ),
            ),
            IconButton(
              onPressed: () => cont.sendDM(),
              icon: FaIcon(
                FontAwesomeIcons.paperPlane,
                color: Colors.grey.shade200,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    cont.keyboardOnScroll(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: _buildPageBody(context),
        bottomNavigationBar: _bottomSubmitField(context),
      ),
    );
  }
}
