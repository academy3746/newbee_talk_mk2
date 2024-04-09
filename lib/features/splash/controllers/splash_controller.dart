import 'package:get/get.dart';
import 'package:newbee_talk_mk2/app_router.dart';
import 'package:newbee_talk_mk2/dao/dao.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashCont extends GetxController {
  static SplashCont get to => Get.find<SplashCont>();

  /// Initialize Supabase Auth
  final _dao = SupabaseDao.init;

  /// Getter (_dao)
  SupabaseClient get dao => _dao;

  /// Login Flag
  void _onBoardNavigate() {
    if (dao.auth.currentUser == null) {
      Future.delayed(const Duration(seconds: 2), () {
        AppRouter.login().off();
      });
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        AppRouter.main().off();
      });
    }
  }

  @override
  void onInit() {
    super.onInit();

    _onBoardNavigate();
  }
}
