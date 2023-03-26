import 'package:vgp_cliente/app/domain/entities/progress-lesson.entity.dart';

class ProgressLessonModel extends ProgressLesson {
  ProgressLessonModel({
    required this.id,
    required this.greenGem,
    required this.yellowGem,
    required this.redGem,
    required this.chaos,
  }) : super(
            id: id,
            greenGem: greenGem,
            yellowGem: yellowGem,
            redGem: redGem,
            chaos: chaos);

  final String id;
  final bool greenGem;
  final bool yellowGem;
  final bool redGem;
  final bool chaos;

  ProgressLessonModel copyWith({
    String? id,
    bool? greenGem,
    bool? yellowGem,
    bool? redGem,
    bool? chaos,
  }) =>
      ProgressLessonModel(
        id: id ?? this.id,
        greenGem: greenGem ?? this.greenGem,
        yellowGem: yellowGem ?? this.yellowGem,
        redGem: redGem ?? this.redGem,
        chaos: chaos ?? this.chaos,
      );

  factory ProgressLessonModel.fromJson(Map<String, dynamic> json) =>
      ProgressLessonModel(
        id: json["id"],
        greenGem: json["green_gem"],
        yellowGem: json["yellow_gem"],
        redGem: json["red_gem"],
        chaos: json["chaos"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "green_gem": greenGem,
        "yellow_gem": yellowGem,
        "red_gem": redGem,
        "chaos": chaos,
      };
}
