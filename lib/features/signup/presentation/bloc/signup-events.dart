import 'package:customerapp/core/base_bloc/base_bloc.dart';
import 'package:customerapp/features/login/data/models/user.dart';

class  SignUpEvent extends BaseEvent {
  final UserModel userModel;
  SignUpEvent({this.userModel});
}
