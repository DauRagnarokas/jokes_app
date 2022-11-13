import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jokes_app/utils/suggestion_exception.dart';

class ErrorHandler extends StatelessWidget {
  ErrorHandler(
    this.error,
    this.stackTrace, {
    Key? key,
    this.isSliver = false,
  }) : super(key: key) {
    if (error is DioError) {
      message = (error as DioError).response!.data.toString();
    }
    if (error is InputException) {
      message = (error as InputException).message;
    } else {
      message = error.toString();
    }
  }

  final Object error;
  final StackTrace stackTrace;
  final bool isSliver;
  late final String message;

  @override
  Widget build(BuildContext context) {
    debugPrint("ERROR: $message\n$stackTrace");
    return isSliver
        ? SliverToBoxAdapter(child: _buildMessageView(context))
        : _buildMessageView(context);
  }

  Center _buildMessageView(BuildContext context) {
    return Center(
      child: Text(
        message.toString(),
        style: _buildMessageStyle(context),
      ),
    );
  }

  TextStyle _buildMessageStyle(BuildContext context) {
    late TextStyle style;
    if (error is InputException) {
      style =
          Theme.of(context).textTheme.headline5!.copyWith(color: Colors.red);
    } else {
      style = Theme.of(context).textTheme.headline6!.copyWith(color: Colors.red);
    }
    return style;
  }
}
