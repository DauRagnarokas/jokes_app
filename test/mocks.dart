import 'package:dio/dio.dart';
import 'package:jokes_app/services/dio_service.dart';
import 'package:mocktail/mocktail.dart';

//  Dio Mocks

class MockDio extends Mock implements Dio {}

class MockDioService extends Mock implements DioService {}

class MockDioResponse<T> extends Mock implements Response<T> {}

class MockDioError extends Mock implements DioError {}
