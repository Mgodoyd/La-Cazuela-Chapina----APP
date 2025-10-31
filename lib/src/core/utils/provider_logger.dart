import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'logger.dart';

class AppProviderLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    logDebug(
      'Provider ${provider.name ?? provider.runtimeType} cambió de '
      '$previousValue a $newValue',
    );
    super.didUpdateProvider(provider, previousValue, newValue, container);
  }
}

