import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AppNotificationService {
  AppNotificationService({
    FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin,
    FirebaseMessaging? messaging,
  })  : _localNotifications =
            flutterLocalNotificationsPlugin ?? FlutterLocalNotificationsPlugin(),
        _messaging = messaging;

  final FlutterLocalNotificationsPlugin _localNotifications;
  FirebaseMessaging? _messaging;
  int _counter = 0;

  static const _androidChannel = AndroidNotificationChannel(
    'sales_channel',
    'Ventas',
    description: 'Notificaciones de nueva venta',
    importance: Importance.high,
  );

  Future<void> init() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await _localNotifications.initialize(initializationSettings);
    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_androidChannel);

    _messaging ??= FirebaseMessaging.instance;

    await _messaging!.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen(_onMessage);
  }

  Future<void> _onMessage(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    await showLocalNotification(
      title: notification.title ?? 'Notificación',
      body: notification.body ?? '',
    );
  }

  Future<String?> getDeviceToken() async {
    if (_messaging == null) return null;
    return _messaging!.getToken();
  }

  Future<void> showLocalNotification({
    required String title,
    required String body,
  }) async {
    _counter = (_counter + 1) % 100000;
    await _localNotifications.show(
      _counter,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannel.id,
          _androidChannel.name,
          channelDescription: _androidChannel.description,
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
    );
  }

  // alias público para usar desde la app
  Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    await showLocalNotification(title: title, body: body);
  }
}
