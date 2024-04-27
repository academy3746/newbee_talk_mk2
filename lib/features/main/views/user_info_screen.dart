import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newbee_talk_mk2/common/constant/gaps.dart';
import 'package:newbee_talk_mk2/common/constant/sizes.dart';
import 'package:newbee_talk_mk2/common/widgets/common_app_bar.dart';
import 'package:newbee_talk_mk2/common/widgets/common_text.dart';
import 'package:newbee_talk_mk2/common/widgets/plain_text.dart';
import 'package:newbee_talk_mk2/features/auth/models/user.dart';
import 'package:newbee_talk_mk2/features/main/controllers/user_info_controller.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final cont = UserInfoCont.to;

  PreferredSizeWidget _buildAppBar() {
    return CommonAppBar(
      title: '내 정보',
      implyLeading: false,
      backgroundColor: Colors.black87,
      iconColor: Colors.grey.shade200,
      fontColor: Colors.grey.shade200,
      actions: [
        TextButton(
          onPressed: () => cont.logout(),
          child: const CommonText(
            textContent: '로그아웃',
            textColor: Colors.redAccent,
            textSize: Sizes.size20,
            textWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPageBody(BuildContext context) {
    return FutureBuilder(
      future: cont.getUserInfo(),
      builder: (context, snapshot) {
        var model = snapshot.data;

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

        return _buildUserProfile(model!);
      },
    );
  }

  /// Build User Info Area UI
  Widget _buildUserProfile(UserModel model) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Container(
        margin: const EdgeInsets.all(Sizes.size20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// User Container Area UI
            _buildUserContainer(model),
            Gaps.v24,

            /// User Introduction Area UI
            _buildIntroContainer(model),
          ],
        ),
      ),
    );
  }

  /// User Container Area UI
  Widget _buildUserContainer(UserModel model) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size24,
        horizontal: Sizes.size20,
      ),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.size4),
          side: const BorderSide(
            color: Colors.black87,
            width: 2,
          ),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(360),
            child: model.profileUrl != null
                ? Image.network(
                    model.profileUrl!,
                    width: Sizes.size56,
                    height: Sizes.size56,
                    fit: BoxFit.cover,
                  )
                : const FaIcon(
                    FontAwesomeIcons.user,
                    size: Sizes.size56,
                  ),
          ),
          Gaps.h10,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                textContent: model.name,
                textSize: Sizes.size18,
                textColor: Colors.black87,
                textWeight: FontWeight.w700,
              ),
              CommonText(
                textContent: model.email,
                textColor: Colors.grey.shade600,
                textWeight: FontWeight.w500,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// User Introduction Area UI
  Widget _buildIntroContainer(UserModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CommonText(
          textContent: '자기 소개',
          textColor: Colors.black87,
          textSize: Sizes.size20,
          textWeight: FontWeight.bold,
        ),
        PlainText(
          content: model.introduce,
          height: Sizes.size450,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildPageBody(context),
    );
  }
}
