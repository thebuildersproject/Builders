import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation({
    required this.delay,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return PlayAnimationBuilder<double>(
      duration: Duration(milliseconds: 500),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      delay: Duration(milliseconds: (500 * delay).round()),
      builder: (context, opacity, child) => Opacity(
        opacity: opacity,
        child: child,
      ),
      child: PlayAnimationBuilder<double>(
        duration: Duration(milliseconds: 500),
        tween: Tween<double>(begin: -30.0, end: 0.0),
        delay: Duration(milliseconds: (500 * delay).round()),
        builder: (context, translateY, child) => Transform.translate(
          offset: Offset(0, translateY),
          child: child,
        ),
        child: child,
      ),
    );
  }
}
