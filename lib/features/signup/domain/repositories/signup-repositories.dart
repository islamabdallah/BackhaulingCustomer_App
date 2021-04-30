import 'package:customerapp/core/models/empty_response_model.dart';
import 'package:customerapp/core/results/result.dart';
import 'package:customerapp/features/signup/data/models/registerData.dart';
// TODO: I comment this class , till the API is ready @azhar

abstract class  SignUpRepository {
  Future<Result<dynamic>> getIndustryData();

  Future<Result<RemoteResultModel<String>>>  signUpUser(RegisterModel registerModel);
}
