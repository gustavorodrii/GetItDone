import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userID');

    await Future.delayed(const Duration(seconds: 2));

    if (userId != null) {
      Future.delayed(Duration.zero, () => Get.offNamed('/home'));
    } else {
      Future.delayed(Duration.zero, () => Get.offNamed('/login'));
    }
  }
}
