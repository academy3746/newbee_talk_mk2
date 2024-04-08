import 'package:get/get.dart';
import 'package:newbee_talk_mk2/app_router.dart';

class SplashCont extends GetxController {
  static SplashCont get to => Get.find<SplashCont>();

  @override
  void onInit() {
    super.onInit();

    onBoardNavigate();
  }

  /// Login Flag
  void onBoardNavigate() {
    Future.delayed(const Duration(seconds: 2), () {
      AppRouter.login().off();
    });
  }
}
