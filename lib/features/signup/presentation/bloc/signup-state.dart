import 'package:customerapp/core/errors/custom_error.dart';

class BaseSignUpState {}

class  SignUpSuccessState extends BaseSignUpState {
   SignUpSuccessState();
}

class  SignUpLoadingState extends BaseSignUpState {}

class  SignUpFailedState extends BaseSignUpState {
  final CustomError error;
   SignUpFailedState(this.error);
}