import 'package:customerapp/core/results/result.dart';


abstract class LocationListRepository {
  Future<Result<dynamic>> getLocationListData();
}
