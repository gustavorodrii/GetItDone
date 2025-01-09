import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getitdone/app/features/register/controller/register_controller.dart';
import 'package:getitdone/extensions/context_extension.dart';
import 'package:lottie/lottie.dart';

import '../../../shared/components/input_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterController controller = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/register.json'),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Seja bem-vindo ao Get It Done',
                    style: TextStyle(fontSize: 20)),
              ],
            ),
            InputTextfield(
              controller: controller.nameController,
              labelText: context.localizations.inputNameLogin,
              icon: Icons.lock,
            ),
            InputTextfield(
              controller: controller.emailController,
              labelText: context.localizations.inputEmailLogin,
              icon: Icons.email,
            ),
            InputTextfield(
              controller: controller.passwordController,
              labelText: context.localizations.inputPasswordLogin,
              icon: Icons.lock,
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
                    onPressed: () => Get.offAllNamed('/login'),
                    child: Text(context.localizations.alreadyHaveAccess),
                  ),
                ),
                Expanded(
                    child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () => controller.register(
                    name: controller.nameController.text,
                    email: controller.emailController.text,
                    password: controller.passwordController.text,
                  ),
                  child: Text(context.localizations.register),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
