import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbee_talk_mk2/common/constant/gaps.dart';
import 'package:newbee_talk_mk2/common/constant/sizes.dart';
import 'package:newbee_talk_mk2/common/widgets/common_app_bar.dart';
import 'package:newbee_talk_mk2/common/widgets/common_button.dart';
import 'package:newbee_talk_mk2/common/widgets/common_text.dart';
import 'package:newbee_talk_mk2/common/widgets/plain_text.dart';
import 'package:newbee_talk_mk2/features/store/controllers/detail_controller.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  static const String routeName = '/detail';

  PreferredSizeWidget _buildAppBar() {
    DetailCont cont = DetailCont.to;

    return CommonAppBar(
      title: cont.storeName,
      implyLeading: true,
      backgroundColor: Colors.black87,
      iconColor: Colors.grey.shade200,
      fontColor: Colors.grey.shade200,
    );
  }

  Widget _buildPageBody(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
          horizontal: Sizes.size20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _storeImage(context),
            _formFieldArea(context),
          ],
        ),
      ),
    );
  }

  /// Store Image Area
  Widget _storeImage(BuildContext context) {
    DetailCont cont = DetailCont.to;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: Sizes.size200 + Sizes.size30,
      decoration: ShapeDecoration(
        color: cont.storeImgUrl == null ? Colors.black87 : Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.size4),
          side: const BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      child: cont.storeImgUrl == null
          ? Icon(
              Icons.store_mall_directory_outlined,
              size: Sizes.size96,
              color: Colors.grey.shade200,
            )
          : Image.network(
              cont.storeImgUrl!,
              fit: BoxFit.cover,
            ),
    );
  }

  /// FormField Area
  Widget _formFieldArea(BuildContext context) {
    DetailCont cont = DetailCont.to;

    cont.getStoreUploader(context);

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.v16,

          /// Store Address
          const CommonText(
            textContent: '플레이스 위치 (도로명 주소)',
            textColor: Colors.black87,
            textSize: Sizes.size20,
            textWeight: FontWeight.w700,
          ),
          PlainText(content: cont.storeAddress),
          Gaps.v16,

          /// Store User
          const CommonText(
            textContent: '플레이스 공유자',
            textColor: Colors.black87,
            textSize: Sizes.size20,
            textWeight: FontWeight.w700,
          ),
          PlainText(content: cont.uploaderName),
          Gaps.v16,

          /// Store Info
          const CommonText(
            textContent: '플레이스 설명',
            textColor: Colors.black87,
            textSize: Sizes.size20,
            textWeight: FontWeight.w700,
          ),
          PlainText(
            content: cont.storeInfo,
            height: Sizes.size300,
          ),
          Gaps.v16,

          /// Bookmark Button
          SizedBox(
            width: double.infinity,
            height: Sizes.size64,
            child: CommonButton(
              btnText: cont.bookMarkStatus == false ? '찜하기' : '해제하기',
              btnBackgroundColor: cont.bookMarkStatus == false
                  ? Colors.black87
                  : Colors.black38,
              textColor: cont.bookMarkStatus == false
                  ? Colors.grey.shade200
                  : Colors.white,
              btnAction: () {
                cont.bookMarkOnPressed();
              },
            ),
          ),
        ],
      ),
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