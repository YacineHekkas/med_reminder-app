import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled_med/view/HomeScreen.dart';

import 'constant/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
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

  final prefs = await SharedPreferences.getInstance();
  String savedLocale = prefs.getString('locale') ?? 'fr';

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('fr'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('fr'),
      startLocale: Locale(savedLocale),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        fontFamily: 'SF Pro Display',
        primaryColor: AppColors.primaryColor,
      ),
      home: MedicineTrackerScreen(),
    );
  }
}


