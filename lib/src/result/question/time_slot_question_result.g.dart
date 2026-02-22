// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_slot_question_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeSlotQuestionResult _$TimeSlotQuestionResultFromJson(
        Map<String, dynamic> json) =>
    TimeSlotQuestionResult(
      id: Identifier.fromJson(json['id'] as Map<String, dynamic>),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      valueIdentifier: json['valueIdentifier'] as String,
      result:
          (json['result'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$TimeSlotQuestionResultToJson(
        TimeSlotQuestionResult instance) =>
    <String, dynamic>{
      'id': instance.id?.toJson(),
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'result': instance.result,
      'valueIdentifier': instance.valueIdentifier,
    };
