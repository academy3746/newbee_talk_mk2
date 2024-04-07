import 'package:get/get.dart';
import 'package:newbee_talk_mk2/features/main/controllers/main_controller.dart';
import 'package:newbee_talk_mk2/features/splash/controllers/splash_controller.dart';

class GetPut {
  static void put() {
    /// [Splash] Splash Controller
    Get.put(SplashCont());

    /// [Main] Main Controller
    Get.put(MainCont());
  }
}