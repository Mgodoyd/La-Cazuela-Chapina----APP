import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  AppConfig({
    required this.apiBaseUrl,
    required this.websocketUrl
  });

  final String apiBaseUrl;
  final String websocketUrl;

  static Future<AppConfig> load({String fileName = '.env'}) async {
    if (!dotenv.isInitialized) {
      await dotenv
          .load(fileName: fileName)
          .catchError((_) async =>
              dotenv.load(fileName: 'assets/.env').catchError((_) {}));
    }
    return fromEnvironment();
  }

  static AppConfig fromEnvironment() {
    final apiUrl = dotenv.env['API_BASE_URL'] ?? 'http://192.168.0.8:5266/api/v1';
    final wsUrl = dotenv.env['WS_BASE_URL'] ?? 'ws://192.168.0.8:5266/ws';
    return AppConfig(
      apiBaseUrl: apiUrl,
      websocketUrl: wsUrl
    );
  }
}

