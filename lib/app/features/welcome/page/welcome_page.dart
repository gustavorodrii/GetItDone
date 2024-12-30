import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class WelcomePage extends StatefulWidget {
  dynamic argumentData = Get.arguments;
  WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Seja bem-vindo ${widget.argumentData}'),
            Text('Aproveite o app'),
            ElevatedButton(
              onPressed: () => Get.offAllNamed('/home'),
              child: const Text('Me leve para o app'),
            ),
          ],
        ),
      ),
    );
  }
}
