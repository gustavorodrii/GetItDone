import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getitdone/app/features/login/repository/login_repository.dart';
import 'package:getitdone/extensions/context_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../streams/general_stream.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final LoginRepository repository;
  var selectedLanguage = 'en'.obs;

  final isLoading = false.obs;

  LoginController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    _loadSavedLanguage();
  }

  void _loadSavedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('language_code');
    if (languageCode != null) {
      selectedLanguage.value = languageCode;
      GeneralStream.setLanguage(Locale(languageCode));
    }
  }

  void updateLanguage(String languageCode) async {
    selectedLanguage.value = languageCode;
    GeneralStream.setLanguage(Locale(languageCode));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', languageCode);
  }

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
