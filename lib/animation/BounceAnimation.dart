// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';

class BounceAnimation extends StatefulWidget {
  final double delay;
  final Widget child;

  const BounceAnimation(this.delay, this.child, {super.key});

  @override
  _BounceAnimationState createState() => _BounceAnimationState();
}

class _BounceAnimationState extends State<BounceAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    final curve = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _scale = Tween<double>(begin: 0, end: 1).animate(curve);

    Future.delayed(Duration(milliseconds: (500 * widget.delay).round()), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scale.value,
          child: widget.child,
        );
      },
    );
  }
}
