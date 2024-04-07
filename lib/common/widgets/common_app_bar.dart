import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbee_talk_mk2/common/constant/sizes.dart';

/// Project Common Customized AppBar
class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    required this.title,
    required this.implyLeading,
    this.backBtn,
    this.actions,
    this.centerTitle,
    required this.backgroundColor,
    required this.iconColor,
    required this.fontColor,
  });

  final String title;

  final bool implyLeading;

  final Function? backBtn;

  final List<Widget>? actions;

  final bool? centerTitle;

  final Color backgroundColor;

  final Color iconColor;

  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _titleText(),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      toolbarHeight: Sizes.size50,
      automaticallyImplyLeading: implyLeading,
      titleSpacing: implyLeading ? 0 : Sizes.size16,
      scrolledUnderElevation: 0,
      elevation: 0,
      leading: implyLeading ? _implyLeadingGesture() : null,
      actions: actions,
    );
  }

  /// Automatically ImplyLeading Gesture
  Widget _implyLeadingGesture() {
    return GestureDetector(
      onTap: () {
        backBtn != null ? backBtn!.call() : Get.back();
      },
      child: Icon(
        Icons.arrow_back_ios_new,
        color: iconColor,
      ),
    );
  }

  /// Title Text
  Widget _titleText() {
    return Text(
      title,
      style: TextStyle(
        color: fontColor,
        fontSize: Sizes.size20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
