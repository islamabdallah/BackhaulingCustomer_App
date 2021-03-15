import 'package:customerapp/core/models/empty_response_model.dart';
import 'package:customerapp/core/results/result.dart';
import 'package:customerapp/features/login/data/models/user.dart';
// TODO: I comment this class , till the API is ready @Abeer

abstract class UserRepository {
  Future<Result<RemoteResultModel<String>>> loginUser(UserModel userModel);
}
