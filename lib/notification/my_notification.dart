import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MyNotification extends StatefulWidget {
  const MyNotification({Key? key}) : super(key: key);

  @override
  _MyNotificationState createState() => _MyNotificationState();
}

class _MyNotificationState extends State<MyNotification> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('ic_launcher');
    var initializationSettingsIOs = const IOSInitializationSettings();
    var initSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(
      initSettings,
    );
  }

  // Future onSelectNotification(String payload) async {
  //   Navigator.of(context).push(MaterialPageRoute(builder: (_) {
  //     return NewScreen(
  //       payload: payload,
  //     );
  //   }));
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text('Flutter notification demo'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              ButtonTheme(
                minWidth: 250.0,
                child: ElevatedButton(
                  onPressed: showNotification,
                  child: const Text(
                    'showNotification',
                  ),
                ),
              ),
              ButtonTheme(
                minWidth: 250.0,
                child: ElevatedButton(
                  onPressed: scheduleNotification,
                  child: const Text(
                    'scheduleNotification',
                  ),
                ),
              ),
              ButtonTheme(
                minWidth: 250.0,
                child: ElevatedButton(
                  onPressed: showBigPictureNotification,
                  child: const Text(
                    'showBigPictureNotification',
                  ),
                ),
              ),
              ButtonTheme(
                minWidth: 250.0,
                child: ElevatedButton(
                  onPressed: showNotificationMediaStyle,
                  child: const Text(
                    'showNotificationMediaStyle',
                  ),
                ),
              ),
              ButtonTheme(
                minWidth: 250.0,
                child: ElevatedButton(
                  onPressed: cancelNotification,
                  child: const Text(
                    'cancelNotification',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showNotification() async {
    var android = const AndroidNotificationDetails(
      'id',
      'channel ',
      channelDescription: 'description',
      priority: Priority.high,
      importance: Importance.max,
    );
    var iOS = const IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'Flutter devs', 'Flutter Local Notification Demo', platform,
        payload: 'Welcome to the Local Notification demo ');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Yay! A SnackBar!'),
      ),
    );
  }

  Future<void> scheduleNotification() async {
    var scheduledNotificationDateTime =
        DateTime.now().add(const Duration(seconds: 1));
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channel id',
      'channel name',
      channelDescription: 'channel description',
      icon: 'ic_launcher',
      largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
      priority: Priority.high,
      importance: Importance.max,
    );
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'scheduled title',
        'scheduled body',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }

  Future<void> showBigPictureNotification() async {
    var bigPictureStyleInformation = const BigPictureStyleInformation(
        DrawableResourceAndroidBitmap("ic_launcher"),
        largeIcon: DrawableResourceAndroidBitmap("ic_launcher"),
        contentTitle: 'flutter devs',
        htmlFormatContentTitle: true,
        summaryText: 'summaryText',
        htmlFormatSummaryText: true);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'big text channel id',
      'big text channel name',
      channelDescription: 'big text channel description',
      styleInformation: bigPictureStyleInformation,
      priority: Priority.high,
      importance: Importance.max,
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'big text title', 'silent body', platformChannelSpecifics,
        payload: "big image notifications");
  }

  Future<void> showNotificationMediaStyle() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'media channel id',
      'media channel name',
      channelDescription: 'media channel description',
      color: Colors.blue,
      enableLights: true,
      largeIcon: DrawableResourceAndroidBitmap("ic_launcher"),
      styleInformation: MediaStyleInformation(),
      priority: Priority.high,
      importance: Importance.max,
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'notification title',
      'notification body',
      platformChannelSpecifics,
      payload: "show Notification Media Style",
    );
  }

  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }
}

class NewScreen extends StatefulWidget {
  String payload;

  NewScreen({
    required this.payload,
  });

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.payload),
      ),
    );
  }
}
