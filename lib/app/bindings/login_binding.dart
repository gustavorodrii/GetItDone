import 'package:get/get.dart';
import '../features/login/controller/login_controller.dart';
import '../features/login/datasource/login_datasource.dart';
import '../features/login/repository/login_repository.dart';
import '../shared/providers/user_provider.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserProvider());

    Get.lazyPut(() => LoginDatasource(
          userProvider: Get.find(),
        ));
    Get.lazyPut(() => LoginRepository(
          datasource: Get.find(),
        ));
    Get.lazyPut(
      () => LoginController(repository: Get.find()),
    );
  }
}
