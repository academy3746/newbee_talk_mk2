import 'package:get/get.dart';
import 'package:newbee_talk_mk2/dao/dao.dart';
import 'package:newbee_talk_mk2/features/auth/models/user.dart';

class UserInfoCont extends GetxController {
  static UserInfoCont get to => Get.find<UserInfoCont>();

  /// Instances DTO Class
  final _dto = SupabaseService();

  /// [Getter] DTO Class
  SupabaseService get dto => _dto;

  /// Get User Info
  Future<UserModel> getUserInfo() async {
    var res = await dto.fetchUserInfo();

    return res;
  }

  /// Logout Current User
  void logout() => dto.logout();
}