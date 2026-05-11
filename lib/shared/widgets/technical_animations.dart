import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TechnicalPulseAnimation extends StatefulWidget {
  const TechnicalPulseAnimation({super.key});

  @override
  State<TechnicalPulseAnimation> createState() =>
      _TechnicalPulseAnimationState();
}

class _TechnicalPulseAnimationState extends State<TechnicalPulseAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
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
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.3 + (_controller.value * 0.7)),
              width: 2,
            ),
          ),
          child: Center(
            child: Container(
              width: 40 * _controller.value,
              height: 40 * _controller.value,
              color: AppColors.primary,
            ),
          ),
        );
      },
    );
  }
}
