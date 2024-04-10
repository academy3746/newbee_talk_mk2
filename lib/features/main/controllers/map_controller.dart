import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:newbee_talk_mk2/common/constant/gaps.dart';
import 'package:newbee_talk_mk2/common/constant/sizes.dart';
import 'package:newbee_talk_mk2/common/widgets/app_snackbar.dart';
import 'package:newbee_talk_mk2/common/widgets/common_button.dart';
import 'package:newbee_talk_mk2/common/widgets/common_text.dart';
import 'package:newbee_talk_mk2/dao/dao.dart';
import 'package:newbee_talk_mk2/features/store/models/store.dart';
import 'package:permission_handler/permission_handler.dart';

class MapCont extends GetxController {
  static MapCont get to => Get.find<MapCont>();

  /// Initialize Map Synchronize
  final _completer = Completer<NaverMapController>();

  /// Instances Data Transfer Class
  final _dto = SupabaseService();

  /// Instances Store List
  final _storeList = RxList<FoodStoreModel>();

  /// Getter (_completer)
  Completer<NaverMapController> get completer => _completer;

  /// Getter (_dao)
  SupabaseService get dto => _dto;

  /// Getter (_storeList)
  List<FoodStoreModel> get storeList => _storeList;

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

  /// Show Markers with Food Store Info
  void storeInfoWithMarkers(
    NaverMapController mapCont,
    List<FoodStoreModel>? data,
    BuildContext context,
  ) {
    mapCont.clearOverlays();

    for (FoodStoreModel model in data!) {
      final marker = NMarker(
        id: model.id.toString(),
        position: NLatLng(
          model.latitude,
          model.longitude,
        ),
        caption: NOverlayCaption(text: model.storeName),
      );

      marker.setOnTapListener((overlay) {
        return _showStoreInfoBottomSheet(
          model,
          context,
        );
      });

      mapCont.addOverlay(marker);
    }
  }

  /// Show BottomModalSheet Including Store Info
  void _showStoreInfoBottomSheet(FoodStoreModel model, BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Sizes.size10),
          topRight: Radius.circular(Sizes.size10),
        ),
      ),
      builder: (context) {
        return _buildBottomModalSheet(
          model,
          context,
        );
      },
    );
  }

  /// Build BottomModalSheet UI
  Widget _buildBottomModalSheet(FoodStoreModel model, BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
          horizontal: Sizes.size20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Store Headers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  textContent: model.storeName,
                  textColor: Colors.black87,
                  textSize: Sizes.size20,
                  textWeight: FontWeight.w700,
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.close,
                    size: Sizes.size24,
                  ),
                ),
              ],
            ),
            Gaps.v10,

            /// Store Img
            model.storeImgUrl != null
                ? CircleAvatar(
                    radius: Sizes.size42,
                    backgroundImage: NetworkImage(model.storeImgUrl!),
                  )
                : const Icon(
                    Icons.storefront_outlined,
                    size: Sizes.size42,
                  ),
            Gaps.v10,

            /// Store Description
            CommonText(
              textContent: model.storeInfo,
              textColor: Colors.black87,
              textSize: Sizes.size16,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Gaps.v10,

            /// Navigate to Detail Page
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: Sizes.size54,
              child: CommonButton(
                btnBackgroundColor: Colors.black87,
                btnText: '자세히보기',
                textColor: Colors.grey.shade200,
                btnAction: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Fetch All Food Store Info
  Future<List<FoodStoreModel>> fetchAllFoodStoreInfo() async {
    var res = await dto.fetchStoreInfo()!;

    return res;
  }

  @override
  void onInit() {
    super.onInit();

    fetchAllFoodStoreInfo();
  }
}
