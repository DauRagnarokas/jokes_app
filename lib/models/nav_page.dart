import 'package:flutter/material.dart';

class NavPage {
  final String title;
  final Icon navIcon;
  final String navLabel;
  final Widget body;

  NavPage({
    required this.title,
    required this.navIcon,
    required this.navLabel,
    required this.body,
  });
}
