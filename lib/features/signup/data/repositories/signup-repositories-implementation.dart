import 'dart:convert';

import 'package:customerapp/core/constants.dart';
import 'package:customerapp/core/errors/custom_error.dart';
import 'package:customerapp/core/repositories/core_repository.dart';
import 'package:customerapp/core/results/result.dart';
import 'package:customerapp/core/models/empty_response_model.dart';
import 'package:customerapp/features/login/data/models/user.dart';
import 'package:customerapp/core/services/http_service/http_service.dart';
import 'package:customerapp/features/signup/domain/repositories/signup-repositories.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

// TODO: I comment this class , till the API is ready @azhar
class SignUpRepositoryImplementation implements SignUpRepository {
  final  httpCall = HttpService();

  @override
  Future<Result<RemoteResultModel<String>>> signUpUser (UserModel userModel) async {
    print( userModel.toJson());
    var userData = {
      "Email": userModel.email,
    };
    print(userData);
    // TODO: implement  ForgotPassword
    final response = await CoreRepository.request(url: loginUrl, method: HttpMethod.POST, converter: null, data:userData);
    if (response.hasDataOnly) {
      print(response.data);
      final res = response.data;
      final _data = RemoteResultModel<String>.fromJson(res);
      if (_data.success) {
        return Result(data: _data);
      } else {
       final msg =  translator.currentLanguage == 'en' ?_data.msgEN :_data.msgAR;
        return Result(error: CustomError(message: msg));
      }
    }
    if (response.hasErrorOnly) {
      return Result(error: response.error);
    }
   // return Result(data: EmptyResultModel());

  }

}
