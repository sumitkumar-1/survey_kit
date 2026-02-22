// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_slot_answer_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeSlotAnswerFormat _$TimeSlotAnswerFormatFromJson(
        Map<String, dynamic> json) =>
    TimeSlotAnswerFormat(
      startTime: _$JsonConverterFromJson<Map<String, dynamic>, TimeOfDay?>(
          json['startTime'], const _TimeOfDayJsonConverter().fromJson),
      endTime: _$JsonConverterFromJson<Map<String, dynamic>, TimeOfDay?>(
          json['endTime'], const _TimeOfDayJsonConverter().fromJson),
      timeInterval: const _DurationJsonConverter()
          .fromJson((json['timeInterval'] as num?)?.toInt()),
    );

Map<String, dynamic> _$TimeSlotAnswerFormatToJson(
        TimeSlotAnswerFormat instance) =>
    <String, dynamic>{
      'startTime': const _TimeOfDayJsonConverter().toJson(instance.startTime),
      'endTime': const _TimeOfDayJsonConverter().toJson(instance.endTime),
      'timeInterval':
          const _DurationJsonConverter().toJson(instance.timeInterval),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);
