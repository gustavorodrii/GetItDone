import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getitdone/app/features/register/repository/register_repository.dart';
import 'package:getitdone/extensions/context_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../streams/general_stream.dart';

class RegisterController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final RegisterRepository repository;
  var selectedLanguage = 'en'.obs;
  final isLoading = false.obs;

  RegisterController({required this.repository});

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

  void register({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      Get.snackbar(
          context.localizations.error, context.localizations.emptyRegisterField,
          colorText: Colors.white, backgroundColor: Colors.red);
      return;
    }

    RegExp emailRegex = RegExp(r'^[\w\.-]+@[a-zA-Z\d\.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(email)) {
      Get.snackbar(
          context.localizations.error, context.localizations.invalidEmail,
          colorText: Colors.white, backgroundColor: Colors.red);
      return;
    }

    if (password.length < 6) {
      Get.snackbar(
          context.localizations.error, context.localizations.password6Digits,
          colorText: Colors.white, backgroundColor: Colors.red);
      return;
    }

    isLoading.value = true;

    final result =
        await repository.register(email: email, password: password, name: name);

    result.fold(
      (sucess) {
        Get.snackbar(context.localizations.success,
            context.localizations.registerSuccess,
            colorText: Colors.white, backgroundColor: Colors.green);
        Get.offAllNamed('/welcome', arguments: name);
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
