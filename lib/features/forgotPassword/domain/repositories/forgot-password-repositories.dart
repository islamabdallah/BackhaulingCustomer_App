import 'package:customerapp/core/models/empty_response_model.dart';
import 'package:customerapp/core/results/result.dart';
import 'package:customerapp/features/login/data/models/user.dart';
// TODO: I comment this class , till the API is ready @azhar

abstract class  ForgotPasswordRepository {
  Future<Result<RemoteResultModel<String>>>  forgotPasswordUser(UserModel userModel);
}
