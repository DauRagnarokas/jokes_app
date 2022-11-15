import 'package:dio/dio.dart';

class DioService {
  static const _baseUrl = 'https://api.chucknorris.io/jokes/';
  static final _instance = Dio(BaseOptions(baseUrl: _baseUrl));

  Future<List<T>> getCollection<T>({
    required String path,
    required T Function(dynamic data) builder,
  }) async {
    final Response response = await DioService._instance.get(path);
    final List<T> result = [
      for (final item in response.data) builder(item)
    ];
    return result;
  }

  Future<T> getSingle<T>({
    required String path,
    required T Function(Map<String, dynamic> data) builder,
  }) async {
    final Response response = await DioService._instance.get(path);
    return builder(response.data);
  }
}
