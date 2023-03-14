import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pay_event.dart';
part 'pay_state.dart';

class PayBloc extends Bloc<PayEvent, PayState> {
  PayBloc() : super(const PayInitial()) {
    on<OnChangedNumberCardEvent>((event, emit) {
      emit(PaySetNumberCardState(newNumberCard: event.numberCard));
    });
  }
}
