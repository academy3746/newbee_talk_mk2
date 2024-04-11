import 'package:flutter/material.dart';
import 'package:newbee_talk_mk2/common/constant/sizes.dart';
import 'package:newbee_talk_mk2/common/widgets/common_text.dart';

class PlainText extends StatelessWidget {
  const PlainText({
    super.key,
    required this.content,
    this.height,
  });

  final String content;

  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: Sizes.size8),
      padding: const EdgeInsets.all(Sizes.size16),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.size4),
          side: const BorderSide(
            color: Colors.black87,
            width: 2,
          ),
        ),
      ),
      child: CommonText(
        textContent: content,
        textColor: Colors.black87,
        textSize: Sizes.size16,
        textWeight: FontWeight.w600,
      ),
    );
  }
}
