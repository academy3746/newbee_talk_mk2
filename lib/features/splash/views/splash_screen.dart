import 'package:flutter/material.dart';
import 'package:newbee_talk_mk2/common/constant/sizes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/splash.png',
          width: Sizes.size200,
          height: Sizes.size200,
        ),
      ),
    );
  }
}
