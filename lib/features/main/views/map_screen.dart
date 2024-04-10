import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:newbee_talk_mk2/common/constant/sizes.dart';
import 'package:newbee_talk_mk2/common/widgets/common_text.dart';
import 'package:newbee_talk_mk2/features/main/controllers/map_controller.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildPageBody(context),
    );
  }

  Widget _buildPageBody(BuildContext context) {
    MapCont cont = MapCont.to;

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

        return NaverMap(
          options: const NaverMapViewOptions(
            mapType: NMapType.terrain,
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
      },
    );
  }
}
