import 'package:customerapp/core/models/empty_response_model.dart';
import 'package:customerapp/core/results/result.dart';
import 'package:customerapp/features/login/data/models/user.dart';
// TODO: I comment this class , till the API is ready @azhar

abstract class  SignUpRepository {
  Future<Result<RemoteResultModel<String>>>  signUpUser(UserModel userModel);
}
