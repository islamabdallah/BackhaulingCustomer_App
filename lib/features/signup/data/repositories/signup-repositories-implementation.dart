import 'dart:convert';

import 'package:customerapp/core/constants.dart';
import 'package:customerapp/core/errors/custom_error.dart';
import 'package:customerapp/core/repositories/core_repository.dart';
import 'package:customerapp/core/results/result.dart';
import 'package:customerapp/core/models/empty_response_model.dart';
import 'package:customerapp/core/services/http_service/http_service.dart';
import 'package:customerapp/features/request/data/models/dropDown-data.dart';
import 'package:customerapp/features/signup/data/models/registerData.dart';
import 'package:customerapp/features/signup/domain/repositories/signup-repositories.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

// TODO: I comment this class , till the API is ready @azhar
class SignUpRepositoryImplementation implements SignUpRepository {
  final  httpCall = HttpService();

  @override
  Future<Result<RemoteResultModel<String>>> signUpUser (RegisterModel registerModel) async {
    print( registerModel.toJson());
     var finalT = registerModel.toJson();
     print(finalT);

    final response = await CoreRepository.request(url: registerUrl, method: HttpMethod.POST, converter: null, data:finalT);
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
      final msg =  translator.currentLanguage == 'en' ? response.error.toString() : 'يوجد خطأ برجاء المحاوله مره ثانيه';
      return Result(error: CustomError(message: msg));
    //  return Result(error: response.error);
    }
   // return Result(data: EmptyResultModel());

  }

  @override
  Future<Result<dynamic>> getIndustryData () async {
    final response = await CoreRepository.request(url: registerUrl, method: HttpMethod.GET, converter: null,);
    if (response.hasDataOnly) {
      print(response.data);
      final res = response.data;
      var newData =  List<DropDownDataModel>.from(res["industries"].map((x) => DropDownDataModel.fromJson(x)));
      print(newData);
      return Result(data: newData);
    }
    if (response.hasErrorOnly) {
      return Result(error: response.error);
    }
  }


}
