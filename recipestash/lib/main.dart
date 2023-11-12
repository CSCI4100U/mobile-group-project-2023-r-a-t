import 'dart:convert';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recipestash/classes/preferences.dart';
import 'package:recipestash/classes/preferences_model.dart';
import 'package:recipestash/utilities/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:recipestash/widget_tree.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

//global preferences variable
Preferences preferences = Preferences(
  r: 255,
  g: 255,
  b: 255,
  darkMode: 0,
  notifications: 1
);

Future<String> getRandomTip() async {
  Uri url = Uri.parse("https://my-json-server.typicode.com/MdTanjeemHaider/randomCookingTips/db");
  final response = await http.get(url);

  if (response.statusCode == 200){
    List<String> tips = List<String>.from(json.decode(response.body)["tips"]);
    return tips[Random().nextInt(tips.length)];
  }
  else {
    throw Exception("Failed to load tip");
  }
}

Future<void> dailyNotifications() async {
  // Requsting notification permissions
  if (await Permission.notification.status.isDenied)
  {
    PermissionStatus permissionStatus = await Permission.notification.request();
    if (permissionStatus.isDenied) {
      preferences.notifications = 0;
      await PreferencesModel().update(preferences);
      return;
    }
  }

  // Setting up notifications
  AndroidInitializationSettings androidInitialize = const AndroidInitializationSettings('mipmap/launcher_icon');
  InitializationSettings initializationSettings = InitializationSettings(android: androidInitialize);
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  AndroidNotificationDetails androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    'daily_channel',
    'Daily Cooking Tip',
    importance: Importance.max,
    priority: Priority.high,);
  NotificationDetails notificationDetails = NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show( // keep this as show instead of periodic for testing purposes, change in final version
    0,
    'Daily Cooking Tip',
    await getRandomTip(),
    // RepeatInterval.daily,
    notificationDetails,
    // androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive); // goes into fullscreen mode for the app and removes status bar + nav buttons
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // If preferences already exist get them, otherwise create them using the default values
  PreferencesModel prefModel = PreferencesModel();
  if (await prefModel.exists() == 0) {
    prefModel.create(preferences);
  }
  else {
    preferences = await PreferencesModel().get();
  }

  // Daily notifications
  if (preferences.notifications == 1) {
    await dailyNotifications();
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text("Error: ${snapshot.error}")
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return const MaterialApp(
            home: WidgetTree()
          );
        }
        else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}