// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbee_talk_mk2/features/main/controllers/main_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const String routeName = '/main';

  @override
  Widget build(BuildContext context) {
    MainCont cont = MainCont.to;

    final back = cont.backHandlerButton;

    return WillPopScope(
      onWillPop: () {
        if (back != null) {
          return back.onWillPop();
        }

        return Future.value(false);
      },
      child: Obx(
        () => Scaffold(
          backgroundColor: Colors.white,
          body: cont.screenList.elementAt(cont.screenIndex),
          bottomNavigationBar: _buildBottomNavigationBar(context),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    final cont = MainCont.to;

    return BottomNavigationBar(
      currentIndex: cont.screenIndex,
      backgroundColor: Theme.of(context).primaryColor,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black54,
      onTap: (int value) => cont.screenSelected(value),
      items: const [
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.map),
          label: 'MAP'
        ),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.heart),
            label: 'LIKE'
        ),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user),
            label: 'MY'
        ),
      ],
    );
  }
}
