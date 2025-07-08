import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class OnboardingPageWidget extends StatelessWidget {
  final String title;
  final String description;
  final String illustration;
  final String iconName;

  const OnboardingPageWidget({
    super.key,
    required this.title,
    required this.description,
    required this.illustration,
    required this.iconName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration container
          Container(
            width: 70.w,
            height: 35.h,
            decoration: BoxDecoration(
              color: AppTheme.lightBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppTheme.borderGray.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background illustration
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CustomImageWidget(
                    imageUrl: illustration,
                    width: 70.w,
                    height: 35.h,
                    fit: BoxFit.cover,
                  ),
                ),

                // Overlay with icon
                Container(
                  width: 70.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppTheme.primaryBlack.withValues(alpha: 0.3),
                  ),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryWhite.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                      ),
                      child: CustomIconWidget(
                        iconName: iconName,
                        color: AppTheme.accentBlue,
                        size: 12.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 6.h),

          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
              color: AppTheme.primaryBlack,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),

          SizedBox(height: 3.h),

          // Description
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                color: AppTheme.textGray,
                height: 1.5,
              ),
            ),
          ),

          SizedBox(height: 4.h),

          // Feature highlights (subtle visual elements)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFeaturePoint('Mindful'),
              _buildFeaturePoint('Consistent'),
              _buildFeaturePoint('Personal'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturePoint(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.lightBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.accentBlue.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
          color: AppTheme.accentBlue,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
