import 'dart:convert';
import 'package:customerapp/core/constants.dart';
import 'package:customerapp/core/errors/custom_error.dart';
import 'package:customerapp/core/repositories/core_repository.dart';
import 'package:customerapp/core/results/result.dart';
import 'package:customerapp/core/models/empty_response_model.dart';
import 'package:customerapp/core/sqllite/sqlite_api.dart';
import 'package:customerapp/features/location/data/models/area-data.dart';
import 'package:customerapp/features/location/data/models/location-info.dart';
import 'package:customerapp/features/location/data/models/location-request.dart';
import 'package:customerapp/features/location/domain/repositories/add-location-repositories.dart';
import 'package:customerapp/features/login/data/models/user.dart';
import 'package:customerapp/core/services/http_service/http_service.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

// TODO: I comment this class , till the API is ready @Azhar
class AddLocationRepositoryImplementation implements AddLocationRepository {
  final  httpCall = HttpService();

  @override
  Future<Result<dynamic>> getLocationRequestData () async {
    var dataDB =  await DBHelper.getData('cemex_user');
    final userModel = UserModel.fromSqlJson(dataDB[0]);
    var clientId = userModel.id;

    final response = await CoreRepository.request(url: newLocation, method: HttpMethod.GET, converter: null,);
    if (response.hasDataOnly) {
      print(response.data);
      final res = response.data;
//      final _data = RemoteResultModel<String>.fromJson(res);
//      if (_data.success) {
//      AreaDataModel newData=  AreaDataModel.fromJson(res);
      LocationInfoModel newData=  LocationInfoModel.fromJson(res);
        return Result(data: newData);
    }
    if (response.hasErrorOnly) {
      return Result(error: response.error);
    }
  }

  @override
  Future<Result<RemoteResultModel<String>>> saveLocationData(LocationRequestModel requestData) async {
    print (requestData);
    var dataDB =  await DBHelper.getData('cemex_user');
    final userModel = UserModel.fromSqlJson(dataDB[0]);
    var clientId = userModel.id;
    requestData.userId = clientId;
    // TODO: implement registerTruckNumber
    var finalLocation = requestData.toJson();
    print(finalLocation);
    final response = await CoreRepository.request(url: newLocation,method: HttpMethod.POST, converter: null, data: finalLocation);
    if(response.hasDataOnly) {
      print(response.data);
      final res = response.data;
      final _data = RemoteResultModel<String>.fromJson(res);
      if(_data.success) {
        return Result(data: _data);
      }  else {
        final msg =  translator.currentLanguage == 'en' ?_data.msgEN :_data.msgAR;
        return Result(error: CustomError(message: msg));
      }
    }
    if (response.hasErrorOnly) {
    final msg =  translator.currentLanguage == 'en' ? response.error.toString() : '???????? ?????? ?????????? ???????????????? ?????? ??????????';
    return Result(error: CustomError(message: msg));
    }
  }
}
