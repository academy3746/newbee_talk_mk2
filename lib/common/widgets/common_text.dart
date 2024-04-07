import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  const CommonText({
    super.key,
    required this.textContent,
    this.textSize,
    this.textColor,
    this.textWeight,
    this.maxLines,
    this.overflow,
  });

  final String textContent;

  final double? textSize;

  final Color? textColor;

  final FontWeight? textWeight;

  final int? maxLines;

  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      textContent,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        color: textColor,
        fontSize: textSize,
        fontWeight: textWeight,
      ),
    );
  }
}
