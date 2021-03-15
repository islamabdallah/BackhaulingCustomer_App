import 'package:customerapp/core/errors/custom_error.dart';
import 'package:customerapp/features/signup/data/repositories/signup-repositories-implementation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customerapp/core/base_bloc/base_bloc.dart';
import 'signup-events.dart';
import 'signup-state.dart';


class SignUpBloc extends Bloc<BaseEvent, BaseSignUpState> {
  SignUpBloc(BaseSignUpState initialState) : super(initialState);

  @override
  Stream<BaseSignUpState> mapEventToState(BaseEvent event) async* {
    // TODO: implement mapEventToState
    SignUpRepositoryImplementation repo = new  SignUpRepositoryImplementation();

    if (event is  SignUpEvent) {
      yield  SignUpLoadingState();
      final res = await repo.signUpUser(event.userModel);
      if (res.hasErrorOnly) {
        final CustomError error = res.error;
        yield  SignUpFailedState(error);
      } else {
        yield  SignUpSuccessState();
      }
    }
  }
}
