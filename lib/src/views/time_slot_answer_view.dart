import 'package:flutter/material.dart';
import 'package:survey_kit/src/answer_format/time_slot_answer_format.dart';
import 'package:survey_kit/src/result/question/time_slot_question_result.dart';
import 'package:survey_kit/src/steps/predefined_steps/question_step.dart';
import 'package:survey_kit/src/views/widget/step_view.dart';
import 'package:intl/intl.dart';

class TimeSlot {
  final String time;
  bool isSelected;

  TimeSlot(this.time, {this.isSelected = false});
}

class TimeSlotAnswerView extends StatefulWidget {
  final QuestionStep questionStep;
  final TimeSlotQuestionResult? result;

  const TimeSlotAnswerView({
    super.key,
    required this.questionStep,
    required this.result,
  });

  @override
  State<TimeSlotAnswerView> createState() => _TimeSlotAnswerViewState();
}

class _TimeSlotAnswerViewState extends State<TimeSlotAnswerView> {
  late final TimeSlotAnswerFormat _timeSlotAnswerFormat;
  late final DateTime _startDate;
  late final Map<String, List<TimeSlot>> groupedSlots;
  final Map<String, bool> expandedSections = {}; // Track expanded sections

  @override
  void initState() {
    super.initState();
    _timeSlotAnswerFormat =
        widget.questionStep.answerFormat as TimeSlotAnswerFormat;
    _startDate = DateTime.now();
    groupedSlots = generateGroupedSlots(
      _timeSlotAnswerFormat.startTime!,
      _timeSlotAnswerFormat.endTime!,
      _timeSlotAnswerFormat.timeInterval!,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Map<String, List<TimeSlot>> generateGroupedSlots(TimeOfDay startTime, TimeOfDay endTime, Duration duration) {
    Map<String, List<TimeSlot>> groupedSlots = {};

    DateFormat timeFormat = DateFormat.jm();
    DateTime startDateTime = DateTime(2022, 1, 1, startTime.hour, startTime.minute);
    DateTime endDateTime = DateTime(2022, 1, 1, endTime.hour, endTime.minute);

    String currentPart = 'Morning';

    while (startDateTime.isBefore(endDateTime)) {
      DateTime endSlotTime = startDateTime.add(duration);

      if (startDateTime.hour < 12) {
        currentPart = 'Morning';
      } else if (startDateTime.hour < 17) {
        currentPart = 'Afternoon';
      } else {
        currentPart = 'Evening';
      }

      if (!groupedSlots.containsKey(currentPart)) {
        groupedSlots[currentPart] = [];
      }
      groupedSlots[currentPart]!.add(TimeSlot("${timeFormat.format(startDateTime)} - ${timeFormat.format(endSlotTime)}"));

      startDateTime = endSlotTime;
    }
    return groupedSlots;
  }

  void toggleSection(String section) {
    setState(() {
      expandedSections[section] = !(expandedSections[section] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StepView(
      step: widget.questionStep,
      resultFunction: () {
        // Collect selected time slots
        List<String> selectedSlots = groupedSlots.entries
            .expand((entry) => entry.value
                .where((slot) => slot.isSelected)
                .map((slot) => slot.time))
            .toList();

        return TimeSlotQuestionResult(
          id: widget.questionStep.stepIdentifier,
          startDate: _startDate,
          endDate: DateTime.now(),
          valueIdentifier: selectedSlots.join(', '),
          result: selectedSlots.isNotEmpty ? selectedSlots : null,
        );
      },
      isValid: true, // Add any necessary validation
      title: widget.questionStep.title.isNotEmpty
          ? Text(
              widget.questionStep.title,
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,
            )
          : widget.questionStep.content,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: groupedSlots.keys.map((section) {
            return Column(
              children: [
                ListTile(
                  title: Text(section),
                  onTap: () => toggleSection(section),
                  trailing: Icon(
                    expandedSections[section] ?? false
                        ? Icons.expand_less
                        : Icons.expand_more,
                  ),
                ),
                if (expandedSections[section] ?? false)
                  ...groupedSlots[section]!.map((slot) {
                    return CheckboxListTile(
                      title: Text(slot.time),
                      value: slot.isSelected,
                      onChanged: (value) {
                        setState(() {
                          slot.isSelected = value ?? false;
                        });
                      },
                    );
                  }).toList(),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
