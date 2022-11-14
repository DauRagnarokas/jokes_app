import 'package:hive_flutter/hive_flutter.dart';

import '../models/joke.dart';



class HiveService {

  static init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(JokeAdapter());
  }

  static Future<void> openBox<T>(String name) => Hive.openBox<T>(name);
  static Box<T> getBox<T>(String name) => Hive.box<T>(name);
}
