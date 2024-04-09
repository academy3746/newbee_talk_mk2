import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:newbee_talk_mk2/features/main/controllers/main_controller.dart';
import 'package:newbee_talk_mk2/features/main/controllers/map_controller.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MapCont cont = MapCont.to;

    return Scaffold(
      body: NaverMap(
        options: const NaverMapViewOptions(
          indoorEnable: true,
          locationButtonEnable: true,
          consumeSymbolTapEvents: false,
        ),
        onMapReady: (mapCont) => cont.onMapReady(mapCont),
      ),
    );
  }
}
