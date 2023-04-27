import 'package:flutter/material.dart';

class quickPageRoute extends PageRouteBuilder {
  final Widget child;

  quickPageRoute({
    required this.child,
  }) : super(
      transitionDuration: const Duration(milliseconds: 0),
      reverseTransitionDuration: const Duration(milliseconds: 0),
      pageBuilder: (context, animation, secondaryAnimation,) => child,
      barrierDismissible: true);

}
