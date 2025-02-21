//
// import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:untitled_med/controllers/alarm_controller.dart';
//
// import '../../constant/colors.dart';
//
//
// class MedicineSchedule {
//   final TimeOfDay time;
//   final bool isEnabled;
//
//   MedicineSchedule({required this.time, this.isEnabled = true});
// }
//
// class ScheduleEditorDialog extends StatefulWidget {
//   final String medicineName;
//   final List<TimeOfDay>? initialTimes;
//
//   const ScheduleEditorDialog({
//     Key? key,
//     required this.medicineName,
//     this.initialTimes,
//   }) : super(key: key);
//
//   @override
//   _ScheduleEditorDialogState createState() => _ScheduleEditorDialogState();
// }
//
// class _ScheduleEditorDialogState extends State<ScheduleEditorDialog> {
//   late ValueNotifier<List<MedicineSchedule>> schedulesNotifier;
//
//   @override
//   void initState() {
//     super.initState();
//     schedulesNotifier = ValueNotifier(
//       widget.initialTimes?.map((time) => MedicineSchedule(time: time)).toList() ??
//           [
//             MedicineSchedule(time: TimeOfDay(hour: 8, minute: 0)),
//             MedicineSchedule(time: TimeOfDay(hour: 14, minute: 0)),
//             MedicineSchedule(time: TimeOfDay(hour: 20, minute: 0)),
//           ],
//     );
//   }
//
//   Future<void> _selectTime(int index) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: schedulesNotifier.value[index].time,
//     );
//
//     if (picked != null) {
//       schedulesNotifier.value = List.from(schedulesNotifier.value)
//         ..[index] = MedicineSchedule(time: picked, isEnabled: schedulesNotifier.value[index].isEnabled);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               'set_schedule_for'.tr(args: [widget.medicineName]),
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textColor,
//               ),
//             ),
//             SizedBox(height: 20),
//             ValueListenableBuilder<List<MedicineSchedule>>(
//               valueListenable: schedulesNotifier,
//               builder: (context, schedules, _) {
//                 return Column(
//                   children: [
//                     ...List.generate(schedules.length, (index) {
//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 16),
//                         child: Row(
//                           children: [
//                             Switch(
//                               value: schedules[index].isEnabled,
//                               onChanged: (value) {
//                                 schedulesNotifier.value = List.from(schedules)
//                                   ..[index] = MedicineSchedule(
//                                     time: schedules[index].time,
//                                     isEnabled: value,
//                                   );
//                               },
//                               activeColor: AppColors.primaryColor,
//                             ),
//                             Expanded(
//                               child: InkWell(
//                                 onTap: () => _selectTime(index),
//                                 child: Container(
//                                   padding: EdgeInsets.all(12),
//                                   decoration: BoxDecoration(
//                                     border: Border.all(color: AppColors.borderColor),
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         'time_n'.tr(args: [(index + 1).toString()]),
//                                         style: TextStyle(
//                                           color: AppColors.subtitleColor,
//                                         ),
//                                       ),
//                                       Text(
//                                         schedules[index].time.format(context),
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: AppColors.textColor,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     }),
//                     SizedBox(height: 20),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: TextButton(
//                             onPressed: () => Navigator.pop(context),
//                             child: Text(
//                               'cancel'.tr(),
//                               style: TextStyle(color: AppColors.textColor),
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 16),
//                         Expanded(
//                           child: ElevatedButton(
//                             onPressed: () async {
//                               final enabledSchedules = schedulesNotifier.value
//                                   .where((schedule) => schedule.isEnabled)
//                                   .map((schedule) => schedule.time)
//                                   .toList();
//
//                               await AlarmController.cancelAllAlarms();
//                               await AlarmController.setAlarms(enabledSchedules);
//
//                               Navigator.pop(context, schedulesNotifier.value);
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppColors.primaryColor,
//                               padding: EdgeInsets.symmetric(vertical: 12),
//                             ),
//                             child: Text(
//                               'save'.tr(),
//                               style: TextStyle(color: AppColors.textColor),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:untitled_med/controllers/alarm_controller.dart';
import '../../constant/colors.dart';


class MedicineSchedule {
  final TimeOfDay time;
  final bool isEnabled;

  MedicineSchedule({required this.time, this.isEnabled = true});
}

class ScheduleEditorDialog extends StatefulWidget {
  final String medicineName;

  const ScheduleEditorDialog({
    Key? key,
    required this.medicineName,
  }) : super(key: key);

  @override
  _ScheduleEditorDialogState createState() => _ScheduleEditorDialogState();
}

class _ScheduleEditorDialogState extends State<ScheduleEditorDialog> {
  late ValueNotifier<List<MedicineSchedule>> schedulesNotifier;

  @override
  void initState() {
    super.initState();
    _loadSavedAlarms();
  }

  Future<void> _loadSavedAlarms() async {
    final savedAlarms = await AlarmController.getSavedAlarms();
    if (savedAlarms.isNotEmpty) {
      schedulesNotifier = ValueNotifier(
        savedAlarms.map((time) => MedicineSchedule(time: time)).toList(),
      );
    } else {
      schedulesNotifier = ValueNotifier([
        MedicineSchedule(time: TimeOfDay(hour: 8, minute: 0)),
        MedicineSchedule(time: TimeOfDay(hour: 14, minute: 0)),
        MedicineSchedule(time: TimeOfDay(hour: 20, minute: 0)),
      ]);
    }
    setState(() {});
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
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'set_schedule_for'.tr(args: [widget.medicineName]),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: 20),
            ValueListenableBuilder<List<MedicineSchedule>>(
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
                              activeColor: AppColors.primaryColor,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () => _selectTime(index),
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.borderColor),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'time_n'.tr(args: [(index + 1).toString()]),
                                        style: TextStyle(
                                          color: AppColors.subtitleColor,
                                        ),
                                      ),
                                      Text(
                                        schedules[index].time.format(context),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textColor,
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
                            child: Text(
                              'cancel'.tr(),
                              style: TextStyle(color: AppColors.textColor),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              final enabledSchedules = schedulesNotifier.value
                                  .where((schedule) => schedule.isEnabled)
                                  .map((schedule) => schedule.time)
                                  .toList();

                              await AlarmController.getSavedAlarms();
                              await AlarmController.cancelAllAlarms();
                              await AlarmController.setAlarms(enabledSchedules);


                              Navigator.pop(context, schedulesNotifier.value);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(
                              'save'.tr(),
                              style: TextStyle(color: AppColors.textColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


