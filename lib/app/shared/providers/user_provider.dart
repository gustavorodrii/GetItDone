import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends GetxController {
  var userName = ''.obs;
  var userEmail = ''.obs;
  @override
  void onInit() async {
    super.onInit();
    await loadUser();
    update();
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userNameData = prefs.getString('userName');
    final userEmailData = prefs.getString('userEmail');
    userName.value = userNameData ?? "";
    userEmail.value = userEmailData ?? "";
    update();
  }

  Future<void> setUserName(String userName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', userName);
  }

  Future<void> setUserEmail(String userName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userEmail', userName);
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
