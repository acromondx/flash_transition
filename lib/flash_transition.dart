library flash_transition;

import 'package:flutter/material.dart';

enum TransitionDirection { left, right, bottom, top }

class PageTransition {
  static Route create(Widget destinationScreen,
      {bool fade = false, TransitionDirection td = TransitionDirection.right}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          destinationScreen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = _beginOffsetValue(td);
        const end = Offset.zero;
        const curve = Curves.fastLinearToSlowEaseIn;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return fade
            ? FadeTransition(
                opacity: animation,
                child: child,
              )
            : SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  static Offset _beginOffsetValue(TransitionDirection td) {
    switch (td) {
      case TransitionDirection.left:
        return const Offset(-1.0, 0.0);
      case TransitionDirection.right:
        return const Offset(1.0, 0.0);
      case TransitionDirection.bottom:
        return const Offset(0.0, 1.0);
      case TransitionDirection.top:
        return const Offset(0.0, -1.0);
    }
  }
}
