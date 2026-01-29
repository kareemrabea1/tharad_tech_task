import 'package:hive_flutter/hive_flutter.dart';

class PrefHelper {
  static late Box userBox;

  static Future<void> init() async {
    userBox = await Hive.openBox('userBox');
  }

  static Future<void> saveData({
    required String key,
    required dynamic value,
  }) async {
    await userBox.put(key, value);
  }

  static dynamic getData({required String key}) {
    return userBox.get(key);
  }

  static Future<void> removeData({required String key}) async {
    await userBox.delete(key);
  }

  static Future<void> clearAll() async {
    await userBox.clear();
  }
}
