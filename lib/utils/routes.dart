import 'package:flutter/material.dart';

Route slideRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,

    transitionDuration: const Duration(milliseconds: 300),

    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // slide from right
      const end = Offset.zero;
      const curve = Curves.ease;

      final tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: curve),
      );

      return SlideTransition(
        position: animation.drive(tween),
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    },
  );
}

Route fadeRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,

    transitionDuration: const Duration(milliseconds: 250),

    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}