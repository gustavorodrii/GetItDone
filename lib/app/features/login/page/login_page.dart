import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getitdone/app/features/login/controller/login_controller.dart';
import 'package:getitdone/extensions/context_extension.dart';
import 'package:lottie/lottie.dart';

import '../../../shared/components/input_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController controller = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                spacing: 15,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Lottie.asset('assets/lottie/loading.json'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: context.localizations.welcomeMessage,
                          style:
                              const TextStyle(color: Colors.blue, fontSize: 24),
                        ),
                      ),
                      RichText(
                        text: const TextSpan(
                          text: 'Get It Done',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 46,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  InputTextfield(
                    controller: controller.emailController,
                    labelText: context.localizations.inputEmailLogin,
                    icon: Icons.email,
                    initialObscureText: false,
                  ),
                  InputTextfield(
                    controller: controller.passwordController,
                    labelText: context.localizations.inputPasswordLogin,
                    icon: Icons.lock,
                    initialObscureText: true,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    spacing: 25,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.white,
                                side: const BorderSide(
                                  color: Colors.blue,
                                  width: 1,
                                )),
                            onPressed: () => Get.offAllNamed('/register'),
                            child: Text(
                              context.localizations.registerButton,
                            )),
                      ),
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue,
                            ),
                            onPressed: () => controller.login(
                                  email: controller.emailController.text,
                                  password: controller.passwordController.text,
                                  context: context,
                                ),
                            child: Text(
                              context.localizations.loginButton,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            controller.isLoading.value
                ? Container(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.blue),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      );
    });
  }
}
