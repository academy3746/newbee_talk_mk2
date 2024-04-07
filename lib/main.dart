import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const TalkApp());
}

class TalkApp extends StatelessWidget {
  const TalkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Talk App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        primaryColor: Colors.lightBlueAccent,
        useMaterial3: true,
      ),
    );
  }
}
