import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbee_talk_mk2/common/constant/gaps.dart';
import 'package:newbee_talk_mk2/common/constant/sizes.dart';
import 'package:newbee_talk_mk2/common/widgets/common_app_bar.dart';
import 'package:newbee_talk_mk2/common/widgets/common_button.dart';
import 'package:newbee_talk_mk2/common/widgets/common_text.dart';
import 'package:newbee_talk_mk2/common/widgets/common_text_field.dart';
import 'package:newbee_talk_mk2/features/auth/controllers/sign_up_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String routeName = '/signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final cont = SignUpCont.to;

  PreferredSizeWidget _buildAppBar() {
    return const CommonAppBar(
      title: '회원가입',
      implyLeading: true,
      backgroundColor: Colors.white,
      iconColor: Colors.black,
      fontColor: Colors.black,
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
                cont.uploader.showImageUploader(
                  context: context,
                  child: _buildProfile(context),
                ),

                /// FormField
                _formField(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Profile Img Post Widget
  Widget _buildProfile(BuildContext context) {
    if (cont.profileImg == null) {
      return Center(
        child: CircleAvatar(
          backgroundColor: Colors.grey.shade400,
          radius: Sizes.size48,
          child: const Icon(
            Icons.add_a_photo,
            color: Colors.white,
            size: Sizes.size48,
          ),
        ),
      );
    } else {
      return Center(
        child: CircleAvatar(
          backgroundColor: Colors.grey.shade400,
          radius: Sizes.size48,
          backgroundImage: FileImage(cont.profileImg!),
        ),
      );
    }
  }

  /// Register FormField
  Widget _formField(BuildContext context) {
    return Form(
      key: cont.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.v40,

          /// cont.nameCont
          CommonText(
            textContent: '이름',
            textSize: Sizes.size20,
            textColor: Colors.grey.shade500,
            textWeight: FontWeight.w600,
          ),
          CommonTextField(
            controller: cont.nameCont,
            readOnly: false,
            obscureText: false,
            maxLines: 1,
            maxLength: 15,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            enabled: true,
            onTap: null,
            hintText: '이름을 입력해 주세요',
            validator: (value) => cont.validation.nameValidation(value),
          ),

          /// cont.mailCont
          CommonText(
            textContent: '이메일주소',
            textSize: Sizes.size20,
            textColor: Colors.grey.shade500,
            textWeight: FontWeight.w600,
          ),
          CommonTextField(
            controller: cont.mailCont,
            readOnly: false,
            obscureText: false,
            maxLines: 1,
            maxLength: 50,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            enabled: true,
            onTap: null,
            hintText: '이메일 주소를 입력해 주세요',
            validator: (value) => cont.validation.emailValidation(value),
          ),

          /// cont.passwordCont
          CommonText(
            textContent: '패스워드',
            textSize: Sizes.size20,
            textColor: Colors.grey.shade500,
            textWeight: FontWeight.w600,
          ),
          CommonTextField(
            controller: cont.passwordCont,
            readOnly: false,
            obscureText: true,
            maxLines: 1,
            maxLength: 25,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            enabled: true,
            onTap: null,
            hintText: '패스워드를 입력해 주세요',
            validator: (value) => cont.validation.pwdValidation(value),
          ),

          /// cont.pwdReCont
          CommonText(
            textContent: '패스워드 확인',
            textSize: Sizes.size20,
            textColor: Colors.grey.shade500,
            textWeight: FontWeight.w600,
          ),
          CommonTextField(
            controller: cont.pwdReCont,
            readOnly: false,
            obscureText: true,
            maxLines: 1,
            maxLength: 25,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            enabled: true,
            onTap: null,
            hintText: '패스워드를 한 번 더 입력해 주세요',
            validator: (value) => cont.validation.confirmValidation(value),
          ),

          /// cont.introCont
          CommonText(
            textContent: '자기소개',
            textSize: Sizes.size20,
            textColor: Colors.grey.shade500,
            textWeight: FontWeight.w600,
          ),
          CommonTextField(
            controller: cont.introCont,
            readOnly: false,
            obscureText: false,
            maxLines: 5,
            maxLength: 500,
            textInputAction: TextInputAction.newline,
            enabled: true,
            onTap: null,
            hintText: '자기소개를 입력해 주세요',
            validator: (value) => cont.validation.introValidation(value),
          ),

          /// SignUp Complete
          Container(
            width: double.infinity,
            height: Sizes.size64,
            margin: const EdgeInsets.symmetric(vertical: Sizes.size16),
            child: CommonButton(
              btnText: '가입 완료',
              btnBackgroundColor: Colors.black87,
              textColor: Colors.grey.shade200,
              btnAction: () {
                cont.signUpWithEmail(
                  cont.mailCont.text,
                  cont.passwordCont.text,
                );
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
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildPageBody(context),
    );
  }
}
