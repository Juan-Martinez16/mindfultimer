import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SessionControlsWidget extends StatelessWidget {
  final bool isPaused;
  final bool isCompleted;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final VoidCallback onEnd;

  const SessionControlsWidget({
    Key? key,
    required this.isPaused,
    required this.isCompleted,
    required this.onPause,
    required this.onResume,
    required this.onEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isCompleted) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Text(
          'Session Complete! 🎉',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.successGreen,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // End session button (long press)
          GestureDetector(
            onLongPress: () {
              HapticFeedback.mediumImpact();
              onEnd();
            },
            child: Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: AppTheme.warningAmber.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.warningAmber.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: CustomIconWidget(
                iconName: 'stop',
                color: AppTheme.warningAmber,
                size: 6.w,
              ),
            ),
          ),

          // Main pause/resume button
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              isPaused ? onResume() : onPause();
            },
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.accentBlue.withValues(alpha: 0.2),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.accentBlue.withValues(alpha: 0.5),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.accentBlue.withValues(alpha: 0.3),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: CustomIconWidget(
                iconName: isPaused ? 'play_arrow' : 'pause',
                color: AppTheme.accentBlue,
                size: 8.w,
              ),
            ),
          ),

          // Spacer for symmetry
          Container(
            padding: EdgeInsets.all(3.w),
            child: CustomIconWidget(
              iconName: 'self_improvement',
              color: AppTheme.primaryWhite.withValues(alpha: 0.3),
              size: 6.w,
            ),
          ),
        ],
      ),
    );
  }
}
