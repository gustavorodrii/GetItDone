import 'package:get/get.dart';
import 'package:getitdone/app/features/profile/datasource/profile_datasource.dart';
import 'package:getitdone/app/features/profile/repository/profile_repository.dart';
import '../features/home/controller/home_controller.dart';
import '../features/home/datasource/home_datasource.dart';
import '../features/home/repository/home_repository.dart';
import '../shared/providers/user_provider.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserProvider());

    Get.lazyPut(() => HomeDatasource());
    Get.lazyPut(() => HomeRepository(
          datasource: Get.find(),
        ));
    Get.lazyPut(
      () => HomeController(repository: Get.find(), userProvider: Get.find()),
    );

    Get.put(ProfileDatasource());

    Get.put(ProfileRepository(datasource: Get.find()));
  }
}
