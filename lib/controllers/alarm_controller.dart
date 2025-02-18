// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class AlarmController {
//   static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   static Future<void> initialize() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//     const InitializationSettings initializationSettings =
//     InitializationSettings(android: initializationSettingsAndroid);
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>()
//         ?.requestNotificationsPermission();
//
//     await AndroidAlarmManager.initialize();
//   }
//
//   static Future<void> setAlarms(List<TimeOfDay> alarmTimes) async {
//     for (int i = 0; i < alarmTimes.length; i++) {
//       await _setAlarm(alarmTimes[i], i);
//     }
//   }
//
//   static Future<void> _setAlarm(TimeOfDay time, int id) async {
//     await AndroidAlarmManager.cancel(id);
//
//     final now = DateTime.now();
//     var scheduledDate = DateTime(
//       now.year,
//       now.month,
//       now.day,
//       time.hour,
//       time.minute,
//     );
//
//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }
//
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('alarmTime_$id', scheduledDate.toIso8601String());
//
//     await AndroidAlarmManager.oneShotAt(
//       scheduledDate,
//       id,
//       alarmCallback,
//       exact: true,
//       wakeup: true,
//       rescheduleOnReboot: true,
//     );
//   }
//
//   static Future<void> cancelAllAlarms() async {
//     final prefs = await SharedPreferences.getInstance();
//     for (int i = 0; i < 3; i++) {
//       await AndroidAlarmManager.cancel(i);
//       await prefs.remove('alarmTime_$i');
//     }
//   }
//
//   @pragma('vm:entry-point')
//   static void alarmCallback() {
//     print("Alarm fired!");
//     _showNotification();
//   }
//
//   @pragma('vm:entry-point')
//   static Future<void> _showNotification() async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails(
//       'alarm_channel',
//       'Alarms',
//       channelDescription: 'Channel for alarm notifications',
//       importance: Importance.max,
//       priority: Priority.high,
//       sound: RawResourceAndroidNotificationSound('alarm_sound'),
//       playSound: true,
//       enableVibration: true,
//       enableLights: true,
//       fullScreenIntent: true,
//       category: AndroidNotificationCategory.alarm,
//     );
//
//     const NotificationDetails platformChannelSpecifics =
//     NotificationDetails(android: androidPlatformChannelSpecifics);
//
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'Reminder'.tr(),
//       'Time_to_take_your_medicine'.tr(),
//       platformChannelSpecifics,
//     );
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class AlarmController {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await AndroidAlarmManager.initialize();
  }

  static Future<void> setAlarms(List<TimeOfDay> alarmTimes) async {
    final prefs = await SharedPreferences.getInstance();

    await updateTranslatedStrings();

    await prefs.setStringList('alarmTimes',
        alarmTimes.map((time) => '${time.hour}:${time.minute}').toList()
    );

    for (int i = 0; i < alarmTimes.length; i++) {
      await _setAlarm(alarmTimes[i], i);
    }
  }

  static Future<void> _setAlarm(TimeOfDay time, int id) async {
    await AndroidAlarmManager.cancel(id);

    final now = DateTime.now();
    var scheduledDate = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await AndroidAlarmManager.oneShotAt(
      scheduledDate,
      id,
      alarmCallback,
      exact: true,
      wakeup: true,
      rescheduleOnReboot: true,
    );
  }

  static Future<void> cancelAllAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('alarmTimes');

    for (int i = 0; i < 3; i++) {
      await AndroidAlarmManager.cancel(i);
    }
  }

  static Future<List<TimeOfDay>> getSavedAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTimes = prefs.getStringList('alarmTimes') ?? [];
    return savedTimes.map((timeString) {
      final parts = timeString.split(':');
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    }).toList();
  }

  static Future<void> updateTranslatedStrings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('alarm_title', 'alarm_title'.tr());
    await prefs.setString('alarm_body', 'alarm_body'.tr());
  }

  @pragma('vm:entry-point')
  static void alarmCallback() {
    print("Alarm fired!");
    _showNotification();
  }

  @pragma('vm:entry-point')
  static Future<void> _showNotification() async {
    final prefs = await SharedPreferences.getInstance();

    // Retrieve translated strings
    final title = prefs.getString('alarm_title') ?? 'Reminder';
    final body = prefs.getString('alarm_body') ?? 'Time to take your medicine';
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'alarm_channel',
      'Alarms',
      channelDescription: 'Channel for alarm notifications',
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('alarm_sound'),
      playSound: true,
      enableVibration: true,
      enableLights: true,
      fullScreenIntent: true,
      category: AndroidNotificationCategory.alarm,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }
}

