import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends GetxController {
  var userName = ''.obs;
  @override
  void onInit() async {
    super.onInit();
    await loadUser();
    update();
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('userName');
    userName.value = userData ?? "";
    update();
  }

  Future<void> setUserName(String userName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', userName);
  }

  Future<void> setUserID(String userID) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userID', userID);
  }

  Future<void> resetUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userName');
    prefs.remove('userID');
    Get.offAllNamed('/login');
  }
}
