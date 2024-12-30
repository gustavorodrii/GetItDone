import '../../../models/user_model.dart';
import '../../../service/dio_service.dart';
import '../../../service/result.dart';
import '../../../shared/providers/user_provider.dart';

class RegisterDatasource {
  final UserProvider userProvider;

  String endpoint = "/register";

  RegisterDatasource({required this.userProvider});

  Future<Result<UserModel>> register(
      {required String email,
      required String password,
      required String name}) async {
    final dio = DioService().dio;
    try {
      final response = await dio.post(endpoint,
          data: {"email": email, "password": password, "name": name});
      final data = UserModel.fromJson(response.data);
      userProvider.setUserName(data.name);
      userProvider.setUserID(data.id);
      return Result.success(data);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
