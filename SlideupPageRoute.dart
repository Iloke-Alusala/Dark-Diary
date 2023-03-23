import 'dart:ui';

import 'package:flutter/material.dart';

/// {@template hero_dialog_route}
/// Custom [PageRoute] that creates an overlay dialog (popup effect).
///
/// Best used with a [Hero] animation.
/// {@endtemplate}
class SlideupPageRoute<T> extends PageRoute<T> {
  /// {@macro hero_dialog_route}
  SlideupPageRoute({
    required WidgetBuilder builder,
    RouteSettings?  settings,
    bool fullscreenDialog = false,
  })  : _builder = builder,
        super(settings: settings, fullscreenDialog: fullscreenDialog);

  final WidgetBuilder _builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  Duration get reverseTransitionDuration => const Duration(milliseconds: 100);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override




  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {

    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.ease;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    return SlideTransition(
        position: //animation.drive(tween));
        
        Tween<Offset>(
          begin: Offset(0, 1),
          end: Offset.zero,
        ).chain(CurveTween(curve: curve)).animate(animation), child: child);
         
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _builder(context);
  }

  @override
  String get barrierLabel => 'Popup Screen open';
}