import 'package:customerapp/features/request/data/models/request.dart';

class BaseRequestEvent{}

class GetRequestFormDataEvent extends BaseRequestEvent{}

class SaveRequestEvent extends BaseRequestEvent {
  final RequestModel requestModel;
  SaveRequestEvent(this.requestModel);
}