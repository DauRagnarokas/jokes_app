import 'package:hive_flutter/hive_flutter.dart';

import '../models/joke.dart';



class HiveService {

  static init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(JokeAdapter());
  }

  static Future<void> openBox(String name) => Hive.openBox<Joke>(name);
  static Box<Joke> getBox(String name) => Hive.box<Joke>(name);
}
