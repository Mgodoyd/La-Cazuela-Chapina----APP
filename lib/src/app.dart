import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router/app_router.dart';
import 'core/offline/offline_sync.dart';

class CazuelaChapinaApp extends ConsumerWidget {
  const CazuelaChapinaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // inicialización de la sincronización offline (escucha conectividad y vacía la cola)
    ref.watch(offlineSyncProvider);
    final router = ref.watch(appRouterProvider);

    final baseColor = const Color(0xFF8B4513);
    final colorScheme = ColorScheme.fromSeed(
      seedColor: baseColor,
      brightness: Brightness.light,
    );

    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    );

    return MaterialApp.router
      (
      title: 'La Cazuela Chapina',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: colorScheme.surface,
        appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
        inputDecorationTheme: InputDecorationTheme(
          border: inputBorder,
          enabledBorder: inputBorder,
          focusedBorder: inputBorder.copyWith(
            borderSide: BorderSide(color: colorScheme.primary, width: 2),
          ),
          filled: true,
          fillColor: colorScheme.surfaceContainerHighest.withAlpha((255 * 0.5).toInt()),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            textStyle: const TextStyle(fontWeight: FontWeight.w600),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        cardTheme: CardThemeData(
          color: colorScheme.surface,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}

