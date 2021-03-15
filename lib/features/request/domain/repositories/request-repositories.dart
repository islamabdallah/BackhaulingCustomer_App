import 'package:customerapp/core/models/empty_response_model.dart';
import 'package:customerapp/core/results/result.dart';
import 'package:customerapp/features/login/data/models/user.dart';
import 'package:customerapp/features/request/data/models/request.dart';
// TODO: I comment this class , till the API is ready @Abeer

abstract class RequestRepository {
  Future<Result<dynamic>> getRequestData();
  Future<Result<RemoteResultModel<String>>> saveRequestData(RequestModel requestData);
}
