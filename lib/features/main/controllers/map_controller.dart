import 'dart:async';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:newbee_talk_mk2/common/widgets/app_snackbar.dart';
import 'package:permission_handler/permission_handler.dart';

class MapCont extends GetxController {
  static MapCont get to => Get.find<MapCont>();

  /// Initialize Map Synchronize
  final _completer = Completer<NaverMapController>();

  /// Getter (_completer)
  Completer<NaverMapController> get completer => _completer;

  /// Get My Location
  Future<NCameraPosition> _fetchLocation() async {
    LocationPermission permission;

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
}