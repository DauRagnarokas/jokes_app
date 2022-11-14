import 'package:dio/dio.dart';

class InputException implements Exception {
  String message;
  InputException({required this.message});

  factory InputException.fromDioMessage(DioError error) {
    return InputException(message: error.response!.data['message']);
  }

  @override
  String toString() => message;
}
