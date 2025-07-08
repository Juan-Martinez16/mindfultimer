import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class StreakCalendarWidget extends StatelessWidget {
  final List<bool> recentMeditationDays;

  const StreakCalendarWidget({
    Key? key,
    required this.recentMeditationDays,
  }) : super(key: key);

  List<String> get _weekDays => ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.borderGray,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Activity',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.textGray,
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: 2.h),

          // Week Days Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _weekDays.map((day) {
              return SizedBox(
                width: 8.w,
                child: Text(
                  day,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textGray,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }).toList(),
          ),

          SizedBox(height: 1.h),

          // Meditation Days Circles
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(7, (index) {
              final hasMeditated = index < recentMeditationDays.length
                  ? recentMeditationDays[index]
                  : false;
              final isToday = index == 6; // Last day is today

              return _buildDayCircle(hasMeditated, isToday);
            }),
          ),

          SizedBox(height: 2.h),

          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem(true, 'Completed'),
              SizedBox(width: 4.w),
              _buildLegendItem(false, 'Missed'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDayCircle(bool hasMeditated, bool isToday) {
    return Container(
      width: 8.w,
      height: 8.w,
      decoration: BoxDecoration(
        color: hasMeditated ? AppTheme.accentBlue : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: isToday
              ? AppTheme.accentBlue
              : (hasMeditated ? AppTheme.accentBlue : AppTheme.borderGray),
          width: isToday ? 2 : 1,
        ),
      ),
      child: hasMeditated
          ? CustomIconWidget(
              iconName: 'check',
              color: AppTheme.primaryWhite,
              size: 4.w,
            )
          : null,
    );
  }

  Widget _buildLegendItem(bool filled, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 4.w,
          height: 4.w,
          decoration: BoxDecoration(
            color: filled ? AppTheme.accentBlue : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: filled ? AppTheme.accentBlue : AppTheme.borderGray,
              width: 1,
            ),
          ),
          child: filled
              ? CustomIconWidget(
                  iconName: 'check',
                  color: AppTheme.primaryWhite,
                  size: 2.w,
                )
              : null,
        ),
        SizedBox(width: 1.w),
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.textGray,
          ),
        ),
      ],
    );
  }
}
