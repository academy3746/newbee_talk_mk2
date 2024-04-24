import 'package:flutter/material.dart';
import 'package:newbee_talk_mk2/common/constant/sizes.dart';
import 'package:newbee_talk_mk2/common/widgets/common_app_bar.dart';
import 'package:newbee_talk_mk2/features/main/widgets/like_items.dart';

class LikeScreen extends StatelessWidget {
  const LikeScreen({super.key});

  PreferredSizeWidget _buildAppBar() {
    return CommonAppBar(
      title: '내 플레이스',
      implyLeading: false,
      backgroundColor: Colors.black87,
      iconColor: Colors.grey.shade200,
      fontColor: Colors.grey.shade200,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        margin: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
          horizontal: Sizes.size20,
        ),
        child: const LikeItems(),
      ),
    );
  }
}
