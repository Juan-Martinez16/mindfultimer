import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class DurationSelectorWidget extends StatelessWidget {
  final int selectedDuration;
  final Function(int) onDurationChanged;

  const DurationSelectorWidget({
    Key? key,
    required this.selectedDuration,
    required this.onDurationChanged,
  }) : super(key: key);

  void _incrementDuration() {
    if (selectedDuration < 60) {
      onDurationChanged(selectedDuration + 1);
    }
  }

  void _decrementDuration() {
    if (selectedDuration > 1) {
      onDurationChanged(selectedDuration - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Meditation Duration',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(height: 3.h),
        Container(
          width: 70.w,
          height: 70.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: AppTheme.shadowLight,
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$selectedDuration',
                style: AppTheme.timerTextStyle(
                  isLight: Theme.of(context).brightness == Brightness.light,
                  fontSize: 32.sp,
                ),
              ),
              Text(
                selectedDuration == 1 ? 'minute' : 'minutes',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textGray,
                      fontSize: 14.sp,
                    ),
              ),
            ],
          ),
        ),
        SizedBox(height: 3.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _decrementDuration,
              child: Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selectedDuration > 1
                      ? AppTheme.accentBlue
                      : AppTheme.textGray.withValues(alpha: 0.3),
                  boxShadow: selectedDuration > 1
                      ? [
                          BoxShadow(
                            color: AppTheme.shadowLight,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: CustomIconWidget(
                  iconName: 'remove',
                  color: selectedDuration > 1
                      ? AppTheme.primaryWhite
                      : AppTheme.textGray,
                  size: 6.w,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: _incrementDuration,
              child: Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selectedDuration < 60
                      ? AppTheme.accentBlue
                      : AppTheme.textGray.withValues(alpha: 0.3),
                  boxShadow: selectedDuration < 60
                      ? [
                          BoxShadow(
                            color: AppTheme.shadowLight,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: CustomIconWidget(
                  iconName: 'add',
                  color: selectedDuration < 60
                      ? AppTheme.primaryWhite
                      : AppTheme.textGray,
                  size: 6.w,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
