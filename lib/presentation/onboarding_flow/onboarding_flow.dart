import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/onboarding_page_widget.dart';
import './widgets/page_indicator_widget.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _onboardingData = [
    {
      "title": "Discover Inner Peace",
      "description":
          "Experience the transformative power of meditation. Reduce stress, improve focus, and cultivate mindfulness in your daily life.",
      "illustration":
          "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400&h=400&fit=crop&crop=center",
      "iconName": "self_improvement",
    },
    {
      "title": "Build Consistent Habits",
      "description":
          "Track your meditation journey with our streak counter. Stay motivated and build a lasting practice that transforms your well-being.",
      "illustration":
          "https://images.unsplash.com/photo-1499209974431-9dddcece7f88?w=400&h=400&fit=crop&crop=center",
      "iconName": "trending_up",
    },
    {
      "title": "Personalized Experience",
      "description":
          "Customize your meditation sessions with flexible timers, soothing bell sounds, and personalized encouragement messages.",
      "illustration":
          "https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=400&h=400&fit=crop&crop=center",
      "iconName": "tune",
    },
  ];

  void _nextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      HapticFeedback.lightImpact();
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToUserSetup();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      HapticFeedback.lightImpact();
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skipOnboarding() {
    HapticFeedback.lightImpact();
    _navigateToUserSetup();
  }

  void _navigateToUserSetup() {
    Navigator.pushReplacementNamed(context, '/user-setup-screen');
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _skipOnboarding,
                    child: Text(
                      'Skip',
                      style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                        color: AppTheme.accentBlue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // PageView content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                  HapticFeedback.selectionClick();
                },
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  return OnboardingPageWidget(
                    title: _onboardingData[index]["title"] as String,
                    description:
                        _onboardingData[index]["description"] as String,
                    illustration:
                        _onboardingData[index]["illustration"] as String,
                    iconName: _onboardingData[index]["iconName"] as String,
                  );
                },
              ),
            ),

            // Page indicators and navigation
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
              child: Column(
                children: [
                  // Page indicators
                  PageIndicatorWidget(
                    currentPage: _currentPage,
                    totalPages: _onboardingData.length,
                  ),

                  SizedBox(height: 4.h),

                  // Navigation buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back button
                      _currentPage > 0
                          ? TextButton(
                              onPressed: _previousPage,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomIconWidget(
                                    iconName: 'arrow_back_ios',
                                    color: AppTheme.accentBlue,
                                    size: 16,
                                  ),
                                  SizedBox(width: 1.w),
                                  Text(
                                    'Back',
                                    style: AppTheme
                                        .lightTheme.textTheme.bodyLarge
                                        ?.copyWith(
                                      color: AppTheme.accentBlue,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(width: 80),

                      // Progress indicator
                      Text(
                        '${_currentPage + 1} of ${_onboardingData.length}',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textGray,
                        ),
                      ),

                      // Next/Get Started button
                      ElevatedButton(
                        onPressed: _nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.accentBlue,
                          foregroundColor: AppTheme.primaryWhite,
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 1.5.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _currentPage == _onboardingData.length - 1
                                  ? 'Get Started'
                                  : 'Next',
                              style: AppTheme.lightTheme.textTheme.bodyLarge
                                  ?.copyWith(
                                color: AppTheme.primaryWhite,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (_currentPage < _onboardingData.length - 1) ...[
                              SizedBox(width: 1.w),
                              CustomIconWidget(
                                iconName: 'arrow_forward_ios',
                                color: AppTheme.primaryWhite,
                                size: 16,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
