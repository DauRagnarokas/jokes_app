import 'package:flutter/material.dart';

class PageRouteNoAnimation extends MaterialPageRoute {
  PageRouteNoAnimation({builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}
