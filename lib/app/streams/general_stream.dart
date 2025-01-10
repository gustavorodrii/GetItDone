import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeneralStream {
  const GeneralStream._();

  static StreamController<Locale> languageStream = StreamController.broadcast();

  static void setLanguage(Locale locale) async {
    languageStream.add(locale);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language_code', locale.languageCode);
  }

  static Future<void> loadSavedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('language_code');
    if (languageCode == null) {
      languageStream.add(const Locale('en'));
    } else {
      languageStream.add(Locale(languageCode));
    }
  }

  static void close() {
    languageStream.close();
  }
}
