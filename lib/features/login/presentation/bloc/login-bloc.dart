import 'package:customerapp/core/errors/custom_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customerapp/core/base_bloc/base_bloc.dart';
import 'package:customerapp/core/constants.dart';
import 'package:customerapp/core/services/local_storage/local_storage_service.dart';
import 'package:customerapp/features/login/data/repositories/user-repositories-implementation.dart';
import 'package:customerapp/features/login/presentation/bloc/login-events.dart';
import 'package:customerapp/features/login/presentation/bloc/login-state.dart';

class LoginBloc extends Bloc<BaseEvent, BaseLoginState> {
  LoginBloc(BaseLoginState initialState) : super(initialState);

  @override
  Stream<BaseLoginState> mapEventToState(BaseEvent event) async* {
    // TODO: implement mapEventToState
    LoginRepositoryImplementation repo = new LoginRepositoryImplementation();
    LocalStorageService localStorage = LocalStorageService();

    if (event is LoginEvent) {
      yield LoginLoadingState();
      final res = await repo.loginUser(event.userModel);
      if (res.hasErrorOnly) {
        final CustomError error = res.error;
        yield LoginFailedState(error);
      } else {
        /// Save Current Trip Data

        yield LoginSuccessState();
      }
    }
  }
}
