import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbee_talk_mk2/features/auth/views/login_screen.dart';
import 'package:newbee_talk_mk2/features/auth/views/sign_up_screen.dart';
import 'package:newbee_talk_mk2/features/main/views/main_screen.dart';
import 'package:newbee_talk_mk2/features/splash/views/splash_screen.dart';

/// Project Root Router Class
class AppRouter {
  late String page;

  AppRouter(this.page);

  static Duration transitionDuration = const Duration(milliseconds: 100);

  static Transition transition = Transition.fadeIn;

  static Map<String, Widget> get pages => {
        SplashScreen.routeName: const SplashScreen(),
        MainScreen.routeName: const MainScreen(),
        LoginScreen.routeName: const LoginScreen(),
        SignUpScreen.routeName: const SignUpScreen(),
      };

  static List<GetPage> get pagesList => pages.entries
      .map(
        (page) => GetPage(
          name: page.key,
          page: () => page.value,
          transition: transition,
          transitionDuration: transitionDuration,
        ),
      )
      .toList();

  factory AppRouter.splash() => AppRouter(SplashScreen.routeName);

  factory AppRouter.main() => AppRouter(MainScreen.routeName);

  factory AppRouter.login() => AppRouter(LoginScreen.routeName);

  factory AppRouter.signUp() => AppRouter(SignUpScreen.routeName);

  /// Navigation.pushNamed()
  void to({dynamic arguments}) {
    Get.toNamed(
      page,
      arguments: arguments,
    );
  }

  /// Navigation.pushReplacementNamed()
  void off({dynamic arguments}) {
    Get.offNamed(page, arguments: arguments);
  }

  /// Navigation.popAndPushNamed()
  void offAnd({dynamic arguments}) {
    Get.offAndToNamed(
      page,
      arguments: arguments,
    );
  }

  /// Navigation.pushNamedAndRemoveUntil()
  void offAll({dynamic arguments}) {
    Get.offAllNamed(
      page,
      arguments: arguments,
    );
  }
}
