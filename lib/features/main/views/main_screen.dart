// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:newbee_talk_mk2/common/utils/back_handler_button.dart';
import 'package:newbee_talk_mk2/features/main/controllers/main_controller.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String routeName = '/main';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final cont = MainCont.to;

  BackHandlerButton? backHandlerButton;

  @override
  void initState() {
    super.initState();

    backHandlerButton = BackHandlerButton();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (backHandlerButton != null) {
          return backHandlerButton!.onWillPop(context);
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
