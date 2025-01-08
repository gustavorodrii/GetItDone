import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getitdone/app/features/login/repository/login_repository.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final LoginRepository repository;

  LoginController({required this.repository});

  void login({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Erro', 'Preencha todos os campos',
          colorText: Colors.white, backgroundColor: Colors.red);
      return;
    }

    final result = await repository.login(email, password);

    result.fold(
      (sucess) {
        Get.snackbar('Parabéns', 'Aproveite o app',
            colorText: Colors.white, backgroundColor: Colors.green);
        Get.offAllNamed('/mainNavigation');
      },
      (error) {
        Get.snackbar('Houve um erro', 'Credenciais inválidas',
            colorText: Colors.white, backgroundColor: Colors.red);
      },
    );
  }
}
