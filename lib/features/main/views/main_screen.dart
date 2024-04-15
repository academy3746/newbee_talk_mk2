// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbee_talk_mk2/app_router.dart';
import 'package:newbee_talk_mk2/common/constant/sizes.dart';
import 'package:newbee_talk_mk2/features/main/controllers/main_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const String routeName = '/main';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final cont = MainCont.to;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (cont.backHandlerButton != null) {
          return cont.backHandlerButton!.onWillPop();
        }

        return Future.value(false);
      },
      child: Obx(
        () => Scaffold(
          backgroundColor: Colors.white,
          body: cont.screenList.elementAt(cont.screenIndex),
          bottomNavigationBar: _buildBottomNavigationBar(),
          floatingActionButton: _buildFloatingActionButton(),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return SizedBox(
      height: Sizes.size64,
      child: BottomNavigationBar(
        currentIndex: cont.screenIndex,
        backgroundColor: Colors.black87,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: const Color(0xFF1DE9B6),
        unselectedItemColor: Colors.grey.shade300,
        onTap: (int value) => cont.screenSelected(value),
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.map),
            label: 'MAP',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.heart),
            label: 'LIKE',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user),
            label: 'MY',
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.black87,
      shape: const CircleBorder(),
      child: Icon(
        Icons.add,
        color: Colors.grey.shade200,
        size: Sizes.size32,
      ),
      onPressed: () => AppRouter.edit().to(),
    );
  }
}
