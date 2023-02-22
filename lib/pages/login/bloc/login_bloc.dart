import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vgp_cliente/models/data_account.model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginInitial()) {
    on<LoginEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
