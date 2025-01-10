import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getitdone/app/features/register/repository/register_repository.dart';
import 'package:getitdone/extensions/context_extension.dart';

class RegisterController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final RegisterRepository repository;

  RegisterController({required this.repository});

  void register({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      Get.snackbar('Erro', 'Preencha todos os campos',
          colorText: Colors.white, backgroundColor: Colors.red);
      return;
    }
    final result =
        await repository.register(email: email, password: password, name: name);

    result.fold(
      (sucess) {
        Get.snackbar(context.localizations.success,
            context.localizations.registerSuccess,
            colorText: Colors.white, backgroundColor: Colors.green);
        Get.offAllNamed('/welcome', arguments: name);
      },
      (error) {
        Get.snackbar(
            context.localizations.error, context.localizations.errorMessage,
            colorText: Colors.white, backgroundColor: Colors.red);
      },
    );
  }
}
