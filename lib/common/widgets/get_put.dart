import 'package:get/get.dart';
import 'package:newbee_talk_mk2/features/auth/controllers/login_controller.dart';
import 'package:newbee_talk_mk2/features/auth/controllers/sign_up_controller.dart';
import 'package:newbee_talk_mk2/features/main/controllers/main_controller.dart';
import 'package:newbee_talk_mk2/features/main/controllers/map_controller.dart';
import 'package:newbee_talk_mk2/features/splash/controllers/splash_controller.dart';
import 'package:newbee_talk_mk2/features/store/controllers/edit_controller.dart';

/// Project Root InitialBinding
class GetPut {
  static void put() {
    /// [Splash] Splash Controller
    Get.put(SplashCont());

    /// [Auth] Login Controller
    Get.put(LoginCont());

    /// [Auth] SignUp Controller
    Get.put(SignUpCont());

    /// [Main] Main Controller
    Get.put(MainCont());

    /// [Main] Map Controller
    Get.put(MapCont());

    /// [Store] Edit Controller
    Get.put(EditCont());
  }
}
