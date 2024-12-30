import 'package:get/get.dart';
import '../features/register/controller/register_controller.dart';
import '../features/register/datasource/register_datasource.dart';
import '../features/register/repository/register_repository.dart';
import '../shared/providers/user_provider.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserProvider());

    Get.lazyPut(() => RegisterDatasource(
          userProvider: Get.find(),
        ));

    Get.lazyPut(() => RegisterRepository(
          datasource: Get.find(),
        ));

    Get.lazyPut(() => RegisterController(repository: Get.find()));
  }
}
