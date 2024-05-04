import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newbee_talk_mk2/common/constant/gaps.dart';
import 'package:newbee_talk_mk2/common/constant/sizes.dart';
import 'package:newbee_talk_mk2/common/widgets/common_app_bar.dart';
import 'package:newbee_talk_mk2/common/widgets/common_text.dart';
import 'package:newbee_talk_mk2/features/auth/models/user.dart';
import 'package:newbee_talk_mk2/features/main/controllers/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final cont = HomeCont.to;

  PreferredSizeWidget _buildAppBar() {
    return const CommonAppBar(
      title: '뉴비톡톡',
      implyLeading: false,
      backgroundColor: Colors.white,
      iconColor: Colors.black87,
      fontColor: Colors.black87,
    );
  }

  Widget _buildPageBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: Sizes.size24,
        horizontal: Sizes.size20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CommonText(
            textContent: '빠르고! 쉽게! 대화 파트너를 찾아 볼까요?',
            textColor: Colors.black87,
            textSize: Sizes.size16,
            textWeight: FontWeight.w500,
          ),
          Gaps.v16,

          /// 앱 사용자 프로필 UI
          _buildProfiles(),
        ],
      ),
    );
  }

  /// 앱 사용자 프로필 UI
  Widget _buildProfiles() {
    return FutureBuilder(
      future: cont.fetchProfiles(),
      builder: (context, snapshot) {
        var profiles = snapshot.data ?? [];

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

        return GridView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: Sizes.size20,
            mainAxisSpacing: Sizes.size24,
          ),
          itemCount: profiles.length,
          itemBuilder: (context, index) {
            var model = profiles[index];

            return _buildSingleProfile(model);
          },
        );
      },
    );
  }

  /// 단일 사용자 프로필 UI
  Widget _buildSingleProfile(UserModel model) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.size10),
          side: const BorderSide(
            color: Colors.black87,
            width: 2.5,
          ),
        ),
      ),
      child: Stack(
        children: [
          /// 프로필 사진
          Align(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Sizes.size10),
              child: model.profileUrl != null && model.profileUrl != ""
                  ? Image.network(
                      model.profileUrl!,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : FaIcon(
                      FontAwesomeIcons.user,
                      size: Sizes.size36,
                      color: Colors.grey.shade200,
                    ),
            ),
          ),

          /// Background Shadow
          Container(
            color: Colors.black87.withOpacity(0.3),
          ),

          /// 유저명
          Padding(
            padding: const EdgeInsets.only(
              bottom: Sizes.size12,
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CommonText(
                textContent: model.name,
                textColor: Colors.grey.shade200,
                textSize: Sizes.size20,
                textWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      ),
    );
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
