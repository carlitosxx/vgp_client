part of 'pay_bloc.dart';

abstract class PayEvent extends Equatable {
  const PayEvent();

  @override
  List<Object> get props => [];
}

class OnChangedNumberCardEvent extends PayEvent {
  const OnChangedNumberCardEvent({
    required this.numberCard,
  });
  final String numberCard;
}
