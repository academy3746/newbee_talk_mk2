import 'package:flutter/material.dart';
import 'package:newbee_talk_mk2/common/constant/sizes.dart';

class CommonTextField extends StatefulWidget {
  const CommonTextField({
    super.key,
    required this.controller,
    this.keyboardType,
    this.textInputAction,
    this.enabled,
    required this.readOnly,
    this.onTap,
    this.onFieldSubmitted,
    this.hintText,
    required this.obscureText,
    this.initialValue,
    required this.maxLines,
    this.maxLength,
    required this.validator,
    this.fillColor,
    this.filled,
  });

  final TextEditingController controller;

  final TextInputType? keyboardType;

  final TextInputAction? textInputAction;

  final bool? enabled;

  final bool readOnly;

  final void Function()? onTap;

  final void Function(String value)? onFieldSubmitted;

  final String? hintText;

  final bool obscureText;

  final String? initialValue;

  final int maxLines;

  final int? maxLength;

  final FormFieldValidator validator;

  final Color? fillColor;

  final bool? filled;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Sizes.size10),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        onTap: widget.readOnly ? widget.onTap : null,
        onFieldSubmitted: widget.onFieldSubmitted,
        obscureText: widget.obscureText,
        initialValue: widget.initialValue,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        validator: (value) => widget.validator(value),
        decoration: InputDecoration(
          hintText: widget.hintText,
          fillColor: widget.fillColor,
          filled: widget.filled,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Sizes.size4),
            borderSide: const BorderSide(
              width: 2,
              color: Colors.black,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Colors.redAccent,
            ),
            borderRadius: BorderRadius.circular(Sizes.size6),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Colors.blueAccent,
            ),
            borderRadius: BorderRadius.circular(Sizes.size6),
          ),
        ),
      ),
    );
  }
}
