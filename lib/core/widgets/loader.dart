import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key, this.color, this.size, this.strokeWidth}) : super(key: key);
  final Color? color;
  final double? size;
  final double? strokeWidth;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: size != null
          ? SizedBox.square(
              dimension: size,
              child: _buildLoader(),
            )
          : _buildLoader(),
    );
  }

  Widget _buildLoader() => CircularProgressIndicator(color: color, strokeWidth: strokeWidth ?? 4,);
}
