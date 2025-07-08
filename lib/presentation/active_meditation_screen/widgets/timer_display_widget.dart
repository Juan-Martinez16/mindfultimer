import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TimerDisplayWidget extends StatelessWidget {
  final String timeText;
  final bool isCompleted;
  final bool isPaused;

  const TimerDisplayWidget({
    Key? key,
    required this.timeText,
    required this.isCompleted,
    required this.isPaused,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Main timer text
        Text(
          timeText,
          style: AppTheme.timerTextStyle(
            isLight: false,
            fontSize: 24.sp,
          ).copyWith(
            color: isCompleted ? AppTheme.successGreen : AppTheme.primaryWhite,
            fontWeight: FontWeight.w600,
          ),
        ),

        SizedBox(height: 1.h),

        // Status indicator
        AnimatedOpacity(
          opacity: isPaused ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
            decoration: BoxDecoration(
              color: AppTheme.warningAmber.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.warningAmber.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomIconWidget(
                  iconName: 'pause',
                  color: AppTheme.warningAmber,
                  size: 3.w,
                ),
                SizedBox(width: 1.w),
                Text(
                  'Paused',
                  style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                    color: AppTheme.warningAmber,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Completion indicator
        AnimatedOpacity(
          opacity: isCompleted ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
            decoration: BoxDecoration(
              color: AppTheme.successGreen.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.successGreen.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomIconWidget(
                  iconName: 'check_circle',
                  color: AppTheme.successGreen,
                  size: 3.w,
                ),
                SizedBox(width: 1.w),
                Text(
                  'Complete',
                  style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                    color: AppTheme.successGreen,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
