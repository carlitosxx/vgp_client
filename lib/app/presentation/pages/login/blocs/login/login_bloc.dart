import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:vgp_cliente/app/core/errors/http_request_failure.dart';
import 'package:vgp_cliente/app/core/utils/map-failure-to-string.util.dart';
import 'package:vgp_cliente/app/domain/entities/login/login.entity.dart';
import 'package:vgp_cliente/app/domain/usecases/login.usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GetLoginUC _getLoginUC;
  LoginBloc(this._getLoginUC) : super(LoginInitialState()) {
    //! load event
    on<LoadLoginEvent>((event, emit) async {
      emit(LoginLoadingState());
      final login = await _getLoginUC(event.email, event.password);
      login.when(
          left: (failure) => emit(LoginErrorState(mapFailureToString(failure))),
          right: (login) => emit(LoginLoadedState(login)));
    });
    on<SetLoginInitialEvent>((event, emit) {
      emit(LoginInitialState());
    });
  }
}
