import 'package:flutter/foundation.dart';

void logDebug(String message) {
  if (kDebugMode) {
    debugPrint('[DEBUG] $message');
  }
}

void logError(Object error, [StackTrace? stackTrace]) {
  debugPrint('[ERROR] $error');
  if (stackTrace != null) {
    debugPrint(stackTrace.toString());
  }
}

