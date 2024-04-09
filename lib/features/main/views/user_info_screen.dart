import 'package:flutter/material.dart';
import 'package:newbee_talk_mk2/common/constant/sizes.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(Sizes.size20),
        child: Center(
          child: TextButton(
            onPressed: () {},
            child: const Text(
              'Info Screen',
              style: TextStyle(
                color: Colors.black,
                fontSize: Sizes.size38,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
