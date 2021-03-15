import 'dart:convert';

import 'package:customerapp/core/constants.dart';
import 'package:customerapp/core/errors/custom_error.dart';
import 'package:customerapp/core/repositories/core_repository.dart';
import 'package:customerapp/core/results/result.dart';
import 'package:customerapp/core/models/empty_response_model.dart';
import 'package:customerapp/core/services/local_storage/local_storage_service.dart';
import 'package:customerapp/core/sqllite/sqlite_api.dart';
import 'package:customerapp/features/login/data/models/user.dart';
import 'package:customerapp/features/login/domain/repositories/user-repositories.dart';
import 'package:customerapp/core/services/http_service/http_service.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

// TODO: I comment this class , till the API is ready @Abeer
class LoginRepositoryImplementation implements UserRepository {
  final  httpCall = HttpService();

  @override
  Future<Result<RemoteResultModel<String>>> loginUser (UserModel userModel) async {
    LocalStorageService localStorage = LocalStorageService();
    print( userModel.toJson());
    var userData = {
      "Email": userModel.email,
      "Password": userModel.password
    };
    print(userData);
    // TODO: implement LoginUser
    final response = await CoreRepository.request(url: loginUrl, method: HttpMethod.POST, converter: null, data:userData);
    if (response.hasDataOnly) {
      print(response.data);
      final res = response.data;
      final _data = RemoteResultModel<String>.fromJson(res);
      if (_data.success) {
        localStorage.setDriverID(_data.data);
        userModel.id = _data.data;
        print(userModel.toJson());
        DBHelper.insert('cemex_user', userModel.toJson());
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
