part of 'pay_bloc.dart';

abstract class PayState extends Equatable {
  const PayState({
    this.numberCard,
    this.expireDate,
    this.cvv,
    this.name,
  });
  final String? numberCard;
  final String? expireDate;
  final String? cvv;
  final String? name;

  @override
  List<Object> get props => [];
}

//todo: initial state
class PayInitial extends PayState {
  const PayInitial()
      : super(
          expireDate: '',
          numberCard: '0000 0000 0000 0000',
          cvv: '',
          name: '',
        );
}

class PaySetNumberCardState extends PayState {
  final String newNumberCard;
  const PaySetNumberCardState({required this.newNumberCard})
      : super(numberCard: newNumberCard);
}
