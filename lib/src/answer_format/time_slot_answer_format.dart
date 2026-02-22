import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/answer_format/answer_format.dart';

part 'time_slot_answer_format.g.dart';

@JsonSerializable()
class TimeSlotAnswerFormat extends AnswerFormat {
  @_TimeOfDayJsonConverter()
  final TimeOfDay? startTime;

  @_TimeOfDayJsonConverter()
  final TimeOfDay? endTime;

  @_DurationJsonConverter()
  final Duration? timeInterval;

  TimeSlotAnswerFormat({
    required this.startTime,
    required this.endTime,
    required this.timeInterval,
  }) : super();

  factory TimeSlotAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotAnswerFormatFromJson(json);

  Map<String, dynamic> toJson() => _$TimeSlotAnswerFormatToJson(this);
}

class _TimeOfDayJsonConverter
    implements JsonConverter<TimeOfDay?, Map<String, dynamic>> {
  const _TimeOfDayJsonConverter();

  @override
  TimeOfDay? fromJson(Map<String, dynamic> json) {
    if (json['hour'] == null || json['minute'] == null) {
      return null;
    }
    return TimeOfDay(
      hour: json['hour'] as int,
      minute: json['minute'] as int,
    );
  }

  @override
  Map<String, dynamic> toJson(TimeOfDay? timeOfDay) => <String, dynamic>{
        'hour': timeOfDay?.hour,
        'minute': timeOfDay?.minute,
      };
}

class _DurationJsonConverter implements JsonConverter<Duration?, int?> {
  const _DurationJsonConverter();

  @override
  Duration? fromJson(int? minutes) {
    return minutes != null ? Duration(minutes: minutes) : null;
  }

  @override
  int? toJson(Duration? duration) {
    return duration?.inMinutes;
  }
}
