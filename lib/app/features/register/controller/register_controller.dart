import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getitdone/app/features/register/repository/register_repository.dart';

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
        Get.snackbar('Parabéns', 'Usuário cadastrado com sucesso',
            colorText: Colors.white, backgroundColor: Colors.green);
        Get.offAllNamed('/welcome', arguments: name);
      },
      (error) {
        Get.snackbar('Houve um erro', 'E-mail já cadastrado',
            colorText: Colors.white, backgroundColor: Colors.red);
      },
    );
  }
}
