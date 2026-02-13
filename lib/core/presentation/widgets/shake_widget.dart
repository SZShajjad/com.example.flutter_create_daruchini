import 'dart:math';
import 'package:flutter/material.dart';

class ShakeController {
  late void Function() shake;
}

class ShakeWidget extends StatefulWidget {
  final Widget child;
  final double shakeOffset;
  final int shakeCount;
  final Duration duration;
  final ShakeController? controller;

  const ShakeWidget({
    super.key,
    required this.child,
    this.shakeOffset = 10,
    this.shakeCount = 3,
    this.duration = const Duration(milliseconds: 400),
    this.controller,
  });

  @override
  ShakeWidgetState createState() => ShakeWidgetState();
}

class ShakeWidgetState extends State<ShakeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ));

    if (widget.controller != null) {
      widget.controller!.shake = () {
        if (mounted) {
          _controller.forward(from: 0);
        }
      };
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final sineValue = sin(widget.shakeCount * 2 * pi * _animation.value);
        return Transform.translate(
          offset: Offset(sineValue * widget.shakeOffset, 0),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
