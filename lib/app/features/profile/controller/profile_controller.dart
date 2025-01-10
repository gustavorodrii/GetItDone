import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getitdone/app/features/profile/repository/profile_repository.dart';
import 'package:getitdone/app/models/top_consecutive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../streams/general_stream.dart';

class ProfileController extends GetxController {
  final ProfileRepository repository;
  var selectedLanguage = 'en'.obs;
  final isLoading = false.obs;
  final List<TopConsecutive> topConsecutive = [];

  ProfileController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    _loadSavedLanguage();
    fetchTopConsecutive();
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

  void fetchTopConsecutive() async {
    isLoading.value = true;

    final result = await repository.fetchTopConsecutive();

    result.fold(
      (sucess) {
        topConsecutive.addAll(sucess);
        isLoading.value = false;
        update();
      },
      (error) {
        print(error);
      },
    );
  }
}
