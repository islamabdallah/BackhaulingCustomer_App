import 'package:customerapp/core/errors/base_error.dart';
import 'package:customerapp/features/request/data/models/request.dart';

class BaseLocationState {}

class LocationSuccessState extends BaseLocationState {
  dynamic requestFormData;
  LocationSuccessState({this.requestFormData});
}

class LocationLoadingState extends BaseLocationState {}

class LocationInitLoading extends BaseLocationState {}

class LocationFailedState extends BaseLocationState {
  final BaseError error;
  LocationFailedState(this.error);
}

class LocationSaveState extends BaseLocationState {}
