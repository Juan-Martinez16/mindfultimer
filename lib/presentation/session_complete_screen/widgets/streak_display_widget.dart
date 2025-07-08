import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class StreakDisplayWidget extends StatelessWidget {
  final int currentStreak;

  const StreakDisplayWidget({
    Key? key,
    required this.currentStreak,
  }) : super(key: key);

  List<int> get _achievementMilestones => [7, 30, 100];

  bool _hasAchievedMilestone(int milestone) {
    return currentStreak >= milestone;
  }

  int? get _nextMilestone {
    for (int milestone in _achievementMilestones) {
      if (currentStreak < milestone) {
        return milestone;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Main Streak Display
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIconWidget(
                iconName: 'local_fire_department',
                color: currentStreak >= 7
                    ? AppTheme.warningAmber
                    : AppTheme.accentBlue,
                size: 8.w,
              ),
              SizedBox(width: 3.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$currentStreak',
                    style:
                        AppTheme.lightTheme.textTheme.headlineLarge?.copyWith(
                      color: AppTheme.accentBlue,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    currentStreak == 1 ? 'day streak' : 'day streak',
                    style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textGray,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 4.h),

          // Achievement Badges
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _achievementMilestones.map((milestone) {
              final isAchieved = _hasAchievedMilestone(milestone);
              return _buildAchievementBadge(milestone, isAchieved);
            }).toList(),
          ),

          if (_nextMilestone != null) ...[
            SizedBox(height: 3.h),

            // Progress to Next Milestone
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: AppTheme.lightBlue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    'Next milestone: $_nextMilestone days',
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.secondaryBlue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  LinearProgressIndicator(
                    value: currentStreak / _nextMilestone!,
                    backgroundColor: AppTheme.borderGray,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppTheme.accentBlue),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    '${_nextMilestone! - currentStreak} days to go',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textGray,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAchievementBadge(int milestone, bool isAchieved) {
    return Column(
      children: [
        Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            color: isAchieved ? AppTheme.successGreen : AppTheme.borderGray,
            shape: BoxShape.circle,
            border: Border.all(
              color: isAchieved ? AppTheme.successGreen : AppTheme.borderGray,
              width: 2,
            ),
          ),
          child: CustomIconWidget(
            iconName: isAchieved ? 'emoji_events' : 'lock',
            color: isAchieved ? AppTheme.primaryWhite : AppTheme.textGray,
            size: 6.w,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          '$milestone days',
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: isAchieved ? AppTheme.successGreen : AppTheme.textGray,
            fontWeight: isAchieved ? FontWeight.w500 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
