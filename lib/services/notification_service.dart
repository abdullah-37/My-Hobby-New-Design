import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final firebaseMessanger = FirebaseMessaging.instance;

  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    // const IOSInitializationSettings initializationSettingsIOS =);

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    await requestPermissions();

    await firebaseMessanger.getToken().then((value) {
      Get.log("Firebase Token: $value");
    });
    firebaseMessanger.onTokenRefresh.listen((newToken) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var jsonString = await prefs.clear();
      if (jsonString == true) {
        // Get.offAll(() => const AuthScreen());
      }
      // print("New Token: $newToken");
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // print('Got a message whilst in the foreground!');
      // print('Message data: ${message.data}');

      if (message.notification != null) {
        showNotification(
          id: 1,
          title: "${message.notification!.title}",
          body: "${message.notification!.body}",
        );
        // print('Message also contained a notification: ${message.notification}');
      }
    });
  }
  // c4t0E0XSTKa9hyG6OoWSfC:APA91bEkBz3aWErnQfpdquszOb2l5nxdGIMYzzZlLRuZMFdFaL55rNWOLmknOFwZjV9dYKd6Fv6xmLLHa-UXeQPapBQFoWCvrWkdg2BUATuTNHSc-myE8vQ

  /// Requests notification permissions for iOS and Android (Android 13+).
  Future<bool> requestPermissions() async {
    bool permissionGranted = true;

    if (Platform.isIOS) {
      // For iOS, request permissions for alerts, sounds, and badges.
      final IOSFlutterLocalNotificationsPlugin? iosImplementation =
          flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin
              >();

      permissionGranted =
          await iosImplementation?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          ) ??
          false;
    } else if (Platform.isAndroid) {
      // For Android 13+, explicitly ask for notification permission.
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();

      permissionGranted =
          await androidImplementation?.requestNotificationsPermission() ??
          false;
    }
    return permissionGranted;
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'your_channel_id', // id
          'your_channel_name', // name
          channelDescription: 'your_channel_description',
          importance: Importance.max,
          priority: Priority.high,
          icon: '@drawable/launcher_icon',
        );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
    );
  }
}
