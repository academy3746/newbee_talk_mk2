import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:newbee_talk_mk2/common/widgets/app_snackbar.dart';
import 'package:newbee_talk_mk2/common/widgets/back_handler_button.dart';
import 'package:newbee_talk_mk2/features/main/views/like_screen.dart';
import 'package:newbee_talk_mk2/features/main/views/map_screen.dart';
import 'package:newbee_talk_mk2/features/main/views/user_info_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class MainCont extends GetxController {
  static MainCont get to => Get.find<MainCont>();

  /// Instances BackHandlerButton Class
  final _backHandlerButton = BackHandlerButton();

  /// Screen List
  final _screenList = RxList<Widget>();

  /// Screens Index
  final _screenIndex = 0.obs;

  /// Initialize Map Synchronize
  final _completer = Completer<NaverMapController>();

  /// Getter (_backHandlerButton)
  BackHandlerButton? get backHandlerButton => _backHandlerButton;

  /// Getter (_screenList)
  List<Widget> get screenList => _screenList;

  /// Getter (_screenSelected)
  int get screenIndex => _screenIndex.value;

  /// Getter (_completer)
  Completer<NaverMapController> get completer => _completer;

  /// Screen Selected Status
  void screenSelected(int value) {
    _screenIndex(value);
  }

  /// Get My Location
  Future<NCameraPosition> _fetchLocation() async {
    bool service;

    LocationPermission permission;

    service = await Geolocator.isLocationServiceEnabled();

    if (service == false) {
      return Future.error('Geolocator Service Disabled!');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.deniedForever) {
        var snackbar = AppSnackbar(
          msg: '설정 > 앱 > 권한 목록에서 위치 정보 접근 권한을 수락해 주세요',
        );

        snackbar.showSnackbar(Get.context!);

        openAppSettings();
      }
    }

    var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );

    return NCameraPosition(
      target: NLatLng(
        position.latitude,
        position.longitude,
      ),
      zoom: 15,
    );
  }

  /// Naver Map Ready Callback
  Future<void> onMapReady(NaverMapController mapCont) async {
    var position = await _fetchLocation();

    mapCont.updateCamera(
      NCameraUpdate.fromCameraPosition(position),
    );

    completer.complete(mapCont);
  }

  @override
  void onInit() {
    super.onInit();

    backHandlerButton;

    _screenList([
      const MapScreen(),
      const LikeScreen(),
      const UserInfoScreen(),
    ]);
  }
}
