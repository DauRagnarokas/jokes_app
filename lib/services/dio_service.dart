import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jokes_app/constants.dart';

final dioClientProvider = Provider<Dio>(
  (ref) => Dio(
    BaseOptions(
      baseUrl: baseUrl,
    ),
  ),
);

final dioProvider = Provider<DioService>(
  (ref) => DioService(read: ref.read),
);

class DioService {
  final Function(ProviderListenable) read;

  DioService({required this.read});

  Future<List<T>> getCollection<T>({
    required String path,
    required T Function(dynamic data) builder,
  }) async {
    final Response response = await read(dioClientProvider).get(path);
    final List<T> result = [for (final item in response.data) builder(item)];
    return result;
  }

  Future<T> getSingle<T>({
    required String path,
    required T Function(Map<String, dynamic> data) builder,
  }) async {
    final Response response = await read(dioClientProvider).get(path);
    return builder(response.data);
  }
}
