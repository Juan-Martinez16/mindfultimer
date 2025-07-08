import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'dart:math' as math;

import '../../../core/app_export.dart';

class CelebrationAnimationWidget extends StatefulWidget {
  final AnimationController controller;

  const CelebrationAnimationWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<CelebrationAnimationWidget> createState() =>
      _CelebrationAnimationWidgetState();
}

class _CelebrationAnimationWidgetState extends State<CelebrationAnimationWidget>
    with TickerProviderStateMixin {
  late AnimationController _particleController;
  late AnimationController _checkmarkController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _checkmarkAnimation;
  late Animation<double> _particleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimationSequence();
  }

  void _initializeAnimations() {
    _particleController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _checkmarkController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: widget.controller,
      curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
    ));

    _checkmarkAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _checkmarkController,
      curve: Curves.easeInOut,
    ));

    _particleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _particleController,
      curve: Curves.easeOut,
    ));
  }

  void _startAnimationSequence() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _checkmarkController.forward();
      }
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _particleController.forward();
      }
    });
  }

  @override
  void dispose() {
    _particleController.dispose();
    _checkmarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30.w,
      height: 30.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Particle Effects
          AnimatedBuilder(
            animation: _particleAnimation,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: List.generate(8, (index) {
                  final angle = (index * 45) * (3.14159 / 180);
                  final distance = 15.w * _particleAnimation.value;
                  final x = distance * (math.cos(angle));
                  final y = distance * (math.sin(angle));

                  return Transform.translate(
                    offset: Offset(x, y),
                    child: Opacity(
                      opacity: 1.0 - _particleAnimation.value,
                      child: Container(
                        width: 1.w,
                        height: 1.w,
                        decoration: BoxDecoration(
                          color: AppTheme.accentBlue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),

          // Expanding Circle Background
          ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              width: 25.w,
              height: 25.w,
              decoration: BoxDecoration(
                color: AppTheme.lightBlue,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.accentBlue,
                  width: 2,
                ),
              ),
            ),
          ),

          // Checkmark Icon
          ScaleTransition(
            scale: _checkmarkAnimation,
            child: Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                color: AppTheme.accentBlue,
                shape: BoxShape.circle,
              ),
              child: CustomIconWidget(
                iconName: 'check',
                color: AppTheme.primaryWhite,
                size: 6.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}