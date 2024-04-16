import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:newbee_talk_mk2/common/constant/sizes.dart';
import 'package:newbee_talk_mk2/common/widgets/common_text.dart';
import 'package:newbee_talk_mk2/common/widgets/common_text_field.dart';
import 'package:newbee_talk_mk2/features/main/controllers/map_controller.dart';
import 'package:newbee_talk_mk2/features/store/models/store.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final cont = MapCont.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildPageBody(context),
    );
  }

  Widget _buildPageBody(BuildContext context) {
    return FutureBuilder(
      future: cont.fetchAllFoodStoreInfo(),
      builder: (context, snapshot) {
        var data = snapshot.data;

        if (snapshot.hasError) {
          return Center(
            child: CommonText(
              textContent: snapshot.error.toString(),
              textSize: Sizes.size12,
            ),
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        return Stack(
          children: [
            _naverMap(data!),
            _searchField(),
          ],
        );
      },
    );
  }

  /// Naver Map UI
  Widget _naverMap(List<FoodStoreModel> data) {
    return NaverMap(
      options: const NaverMapViewOptions(
        indoorEnable: true,
        locationButtonEnable: true,
        consumeSymbolTapEvents: false,
      ),
      onMapReady: (mapCont) {
        cont.onMapReady(mapCont);

        cont.storeInfoWithMarkers(
          mapCont,
          data,
          context,
        );
      },
    );
  }

  /// Search Field UI
  Widget _searchField() {
    return Obx(
      () => Container(
        color: Colors.white.withOpacity(0.7),
        margin: const EdgeInsets.symmetric(
          horizontal: Sizes.size20,
          vertical: Sizes.size48,
        ),
        child: Form(
          key: cont.formKey,
          child: CommonTextField(
            controller: cont.searchCont,
            hintText: '핫 플레이스를 검색해 보세요!',
            readOnly: false,
            obscureText: false,
            maxLines: 1,
            textInputAction: TextInputAction.search,
            onFieldSubmitted: (keyword) => cont.onFieldSubmitted(keyword),
            validator: (value) => cont.validation.plainValidation(value),
          ),
        ),
      ),
    );
  }
}
