import 'package:get/get.dart';
import '../features/profile/controller/profile_controller.dart';
import '../features/profile/datasource/profile_datasource.dart';
import '../features/profile/repository/profile_repository.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileDatasource());

    Get.lazyPut(() => ProfileRepository(
          datasource: Get.find(),
        ));

    Get.lazyPut(() => ProfileController(repository: Get.find()));
  }
}
