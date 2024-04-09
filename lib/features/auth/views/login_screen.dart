// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbee_talk_mk2/app_router.dart';
import 'package:newbee_talk_mk2/common/constant/gaps.dart';
import 'package:newbee_talk_mk2/common/constant/sizes.dart';
import 'package:newbee_talk_mk2/common/widgets/common_button.dart';
import 'package:newbee_talk_mk2/common/widgets/common_text.dart';
import 'package:newbee_talk_mk2/common/widgets/common_text_field.dart';
import 'package:newbee_talk_mk2/features/auth/controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    final back = LoginCont.to.backHandlerButton;

    return WillPopScope(
      onWillPop: () {
        if (back != null) {
          return back.onWillPop();
        }

        return Future.value(false);
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: _buildPageBody(context),
        ),
      ),
    );
  }

  Widget _buildPageBody(BuildContext context) {
    LoginCont cont = LoginCont.to;

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Obx(
        () => Form(
          key: cont.formKey,
          child: Container(
            margin: const EdgeInsets.only(
              left: Sizes.size20,
              right: Sizes.size20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v80,
                Center(
                  child: Image.asset(
                    'assets/images/splash.png',
                    width: Sizes.size150 + Sizes.size30,
                    height: Sizes.size150 + Sizes.size30,
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonText(
                      textContent: '뉴비',
                      textSize: Sizes.size38,
                      textWeight: FontWeight.bold,
                    ),
                    CommonText(
                      textContent: '톡톡',
                      textColor: Color(0xFFFDD835),
                      textSize: Sizes.size38,
                      textWeight: FontWeight.bold,
                    ),
                  ],
                ),
                Gaps.v48,
                CommonText(
                  textContent: '이메일주소',
                  textColor: Colors.grey.shade500,
                  textSize: Sizes.size22,
                  textWeight: FontWeight.w700,
                ),

                /// cont.idCont
                CommonTextField(
                  controller: cont.idCont,
                  readOnly: false,
                  obscureText: false,
                  maxLines: 1,
                  validator: (value) => cont.validation.emailValidation(value),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                Gaps.v28,
                CommonText(
                  textContent: '패스워드',
                  textColor: Colors.grey.shade500,
                  textSize: Sizes.size22,
                  textWeight: FontWeight.w700,
                ),

                /// cont.passwordCont
                CommonTextField(
                  controller: cont.passwordCont,
                  readOnly: false,
                  obscureText: true,
                  maxLines: 1,
                  validator: (value) => cont.validation.pwdValidation(value),
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.go,
                ),
                Gaps.v28,
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: Sizes.size58,
                  child: CommonButton(
                    btnText: '로그인',
                    textColor: Colors.white,
                    btnBackgroundColor: Colors.black,
                    btnAction: () {
                      cont.loginWithEmail(
                        cont.idCont.text,
                        cont.passwordCont.text,
                      );
                    },
                  ),
                ),
                Gaps.v16,

                /// SignUp
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: Sizes.size58,
                  child: CommonButton(
                    btnText: '회원가입',
                    textColor: Colors.white,
                    btnBackgroundColor: const Color(0xFFFDD835),
                    btnAction: () => AppRouter.signUp().to(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
