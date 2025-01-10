import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getitdone/app/features/login/repository/login_repository.dart';
import 'package:getitdone/extensions/context_extension.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final LoginRepository repository;
  final isLoading = false.obs;

  LoginController({required this.repository});

  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Erro', 'Preencha todos os campos',
          colorText: Colors.white, backgroundColor: Colors.red);
      return;
    }

    isLoading.value = true;

    final result = await repository.login(email, password);

    result.fold(
      (sucess) {
        Get.snackbar(
            context.localizations.success, context.localizations.loginSuccess,
            colorText: Colors.white, backgroundColor: Colors.green);
        Get.offAllNamed('/mainNavigation');
        isLoading.value = false;
      },
      (error) {
        Get.snackbar(
            context.localizations.error, context.localizations.errorMessage,
            colorText: Colors.white, backgroundColor: Colors.red);
        isLoading.value = false;
      },
    );
  }
}
