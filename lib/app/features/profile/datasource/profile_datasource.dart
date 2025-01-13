import 'package:getitdone/app/models/top_consecutive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../service/dio_service.dart';
import '../../../service/result.dart';

class ProfileDatasource {
  String endpoint = "/todo/consecutiveDaysUsers";

  Future<Result<TopConsecutive>> fetchTopConsecutive() async {
    final dio = DioService().dio;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final response = await dio.get('$endpoint/${prefs.getString("userID")}');
      final data = response.data;

      final actualUser = TopConsecutive.fromJson(data);

      return Result.success(actualUser);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
