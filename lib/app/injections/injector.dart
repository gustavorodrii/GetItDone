import 'package:get/get.dart';
import 'package:getitdone/app/service/dio_service.dart';

class Injector {
  static void init() {
    Get.put(() => DioService());
  }
}
