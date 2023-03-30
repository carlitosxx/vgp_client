import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vgp_cliente/app/core/errors/http_request_failure.dart';
import 'package:vgp_cliente/app/domain/entities/login/login.entity.dart';
import 'package:vgp_cliente/app/domain/usecases/login.usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GetLoginUC _getLoginUC;
  LoginBloc(this._getLoginUC) : super(LoginInitialState()) {
    //! Login load event
    on<LoadLoginEvent>((event, emit) async {
      emit(LoginLoadingState());
      final login = await _getLoginUC(event.email, event.password);
      login.when(
          left: (failure) =>
              emit(LoginErrorState(mapFailureCustomToString(failure))),
          right: (login) => emit(LoginLoadedState(login)));
    });
  }
}

mapFailureCustomToString(HttpRequestFailure failure) {
  return failure.when(
      network: () => 'Hubo un problema de red',
      notFound: () => 'Correo/Clave incorrecta',
      server: () => 'Hubo un problema en el servidor',
      unauthorized: () => 'No estas autorizado',
      badRequest: () => 'La solicitud no puede ser procesado',
      local: () => 'Hubo un problema local o desconocido');
}
