import 'package:get_storage/get_storage.dart';

class ConsumableStore {
  static const String _kBoxKey = 'consumables';

  static Future<void> save(String id) async {
    final box = GetStorage();
    List<String> cached = box.read(_kBoxKey) ?? [];
    cached.add(id);
    await box.write(_kBoxKey, cached);
  }

  static Future<void> consume(String id) async {
    final box = GetStorage();
    List<String> cached = box.read(_kBoxKey) ?? [];
    cached.remove(id);
    await box.write(_kBoxKey, cached);
  }

  static List<String> load() {
    final box = GetStorage();
    return box.read(_kBoxKey) ?? [];
  }
}
