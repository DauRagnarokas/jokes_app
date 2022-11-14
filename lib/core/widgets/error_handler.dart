import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jokes_app/utils/input_exception.dart';


String getErrorMessage(Object error) {
  if (error is DioError) {
    return error.message;
  } else if (error is InputException) {
    return error.message;
  } else {
    return error.toString();
  }
}

class ErrorHandler extends StatelessWidget {
  ErrorHandler(
    this.error,
    this.stackTrace, {
    Key? key,
    this.isSliver = false,
    this.showMessage = true,
  }) : super(key: key) {
    message = getErrorMessage(error);
  }

  final Object error;
  final StackTrace stackTrace;
  final bool isSliver;
  final bool showMessage;
  late final String message;

  @override
  Widget build(BuildContext context) {
    debugPrint("ERROR: $message\n$stackTrace");
    return isSliver
        ? SliverToBoxAdapter(child: _buildMessageView(context))
        : _buildMessageView(context);
  }

  Widget _buildMessageView(BuildContext context) {
    if(!showMessage) return const SizedBox.shrink();
    return Center(
      child: Text(
        message.toString(),
        style: _buildMessageStyle(context),
        textAlign: TextAlign.center,
      ),
    );
  }

  TextStyle _buildMessageStyle(BuildContext context) {
    late TextStyle style;
    if (error is InputException) {
      style =
          Theme.of(context).textTheme.headline5!.copyWith(color: Colors.red);
    } else {
      style = Theme.of(context).textTheme.headline6!.copyWith(
            color: Colors.red,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          );
    }
    return style;
  }
}
