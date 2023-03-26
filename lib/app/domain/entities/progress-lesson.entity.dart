import 'package:equatable/equatable.dart';

class ProgressLesson extends Equatable {
  ProgressLesson({
    required this.id,
    required this.greenGem,
    required this.yellowGem,
    required this.redGem,
    required this.chaos,
  });

  final String id;
  final bool greenGem;
  final bool yellowGem;
  final bool redGem;
  final bool chaos;

  @override
  List<Object?> get props => [id, greenGem, yellowGem, redGem, chaos];
}
