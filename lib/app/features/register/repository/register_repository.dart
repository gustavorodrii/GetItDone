import 'package:getitdone/app/models/user_model.dart';

import '../../../service/result.dart';
import '../datasource/register_datasource.dart';

class RegisterRepository {
  final RegisterDatasource datasource;

  RegisterRepository({required this.datasource});

  Future<Result<UserModel>> register(
      {required String email,
      required String password,
      required String name}) async {
    return await datasource.register(
        email: email, password: password, name: name);
  }
}
