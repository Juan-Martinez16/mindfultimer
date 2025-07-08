import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class BellSoundCardWidget extends StatefulWidget {
  final String soundName;
  final String description;
  final String waveformUrl;
  final String audioUrl;
  final bool isSelected;
  final VoidCallback onTap;

  const BellSoundCardWidget({
    Key? key,
    required this.soundName,
    required this.description,
    required this.waveformUrl,
    required this.audioUrl,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  State<BellSoundCardWidget> createState() => _BellSoundCardWidgetState();
}

class _BellSoundCardWidgetState extends State<BellSoundCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  void _playSound() {
    setState(() {
      _isPlaying = true;
    });

    // Haptic feedback
    HapticFeedback.lightImpact();

    // Simulate audio playback
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 90.w,
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                border: widget.isSelected
                    ? Border.all(color: AppTheme.accentBlue, width: 2)
                    : Border.all(color: Colors.transparent, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: widget.isSelected
                        ? AppTheme.accentBlue.withValues(alpha: 0.2)
                        : AppTheme.shadowLight,
                    blurRadius: widget.isSelected ? 8 : 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Waveform visualization
                  Container(
                    width: 15.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppTheme.lightBlue,
                    ),
                    child: CustomImageWidget(
                      imageUrl: widget.waveformUrl,
                      width: 15.w,
                      height: 8.h,
                      fit: BoxFit.cover,
                    ),
                  ),

                  SizedBox(width: 3.w),

                  // Sound details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.soundName,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          widget.description,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppTheme.textGray,
                                    fontSize: 12.sp,
                                  ),
                        ),
                      ],
                    ),
                  ),

                  // Play button
                  GestureDetector(
                    onTap: _playSound,
                    child: Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isPlaying
                            ? AppTheme.successGreen
                            : AppTheme.accentBlue,
                      ),
                      child: CustomIconWidget(
                        iconName: _isPlaying ? 'stop' : 'play_arrow',
                        color: AppTheme.primaryWhite,
                        size: 5.w,
                      ),
                    ),
                  ),

                  SizedBox(width: 2.w),

                  // Selection indicator
                  widget.isSelected
                      ? CustomIconWidget(
                          iconName: 'check_circle',
                          color: AppTheme.accentBlue,
                          size: 6.w,
                        )
                      : CustomIconWidget(
                          iconName: 'radio_button_unchecked',
                          color: AppTheme.textGray,
                          size: 6.w,
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
