import '../../../models/top_consecutive.dart';
import '../../../service/result.dart';
import '../datasource/profile_datasource.dart';

class ProfileRepository {
  final ProfileDatasource datasource;

  ProfileRepository({required this.datasource});

  Future<Result<TopConsecutive>> fetchTopConsecutive() async {
    return await datasource.fetchTopConsecutive();
  }
}
