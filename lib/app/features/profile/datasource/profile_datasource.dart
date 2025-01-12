import 'package:getitdone/app/models/top_consecutive.dart';
import '../../../service/dio_service.dart';
import '../../../service/result.dart';

class ProfileDatasource {
  String endpoint = "/todo";

  Future<Result<List<TopConsecutive>>> fetchTopConsecutive() async {
    final dio = DioService().dio;
    try {
      final response = await dio.get(endpoint);

      final data = response.data as List;
      final topConsecutive =
          data.map((e) => TopConsecutive.fromJson((e))).take(10).toList();

      return Result.success(topConsecutive);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
