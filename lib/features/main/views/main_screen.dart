// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:newbee_talk_mk2/features/main/controllers/main_controller.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const String routeName = '/main';

  @override
  Widget build(BuildContext context) {
    final cont = MainCont.to;

    final back = cont.backHandlerButton;

    return WillPopScope(
      onWillPop: () {
        if (back != null) {
          return back.onWillPop();
        }

        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(),
      ),
    );
  }
}
