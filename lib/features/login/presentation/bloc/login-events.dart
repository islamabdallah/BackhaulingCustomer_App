import 'package:customerapp/core/base_bloc/base_bloc.dart';
import 'package:customerapp/features/login/data/models/user.dart';

class LoginEvent extends BaseEvent {
  final UserModel userModel;
  LoginEvent({this.userModel});
}
