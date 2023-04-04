import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vgp_cliente/app/core/utils/map-failure-to-string.util.dart';
import 'package:vgp_cliente/app/domain/entities/register/register.entity.dart';
import 'package:vgp_cliente/app/domain/usecases/register.usecase.dart';

part 'register_event.dart';
part 'register_state.dart';
part 'register_bloc.freezed.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final GetRegisterUC _getRegisterUC;
  RegisterBloc(this._getRegisterUC) : super(const RegisterState.initial()) {
    on<RegisterLoad>((event, emit) async {
      emit(const RegisterState.loading());
      final register = await _getRegisterUC(
          event.firstName, event.lastName, event.email, event.password);
      register.when(
          left: (failure) =>
              emit(RegisterState.error(mapFailureToString(failure))),
          right: (register) => emit(RegisterState.loaded(register)));
    });
  }
}
