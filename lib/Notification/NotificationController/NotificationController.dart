import 'dart:async';
import 'dart:isolate';
import 'dart:ui';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tradingapp/Bottom_nav_bar_screen.dart';
import '../../main.dart';

class NotificationController {
  static ReceivedAction? initialAction;

  ///  *********************************************
  ///     INITIALIZATIONS
  ///  *********************************************
  ///
  static Future<void> initializeLocalNotifications() async {
    await AwesomeNotifications().initialize(
        null, //'resource://drawable/res_app_icon',//
        [
          NotificationChannel(
              channelKey: 'alerts',
              channelName: 'Alerts',
              channelDescription: 'Notification tests as alerts',
              playSound: true,
              onlyAlertOnce: true,
              groupAlertBehavior: GroupAlertBehavior.Children,
              importance: NotificationImportance.High,
              defaultPrivacy: NotificationPrivacy.Private,
              defaultColor: Colors.deepPurple,
              ledColor: Colors.deepPurple)
        ],
        debug: true);

    initialAction = await AwesomeNotifications()
        .getInitialNotificationAction(removeFromActionEvents: false);
  }

  static ReceivePort? receivePort;

  static Future<void> initializeIsolateReceivePort() async {
    receivePort = ReceivePort('Notification action port in main isolate')..listen((silentData) => onActionReceivedImplementationMethod(silentData));

    IsolateNameServer.registerPortWithName(
        receivePort!.sendPort, 'notification_action_port');
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS LISTENER
  ///  *********************************************
  ///  Notifications events are only delivered after call this method
  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications()
        .setListeners(onActionReceivedMethod: onActionReceivedMethod);
  }

  ///  *********************************************
  ///     NOTIFICATION EVENTS
  ///  *********************************************
  ///
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    if (receivedAction.actionType == ActionType.SilentAction ||
        receivedAction.actionType == ActionType.SilentBackgroundAction) {
      debugPrint(
          'Message sent via notification input: "${receivedAction.buttonKeyInput}"');
      await executeLongTaskInBackground();
    } else {
      if (receivePort == null) {
        debugPrint(
            'onActionReceivedMethod was called inside a parallel dart isolate.');
        SendPort? sendPort =
            IsolateNameServer.lookupPortByName('notification_action_port');

        if (sendPort != null) {
          debugPrint('Redirecting the execution to main isolate process.');
          sendPort.send(receivedAction);
          return;
        }
      }
      return onActionReceivedImplementationMethod(receivedAction);
    }
  }

  static Future<void> onActionReceivedImplementationMethod(
      ReceivedAction receivedAction) async {
    final context = MyApp.navigatorKey.currentState?.overlay?.context;
    if (context != null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => MainScreen(),
        ),
            (route) => route.isFirst,
      );
    }
  }

  ///  *********************************************
  ///     REQUESTING NOTIFICATION PERMISSIONS
  ///  *********************************************
  ///
  static Future<bool> displayNotificationRationale() async {
    bool userAuthorized = false;
    BuildContext context = MyApp.navigatorKey.currentContext!;
    await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('Get Notified!',
                style: Theme.of(context).textTheme.titleLarge),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/animated-bell.gif',
                        height: MediaQuery.of(context).size.height * 0.3,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                    'Allow Awesome Notifications to send you beautiful notifications!'),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Deny',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () async {
                    userAuthorized = true;
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Allow',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.deepPurple),
                  )),
            ],
          );
        });
    return userAuthorized &&
        await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  ///  *********************************************
  ///     BACKGROUND TASKS TEST
  ///  *********************************************
  static Future<void> executeLongTaskInBackground() async {
    debugPrint("starting long task");
    await Future.delayed(const Duration(seconds: 4));
    final url = Uri.parse("http://google.com");
    final re = await http.get(url);
    debugPrint(re.body);
    debugPrint("long task done");
  }

  ///  *********************************************
  ///     NOTIFICATION CREATION METHODS
  ///  *********************************************


  static Future<void> createNewNotification({String? title, String? description}) async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) isAllowed = await displayNotificationRationale();
    if (!isAllowed) return;

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: -1,
            channelKey: 'alerts',
            title: title,
            body: description,
            // largeIcon: 'asset://assets/AppIcon/AppIcon.png',
            notificationLayout: NotificationLayout.Messaging,
            payload: {'notificationId': '1234567890'}),
        actionButtons: [
          NotificationActionButton(
              key: 'DISMISS',
              label: 'Dismiss',
              actionType: ActionType.DismissAction,
              isDangerousOption: true)
        ]);
  }

  static Future<void> scheduleNewNotification() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) isAllowed = await displayNotificationRationale();
    if (!isAllowed) return;

    await myNotifyScheduleInHours(
        title: 'test',
        msg: 'test message',
        heroThumbUrl:
            'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
        hoursFromNow: 5,
        username: 'test user',
        repeatNotif: false);
  }

  static Future<void> resetBadgeCounter() async {
    await AwesomeNotifications().resetGlobalBadge();
  }

  static Future<void> cancelNotifications() async {
    await AwesomeNotifications().cancelAll();
  }

 static Future<void> myNotifyScheduleInHours({
    required int hoursFromNow,
    required String heroThumbUrl,
    required String username,
    required String title,
    required String msg,
    bool repeatNotif = false,
  }) async {
    var nowDate = DateTime.now().add(Duration(hours: hoursFromNow, seconds: 5));
    await AwesomeNotifications().createNotification(
      schedule: NotificationCalendar(
        //weekday: nowDate.day,
        hour: nowDate.hour,
        minute: 0,
        second: nowDate.second,
        repeats: repeatNotif,
        //allowWhileIdle: true,
      ),
      // schedule: NotificationCalendar.fromDate(
      //    date: DateTime.now().add(const Duration(seconds: 10))),
      content: NotificationContent(
        id: -1,
        channelKey: 'basic_channel',
        title: '${Emojis.food_bowl_with_spoon} $title',
        body: '$username, $msg',
        bigPicture: heroThumbUrl,
        notificationLayout: NotificationLayout.BigPicture,
        //actionType : ActionType.DismissAction,
        color: Colors.black,
        backgroundColor: Colors.black,
        // customSound: 'resource://raw/notif',
        payload: {'actPag': 'myAct', 'actType': 'food', 'username': username},
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'NOW',
          label: 'btnAct1',
        ),
        NotificationActionButton(
          key: 'LATER',
          label: 'btnAct2',
        ),
      ],
    );
  }

}
