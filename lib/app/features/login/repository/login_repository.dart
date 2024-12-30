import 'package:getitdone/app/features/login/datasource/login_datasource.dart';
import 'package:getitdone/app/models/user_model.dart';

import '../../../service/result.dart';

class LoginRepository {
  final LoginDatasource datasource;

  LoginRepository({required this.datasource});

  Future<Result<UserModel>> login(String email, String password) async {
    return await datasource.login(email, password);
  }
}
