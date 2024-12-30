import 'package:getitdone/app/models/user_model.dart';
import 'package:getitdone/app/service/dio_service.dart';
import 'package:getitdone/app/shared/providers/user_provider.dart';
import '../../../service/result.dart';

class LoginDatasource {
  final UserProvider userProvider;

  String endpoint = "/login";

  LoginDatasource({required this.userProvider});

  Future<Result<UserModel>> login(String email, String password) async {
    final dio = DioService().dio;
    try {
      final response = await dio
          .post(endpoint, data: {"email": email, "password": password});
      final data = UserModel.fromJson(response.data);
      userProvider.setUserName(data.name);
      userProvider.setUserID(data.id);
      return Result.success(data);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
