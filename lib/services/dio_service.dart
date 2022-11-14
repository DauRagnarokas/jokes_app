import 'package:dio/dio.dart';

class DioService {
  static final _instance = Dio();

  Future<List<T>> getCollection<T>({
    required String path,
    required T Function(dynamic data) builder,
  }) async {
      final Response response = await DioService._instance.get(path);
      final List<T> result = [];
      response.data.forEach(
        (element) {
          result.add(builder(element));
        },
      );
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
