import 'package:get/get.dart';
import 'package:newbee_talk_mk2/common/utils/back_handler_button.dart';

class MainCont extends GetxController {
  static MainCont get to => Get.find<MainCont>();

  final _backHandlerButton = BackHandlerButton();

  BackHandlerButton? get backHandlerButton => _backHandlerButton;

  @override
  void onInit() {
    super.onInit();

    backHandlerButton;
  }
}