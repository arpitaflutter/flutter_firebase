import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:http/http.dart' as http;

class NotificationService {
  static NotificationService notificationService = NotificationService._();

  NotificationService._();

  FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings AndroidSettings =
    AndroidInitializationSettings('bell');

    DarwinInitializationSettings iOSSettings = DarwinInitializationSettings();

    InitializationSettings initializationSettings =
    InitializationSettings(android: AndroidSettings, iOS: iOSSettings);

    tz.initializeTimeZones();

    await notificationsPlugin.initialize(initializationSettings);
  }

  void showNotification() {
    AndroidNotificationDetails AndroidDetails =
    AndroidNotificationDetails("1", "Solanki Arpita");

    DarwinNotificationDetails iOSDetails = DarwinNotificationDetails();

    NotificationDetails details =
    NotificationDetails(iOS: iOSDetails, android: AndroidDetails);

    notificationsPlugin.show(1, "Arpita solanki", "5 seconds", details);
  }

  void scheduleNotification() {
    AndroidNotificationDetails AndroidDetails =
    AndroidNotificationDetails("1", "Solanki Arpita");

    DarwinNotificationDetails iOSDetails = DarwinNotificationDetails();

    NotificationDetails details =
    NotificationDetails(iOS: iOSDetails, android: AndroidDetails);

    notificationsPlugin.zonedSchedule(1, "Solanki Arpita", "5 seconds",
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 3)), details,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }

  void soundNotification() {
    AndroidNotificationDetails AndroidDetails = AndroidNotificationDetails(
        "1", "Solanki Arpita",
        sound: RawResourceAndroidNotificationSound('alert'));

    DarwinNotificationDetails iOSDetails = DarwinNotificationDetails();

    NotificationDetails details =
    NotificationDetails(iOS: iOSDetails, android: AndroidDetails);

    notificationsPlugin.show(1, "Arpita solanki", "5 seconds", details);
  }

  Future<String> uriTobase64() async {
    String link =
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsoxuCSib--8bc3mVIG6YBLVidR0cvt5crJzJuyXev&s";

    var response = await http.get(Uri.parse(link));
    String bs64 = await base64Encode(response.bodyBytes);

    return bs64;
  }

  Future<void> showBigPictureNotification() async {
    String bs64 = await uriTobase64();

    BigPictureStyleInformation big = await BigPictureStyleInformation(
        ByteArrayAndroidBitmap.fromBase64String(bs64));

    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        "1", "Solanki Arpita", styleInformation: big);
    DarwinNotificationDetails iOSDetails = DarwinNotificationDetails();

    NotificationDetails details = NotificationDetails(
        android: androidDetails, iOS: iOSDetails);

    notificationsPlugin.show(1, "title", "body", details);
  }

  Future<void> showFireNotification(String title,String body)
  async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        "1", "Solanki Arpita");
    DarwinNotificationDetails iOSDetails = DarwinNotificationDetails();

    NotificationDetails details = NotificationDetails(
        android: androidDetails, iOS: iOSDetails);

    await notificationsPlugin.show(1, "$title", "$body", details);
  }

  //=================================================
  //Firebase messaging
  //=================================================

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> initMessaging()
  async {
    var fcmToken = await messaging.getToken();
    print("============================== Arpita $fcmToken");

    await messaging.setAutoInitEnabled(true);

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    FirebaseMessaging.onMessage.listen((event) {

      if(event.notification != null)
        {
          String? title = event.notification!.title;
          String? body = event.notification!.body;

          NotificationService.notificationService.showFireNotification(title!,body!);
        }
    });
  }
}
