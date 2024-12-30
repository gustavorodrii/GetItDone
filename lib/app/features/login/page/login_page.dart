import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getitdone/app/features/login/controller/login_controller.dart';

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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Seja bem-vindo ao Get It Done',
                    style: TextStyle(fontSize: 20)),
              ],
            ),
            InputTextfield(
              controller: controller.emailController,
              labelText: 'Insira o seu e-mail',
              icon: Icons.email,
            ),
            InputTextfield(
              controller: controller.passwordController,
              labelText: 'Insira a sua senha',
              icon: Icons.lock,
            ),
            Row(
              spacing: 25,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () => Get.offAllNamed('/register'),
                      child: const Text('Registrar')),
                ),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () => controller.login(
                              email: controller.emailController.text,
                              password: controller.passwordController.text,
                            ),
                        child: const Text('Entrar'))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
