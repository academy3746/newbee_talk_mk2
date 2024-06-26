import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbee_talk_mk2/common/constant/gaps.dart';
import 'package:newbee_talk_mk2/common/constant/sizes.dart';
import 'package:newbee_talk_mk2/common/widgets/common_app_bar.dart';
import 'package:newbee_talk_mk2/common/widgets/common_button.dart';
import 'package:newbee_talk_mk2/common/widgets/common_text.dart';
import 'package:newbee_talk_mk2/common/widgets/common_text_field.dart';
import 'package:newbee_talk_mk2/common/widgets/image_editor.dart';
import 'package:newbee_talk_mk2/features/store/controllers/edit_controller.dart';
import 'package:newbee_talk_mk2/features/store/views/post_screen.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  static const String routeName = '/edit';

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final cont = EditCont.to;

  PreferredSizeWidget _buildAppBar() {
    return CommonAppBar(
      title: '플레이스 등록',
      implyLeading: true,
      backgroundColor: Colors.black87,
      iconColor: Colors.grey.shade200,
      fontColor: Colors.grey.shade200,
    );
  }

  Widget _buildPageBody(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: Sizes.size16,
            horizontal: Sizes.size20,
          ),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Handling Image
                ImageEditor().uploadImage(
                  context: context,
                  imageWidget: _buildStoreImage(context),
                  takePhoto: () {
                    Get.back();

                    cont.takePhoto();
                  },
                  selectImage: () {
                    Get.back();

                    cont.selectImage();
                  },
                  deleteImage: () {
                    Get.back();

                    cont.deleteImage();
                  }
                ),

                _editFormField(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Store Image Upload Area UI
  Widget _buildStoreImage(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: Sizes.size200 + Sizes.size30,
      decoration: ShapeDecoration(
        color:
            cont.storeImgFile == null ? Colors.black87 : Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.size4),
          side: const BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      child: cont.storeImgFile == null
          ? Icon(
              Icons.image_search_outlined,
              size: Sizes.size96,
              color: Colors.grey.shade200,
            )
          : Image.file(
              cont.storeImgFile!,
              fit: BoxFit.cover,
            ),
    );
  }

  /// Multi FormField Area UI
  Widget _editFormField() {
    return Form(
      key: cont.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.v28,

          /// Store Location
          const CommonText(
            textContent: '플레이스 위치 (도로명 주소)',
            textColor: Colors.black87,
            textSize: Sizes.size20,
            textWeight: FontWeight.w600,
          ),
          CommonTextField(
            controller: cont.addrCont,
            hintText: '탭하여 주소를 선택해 주세요',
            readOnly: true,
            obscureText: false,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.streetAddress,
            maxLines: 1,
            validator: (value) => cont.validation.plainValidation(value),
            onTap: () async {
              var result = await Get.toNamed(PostScreen.routeName);

              if (result != null) {
                cont.setPostCodeState(result);
              }
            },
          ),
          Gaps.v28,

          /// Store Name
          const CommonText(
            textContent: '플레이스 명칭',
            textColor: Colors.black87,
            textSize: Sizes.size20,
            textWeight: FontWeight.w600,
          ),
          CommonTextField(
            controller: cont.nameCont,
            hintText: '장소명이 어떻게 되나요?',
            readOnly: false,
            obscureText: false,
            maxLines: 1,
            textInputAction: TextInputAction.next,
            validator: (value) => cont.validation.plainValidation(value),
          ),
          Gaps.v28,

          /// Store Description
          const CommonText(
            textContent: '플레이스 설명',
            textColor: Colors.black87,
            textSize: Sizes.size20,
            textWeight: FontWeight.w600,
          ),
          CommonTextField(
            controller: cont.infoCont,
            hintText: '이곳은 어떤 곳이죠?\n간략하게 설명 부탁드릴게요 😌',
            readOnly: false,
            obscureText: false,
            maxLines: 5,
            maxLength: 500,
            textInputAction: TextInputAction.newline,
            validator: (value) => cont.validation.infoValidation(value),
          ),
          Gaps.v28,

          /// Post Article
          SizedBox(
            width: double.infinity,
            height: Sizes.size64,
            child: CommonButton(
              btnBackgroundColor: Colors.black87,
              btnText: '등록하기',
              textColor: Colors.grey.shade200,
              btnAction: () => cont.postStoreData(),
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
      backgroundColor: Colors.white,
      body: _buildPageBody(context),
    );
  }
}
