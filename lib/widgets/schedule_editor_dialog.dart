import 'package:flutter/material.dart';


class MedicineSchedule {
  final TimeOfDay time;
  final bool isEnabled;

  MedicineSchedule({required this.time, this.isEnabled = true});
}

class ScheduleEditorDialog extends StatefulWidget {
  final String medicineName;
  final List<TimeOfDay>? initialTimes;

  const ScheduleEditorDialog({
    Key? key,
    required this.medicineName,
    this.initialTimes,
  }) : super(key: key);

  @override
  _ScheduleEditorDialogState createState() => _ScheduleEditorDialogState();
}

class _ScheduleEditorDialogState extends State<ScheduleEditorDialog> {
  late ValueNotifier<List<MedicineSchedule>> schedulesNotifier;

  @override
  void initState() {
    super.initState();
    schedulesNotifier = ValueNotifier(
      widget.initialTimes?.map((time) => MedicineSchedule(time: time)).toList() ??
          [
            MedicineSchedule(time: TimeOfDay(hour: 8, minute: 0)),
            MedicineSchedule(time: TimeOfDay(hour: 14, minute: 0)),
            MedicineSchedule(time: TimeOfDay(hour: 20, minute: 0)),
          ],
    );
  }

  Future<void> _selectTime(int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: schedulesNotifier.value[index].time,
    );

    if (picked != null) {
      schedulesNotifier.value = List.from(schedulesNotifier.value)
        ..[index] = MedicineSchedule(time: picked, isEnabled: schedulesNotifier.value[index].isEnabled);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Set Schedule for ${widget.medicineName}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ValueListenableBuilder<List<MedicineSchedule>>(
          valueListenable: schedulesNotifier,
          builder: (context, schedules, _) {
            return Column(
              children: [
                ...List.generate(schedules.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        Switch(
                          value: schedules[index].isEnabled,
                          onChanged: (value) {
                            schedulesNotifier.value = List.from(schedules)
                              ..[index] = MedicineSchedule(
                                time: schedules[index].time,
                                isEnabled: value,
                              );
                          },
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => _selectTime(index),
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Time ${index + 1}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Text(
                                    schedules[index].time.format(context),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel'),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text('Save'),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}