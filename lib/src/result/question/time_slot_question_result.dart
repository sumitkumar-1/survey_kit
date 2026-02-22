import 'package:survey_kit/src/steps/identifier/identifier.dart';
import 'package:survey_kit/src/result/question_result.dart';
import 'package:json_annotation/json_annotation.dart';

part 'time_slot_question_result.g.dart';

@JsonSerializable(explicitToJson: true)
class TimeSlotQuestionResult extends QuestionResult<List<String>?> {
  TimeSlotQuestionResult({
    required Identifier id,
    required DateTime startDate,
    required DateTime endDate,
    required String valueIdentifier,
    required List<String>? result,
  }) : super(
          id: id,
          startDate: startDate,
          endDate: endDate,
          valueIdentifier: valueIdentifier,
          result: result,
        );

  factory TimeSlotQuestionResult.fromJson(Map<String, dynamic> json) => _$TimeSlotQuestionResultFromJson(json);

  Map<String, dynamic> toJson() => _$TimeSlotQuestionResultToJson(this);

  @override
  List<Object?> get props => [id, startDate, endDate, valueIdentifier, result];
}
