import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  const HiveService();

  Future<void> init() async {
    await Hive.initFlutter();
  }

  Future<Box<T>> openBox<T>(String name) {
    return Hive.openBox<T>(name);
  }
}

