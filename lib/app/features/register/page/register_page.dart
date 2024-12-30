import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getitdone/app/features/register/controller/register_controller.dart';

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
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Seja bem-vindo ao Get It Done',
                    style: TextStyle(fontSize: 20)),
              ],
            ),
            InputTextfield(
              controller: controller.nameController,
              labelText: 'Insira o seu nome',
              icon: Icons.lock,
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
                      onPressed: () => Get.offAllNamed('/login'),
                      child: const Text('Já tenho acesso')),
                ),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () => controller.register(
                              name: controller.nameController.text,
                              email: controller.emailController.text,
                              password: controller.passwordController.text,
                            ),
                        child: const Text('Cadastrar'))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
