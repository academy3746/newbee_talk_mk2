import 'package:flutter/material.dart';
import 'package:newbee_talk_mk2/common/constant/sizes.dart';

class ImageEditor {
  ImageEditor._();

  static final ImageEditor _internal = ImageEditor._();

  factory ImageEditor() => _internal;

  Widget uploadImage({
    required BuildContext context,
    required Widget imageWidget,
    void Function()? takePhoto,
    void Function()? selectImage,
    void Function()? deleteImage,
  }) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => _popUpImageBottomSheet(
            takePhoto,
            selectImage,
            deleteImage,
          ),
        );
      },
      child: imageWidget,
    );
  }

  Widget _popUpImageBottomSheet(
    void Function()? takePhoto,
    void Function()? selectImage,
    void Function()? deleteImage,
  ) {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      margin: const EdgeInsets.all(Sizes.size10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: takePhoto,
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
            ),
            child: const Text(
              '사진 촬영',
              style: TextStyle(
                color: Colors.black,
                fontSize: Sizes.size18,
              ),
            ),
          ),
          TextButton(
            onPressed: selectImage,
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
            ),
            child: const Text(
              '사진 선택',
              style: TextStyle(
                color: Colors.black,
                fontSize: Sizes.size18,
              ),
            ),
          ),
          TextButton(
            onPressed: deleteImage,
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
            ),
            child: const Text(
              '사진 삭제',
              style: TextStyle(
                color: Colors.black,
                fontSize: Sizes.size18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
