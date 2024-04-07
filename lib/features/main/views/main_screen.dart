// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:newbee_talk_mk2/common/constant/sizes.dart';
import 'package:newbee_talk_mk2/features/main/controllers/main_controller.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const String routeName = '/main';

  @override
  Widget build(BuildContext context) {
    final back = MainCont.to.backHandlerButton;

    return WillPopScope(
      onWillPop: () {
        if (back != null) {
          return back.onWillPop();
        }

        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: Sizes.size20,
        right: Sizes.size20,
      ),
      child: Center(
        child: TextButton(
          onPressed: () {},
          child: const Text(
            'Test Screen',
            style: TextStyle(
              color: Colors.black,
              fontSize: Sizes.size38,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
