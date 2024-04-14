import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbee_talk_mk2/common/constant/sizes.dart';
import 'package:newbee_talk_mk2/common/widgets/controllers/image_uploader.dart';

class ImageUploader {
  ImageUploader._internal();

  static final ImageUploader _instance = ImageUploader._internal();

  factory ImageUploader() => _instance;

  ImageUploaderCont cont = ImageUploaderCont.to;

  Widget upload(BuildContext context, Widget child) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => _showImageUploadBottomSheet(),
          );
        },
        child: child,
      ),
    );
  }

  /// Show BottomModalSheet for Image Uploading
  Widget _showImageUploadBottomSheet() {
    final cont = ImageUploaderCont.to;

    return Container(
      color: Colors.transparent,
      width: double.infinity,
      margin: const EdgeInsets.all(Sizes.size10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () => cont.takePhoto(),
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
            onPressed: () => cont.selectImage(),
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
            onPressed: () => cont.deleteImage(),
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

  /// Store Image Upload Area UI
  Widget storeImage(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: Sizes.size200 + Sizes.size30,
      decoration: ShapeDecoration(
        color: cont.imgFile == null ? Colors.black87 : Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.size4),
          side: const BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      child: cont.imgFile == null
          ? Icon(
              Icons.image_search_outlined,
              size: Sizes.size96,
              color: Colors.grey.shade200,
            )
          : Image.file(
              cont.imgFile!,
              fit: BoxFit.cover,
            ),
    );
  }
}
