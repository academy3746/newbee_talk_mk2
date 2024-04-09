import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbee_talk_mk2/common/widgets/back_handler_button.dart';
import 'package:newbee_talk_mk2/common/widgets/form_field_validator.dart';

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

  @override
  void onInit() {
    super.onInit();

    validation;
  }
}