import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbee_talk_mk2/app_router.dart';
import 'package:newbee_talk_mk2/common/widgets/app_snackbar.dart';
import 'package:newbee_talk_mk2/common/widgets/back_handler_button.dart';
import 'package:newbee_talk_mk2/common/widgets/form_field_validator.dart';
import 'package:newbee_talk_mk2/dao/dao.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginCont extends GetxController {
  static LoginCont get to => Get.find<LoginCont>();

  /// Instances WillPopScope
  final _backHandlerButton = BackHandlerButton();

  /// Id InputField
  final _idCont = TextEditingController().obs;

  /// Password InputField
  final _passwordCont = TextEditingController().obs;

  /// FormField Global Key
  final _formKey = GlobalKey<FormState>().obs;

  /// Text InputField Validator Class
  final _validation = InputFieldValidator();

  /// Initialize Supabase Auth
  final _dao = SupabaseDao.init;

  /// Getter (_backHandlerButton)
  BackHandlerButton? get backHandlerButton => _backHandlerButton;

  /// Getter (_idCont)
  TextEditingController get idCont => _idCont.value;

  /// Getter (_passwordCont)
  TextEditingController get passwordCont => _passwordCont.value;

  /// Getter (_formKey)
  GlobalKey<FormState> get formKey => _formKey.value;

  /// Getter (_val)
  InputFieldValidator get validation => _validation;

  /// Getter (_dao)
  SupabaseClient get dao => _dao;

  /// Login with Email Address
  Future<bool> loginWithEmail(String email, String password) async {
    var success = false;

    var res = await dao.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (res.user != null) {
      var snackbar = AppSnackbar(
        msg: '오늘 하루도 화이팅 💕',
      );

      AppRouter.main().offAll();

      snackbar.showSnackbar(Get.context!);

      success = true;
    } else {
      var snackbar = AppSnackbar(
        msg: '잘못된 로그인 절차입니다!',
      );

      snackbar.showSnackbar(Get.context!);

      success = false;
    }

    return success;
  }

  @override
  void onInit() {
    super.onInit();

    validation;
  }
}
