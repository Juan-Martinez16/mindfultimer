import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ActionButtonsWidget extends StatelessWidget {
  final VoidCallback onMeditateAgain;
  final VoidCallback onDone;

  const ActionButtonsWidget({
    Key? key,
    required this.onMeditateAgain,
    required this.onDone,
  }) : super(key: key);

  void _handleHapticFeedback() {
    HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Column(
        children: [
          // Primary Action Button - Done
          SizedBox(
            width: double.infinity,
            height: 6.h,
            child: ElevatedButton(
              onPressed: () {
                _handleHapticFeedback();
                onDone();
              },
              style: AppTheme.lightTheme.elevatedButtonTheme.style?.copyWith(
                backgroundColor: WidgetStateProperty.all(AppTheme.accentBlue),
                foregroundColor: WidgetStateProperty.all(AppTheme.primaryWhite),
                elevation: WidgetStateProperty.all(2.0),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'check_circle',
                    color: AppTheme.primaryWhite,
                    size: 5.w,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Done',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.primaryWhite,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 2.h),

          // Secondary Action Button - Meditate Again
          SizedBox(
            width: double.infinity,
            height: 6.h,
            child: OutlinedButton(
              onPressed: () {
                _handleHapticFeedback();
                onMeditateAgain();
              },
              style: AppTheme.lightTheme.outlinedButtonTheme.style?.copyWith(
                foregroundColor: WidgetStateProperty.all(AppTheme.accentBlue),
                side: WidgetStateProperty.all(
                  const BorderSide(color: AppTheme.accentBlue, width: 1.5),
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                overlayColor: WidgetStateProperty.all(
                  AppTheme.accentBlue.withValues(alpha: 0.1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'refresh',
                    color: AppTheme.accentBlue,
                    size: 5.w,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Meditate Again',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.accentBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 1.h),

          // Share Achievement Button (Optional)
          TextButton(
            onPressed: () {
              _handleHapticFeedback();
              _showShareDialog(context);
            },
            style: AppTheme.lightTheme.textButtonTheme.style?.copyWith(
              foregroundColor: WidgetStateProperty.all(AppTheme.textGray),
              overlayColor: WidgetStateProperty.all(
                AppTheme.textGray.withValues(alpha: 0.1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomIconWidget(
                  iconName: 'share',
                  color: AppTheme.textGray,
                  size: 4.w,
                ),
                SizedBox(width: 1.w),
                Text(
                  'Share Achievement',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textGray,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showShareDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.lightTheme.dialogBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Share Your Achievement',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.textHighEmphasisLight,
            ),
          ),
          content: Text(
            'Share your meditation progress with friends and inspire others to start their mindfulness journey!',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textMediumEmphasisLight,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textGray,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // In a real app, this would trigger share functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                        'Share functionality would be implemented here'),
                    backgroundColor: AppTheme.accentBlue,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentBlue,
                foregroundColor: AppTheme.primaryWhite,
              ),
              child: const Text('Share'),
            ),
          ],
        );
      },
    );
  }
}
