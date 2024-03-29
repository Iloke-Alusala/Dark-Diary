import 'package:flutter/material.dart';

class customPageRoute extends PageRouteBuilder {
  final Widget child;

  customPageRoute({
    required this.child,
  }) : super(
            transitionDuration: const Duration(milliseconds: 70),
            reverseTransitionDuration: const Duration(milliseconds: 70),
            pageBuilder: (context, animation, secondaryAnimation,) => child,
  barrierDismissible: true);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation), child: child);
}
