import 'package:flutter/material.dart';

class AnimatedPageRoute<T> extends PageRoute<T> {
  AnimatedPageRoute(this.child);
  @override
  // TODO: implement barrierColor
  Color get barrierColor => Colors.transparent;

  @override
  String get barrierLabel => null;

  final Widget child;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);
}