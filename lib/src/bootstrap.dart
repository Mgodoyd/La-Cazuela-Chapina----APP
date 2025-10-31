import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/config/app_config.dart';
import 'core/config/app_config_provider.dart';
import 'core/notifications/notification_providers.dart';
import 'core/notifications/notification_service.dart';
import 'core/offline/offline_providers.dart';
import 'core/offline/offline_queue.dart';
import 'core/storage/hive_providers.dart';
import 'core/storage/hive_service.dart';
import 'core/utils/provider_logger.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  final config = await AppConfig.load();
  const hiveService = HiveService();
  await hiveService.init();

  final offlineBox =
      await hiveService.openBox<String>(OfflineQueueService.boxName);
  final offlineQueue = OfflineQueueService(offlineBox);

  AppNotificationService notificationService = AppNotificationService();
  try {
    await Firebase.initializeApp();
    await notificationService.init();
  } catch (_) {
  }

  runApp(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(config),
        hiveServiceProvider.overrideWithValue(hiveService),
        offlineQueueProvider.overrideWithValue(offlineQueue),
        notificationServiceProvider.overrideWithValue(notificationService),
      ],
      observers: [
        AppProviderLogger(),
      ],
      child: const CazuelaChapinaApp(),
    ), 
  );
}

