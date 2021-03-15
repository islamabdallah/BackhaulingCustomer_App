import 'dart:convert';
import 'package:customerapp/core/constants.dart';
import 'package:customerapp/core/errors/custom_error.dart';
import 'package:customerapp/core/repositories/core_repository.dart';
import 'package:customerapp/core/results/result.dart';
import 'package:customerapp/core/models/empty_response_model.dart';
import 'package:customerapp/core/sqllite/sqlite_api.dart';
import 'package:customerapp/features/location/data/models/location-info.dart';
import 'package:customerapp/features/location/data/models/location-request.dart';
import 'package:customerapp/features/location/domain/repositories/add-location-repositories.dart';
import 'package:customerapp/features/login/data/models/user.dart';
import 'package:customerapp/core/services/http_service/http_service.dart';

// TODO: I comment this class , till the API is ready @Azhar
class AddLocationRepositoryImplementation implements AddLocationRepository {
  final  httpCall = HttpService();

  @override
  Future<Result<dynamic>> getLocationRequestData () async {
    var dataDB =  await DBHelper.getData('cemex_user');
    final userModel = UserModel.fromJson(dataDB[0]);
    var clientId = userModel.id;

    final response = await CoreRepository.request(url: getRequest+'/'+clientId, method: HttpMethod.GET, converter: null,);
    if (response.hasDataOnly) {
      print(response.data);
      final res = response.data;
//      final _data = RemoteResultModel<String>.fromJson(res);
//      if (_data.success) {
//      LocationInfoModel newData=  LocationInfoModel.fromJson(res);
//        return Result(data: newData);
//    }
//    if (response.hasErrorOnly) {
//      return Result(error: response.error);
//    }
      var testData = {
        "gov": [
          {
            "id": 1,
            "nameEN": "Trailer",
            "nameAR": "مقطوره",
            "active": true
          },
          {
            "id": 2,
            "nameEN": "Double Vehicle",
            "nameAR": "مركبة مزدوجة",
            "active": true
          }
        ],
        "cities": [
          {
            "id": 1,
            "nameEN": "Shipment",
            "nameAR": "شحنه",
            "active": true
          },
          {
            "id": 2,
            "nameEN": "Unit",
            "nameAR": "وحده",
            "active": true
          },
          {
            "id": 1,
            "nameEN": "UnitA",
            "nameAR": "وحده أ",
            "active": true
          },
          {
            "id": 2,
            "nameEN": "UnitB",
            "nameAR": "وحده ب",
            "active": true
          }
        ]
      };
      LocationInfoModel newData = LocationInfoModel.fromJson(testData);
      return Result(data: newData);
    }
  }

  @override
  Future<Result<RemoteResultModel<String>>> saveLocationData(LocationRequestModel requestData) async {
    print (requestData);
    var dataDB =  await DBHelper.getData('cemex_user');
    final userModel = UserModel.fromJson(dataDB[0]);
    var clientId = userModel.id;
    requestData.userId = clientId;
    // TODO: implement registerTruckNumber
    final response = await CoreRepository.request(url: saveRequest,method: HttpMethod.POST, converter: null, data: requestData.toJson());
    if(response.hasDataOnly) {
      print(response.data);
      final res = response.data;
      final _data = RemoteResultModel<String>.fromJson(res);
      if(_data.success) {
        return Result(data: _data);
      } else {
        return Result(error: CustomError(message:_data.msgEN ));
      }
    }
    if(response.hasErrorOnly) {
      return Result(error: response.error);
    }
  }
}
