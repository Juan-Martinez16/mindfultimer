import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoAnimationController;
  late AnimationController _loadingAnimationController;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _loadingAnimation;

  bool _isInitialized = false;
  String _loadingText = "Initializing...";

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _initializeApp();
  }

  void _setupAnimations() {
    _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _loadingAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _logoFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.easeInOut,
    ));

    _loadingAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _loadingAnimationController,
      curve: Curves.easeInOut,
    ));

    _logoAnimationController.forward();

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        _loadingAnimationController.forward();
      }
    });
  }

  Future<void> _initializeApp() async {
    try {
      // Hide system status bar for immersive experience
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

      // Initialize SharedPreferences
      final prefs = await SharedPreferences.getInstance();

      // Simulate loading user streak data
      setState(() {
        _loadingText = "Loading meditation data...";
      });
      await Future.delayed(const Duration(milliseconds: 600));

      // Check if user has completed onboarding
      final bool hasCompletedOnboarding =
          prefs.getBool('has_completed_onboarding') ?? false;

      // Load user streak data
      setState(() {
        _loadingText = "Checking streak data...";
      });
      await Future.delayed(const Duration(milliseconds: 500));

      final int currentStreak = prefs.getInt('current_streak') ?? 0;
      final String? lastMeditationDate =
          prefs.getString('last_meditation_date');

      // Prepare bell sound files
      setState(() {
        _loadingText = "Preparing meditation sounds...";
      });
      await Future.delayed(const Duration(milliseconds: 400));

      // Initialize timer services
      setState(() {
        _loadingText = "Initializing timer services...";
      });
      await Future.delayed(const Duration(milliseconds: 300));

      setState(() {
        _isInitialized = true;
        _loadingText = "Ready for meditation";
      });

      // Wait for animations to complete
      await Future.delayed(const Duration(milliseconds: 500));

      // Navigate based on user state
      if (mounted) {
        _navigateToNextScreen(
            hasCompletedOnboarding, currentStreak, lastMeditationDate);
      }
    } catch (e) {
      // Handle initialization errors
      if (mounted) {
        _showErrorDialog();
      }
    }
  }

  void _navigateToNextScreen(bool hasCompletedOnboarding, int currentStreak,
      String? lastMeditationDate) {
    // Restore system UI before navigation
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    if (!hasCompletedOnboarding) {
      // First-time users see onboarding flow
      Navigator.pushReplacementNamed(context, '/onboarding-flow');
    } else {
      // Check if user needs to set up profile
      final prefs = SharedPreferences.getInstance();
      prefs.then((pref) {
        final String? userName = pref.getString('user_name');
        if (userName == null || userName.isEmpty) {
          Navigator.pushReplacementNamed(context, '/user-setup-screen');
        } else {
          // Existing users with active streaks go to timer setup
          Navigator.pushReplacementNamed(context, '/timer-setup-screen');
        }
      });
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.lightTheme.colorScheme.surface,
          title: Text(
            'Initialization Error',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          content: Text(
            'There was an error initializing the meditation app. Would you like to reset your data and try again?',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetAndRetry();
              },
              child: const Text('Reset & Retry'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _initializeApp();
              },
              child: const Text('Try Again'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _resetAndRetry() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      _initializeApp();
    } catch (e) {
      // If reset fails, navigate to onboarding
      Navigator.pushReplacementNamed(context, '/onboarding-flow');
    }
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _loadingAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBlack,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: AppTheme.primaryBlack,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Spacer to push content to center
              const Spacer(flex: 2),

              // Animated Logo Section
              AnimatedBuilder(
                animation: _logoFadeAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _logoFadeAnimation.value,
                    child: Transform.scale(
                      scale: 0.8 + (_logoFadeAnimation.value * 0.2),
                      child: _buildLogoSection(),
                    ),
                  );
                },
              ),

              SizedBox(height: 8.h),

              // Animated Loading Section
              AnimatedBuilder(
                animation: _loadingAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _loadingAnimation.value,
                    child: _buildLoadingSection(),
                  );
                },
              ),

              // Spacer to balance layout
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // App Logo with meditation-inspired iconography
        Container(
          width: 20.w,
          height: 20.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppTheme.primaryWhite.withValues(alpha: 0.3),
              width: 2,
            ),
          ),
          child: Center(
            child: CustomIconWidget(
              iconName: 'self_improvement',
              color: AppTheme.primaryWhite,
              size: 10.w,
            ),
          ),
        ),

        SizedBox(height: 4.h),

        // App Name
        Text(
          'MindfulTimer',
          style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
            color: AppTheme.primaryWhite,
            fontWeight: FontWeight.w300,
            letterSpacing: 2.0,
          ),
        ),

        SizedBox(height: 1.h),

        // App Tagline
        Text(
          'Find your inner peace',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.primaryWhite.withValues(alpha: 0.7),
            letterSpacing: 1.0,
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Loading Indicator
        SizedBox(
          width: 8.w,
          height: 8.w,
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation<Color>(
              AppTheme.primaryWhite.withValues(alpha: 0.8),
            ),
            backgroundColor: AppTheme.primaryWhite.withValues(alpha: 0.2),
          ),
        ),

        SizedBox(height: 3.h),

        // Loading Text
        Text(
          _loadingText,
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.primaryWhite.withValues(alpha: 0.6),
            letterSpacing: 0.5,
          ),
        ),

        SizedBox(height: 1.h),

        // Progress Dots
        _buildProgressDots(),
      ],
    );
  }

  Widget _buildProgressDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _loadingAnimationController,
          builder: (context, child) {
            final double animationValue =
                (_loadingAnimationController.value * 3) - index;
            final double opacity = animationValue.clamp(0.0, 1.0);

            return Container(
              margin: EdgeInsets.symmetric(horizontal: 1.w),
              width: 1.5.w,
              height: 1.5.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primaryWhite
                    .withValues(alpha: 0.3 + (opacity * 0.4)),
              ),
            );
          },
        );
      }),
    );
  }
}
