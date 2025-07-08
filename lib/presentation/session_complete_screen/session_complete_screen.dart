import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import './widgets/action_buttons_widget.dart';
import './widgets/celebration_animation_widget.dart';
import './widgets/streak_calendar_widget.dart';
import './widgets/streak_display_widget.dart';

class SessionCompleteScreen extends StatefulWidget {
  const SessionCompleteScreen({Key? key}) : super(key: key);

  @override
  State<SessionCompleteScreen> createState() => _SessionCompleteScreenState();
}

class _SessionCompleteScreenState extends State<SessionCompleteScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  String userName = '';
  int sessionDuration = 0;
  int currentStreak = 0;
  List<bool> recentMeditationDays = [];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadUserData();
    _updateStreakData();
    _setupAutoTimeout();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _fadeController.forward();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name') ?? 'Meditator';
      sessionDuration = prefs.getInt('last_session_duration') ?? 5;
      currentStreak = prefs.getInt('current_streak') ?? 1;
    });
  }

  Future<void> _updateStreakData() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now();
    final lastMeditationDate = prefs.getString('last_meditation_date');

    if (lastMeditationDate != null) {
      final lastDate = DateTime.parse(lastMeditationDate);
      final daysDifference = today.difference(lastDate).inDays;

      if (daysDifference == 1) {
        // Consecutive day - increment streak
        currentStreak = (prefs.getInt('current_streak') ?? 0) + 1;
      } else if (daysDifference > 1) {
        // Missed days - reset streak
        currentStreak = 1;
      }
      // Same day - keep current streak
    } else {
      // First meditation
      currentStreak = 1;
    }

    // Save updated data
    await prefs.setInt('current_streak', currentStreak);
    await prefs.setString('last_meditation_date', today.toIso8601String());
    await prefs.setInt(
        'total_sessions', (prefs.getInt('total_sessions') ?? 0) + 1);

    // Update recent meditation days (last 7 days)
    _updateRecentMeditationDays();
  }

  void _updateRecentMeditationDays() {
    final today = DateTime.now();
    recentMeditationDays = List.generate(7, (index) {
      final date = today.subtract(Duration(days: 6 - index));
      return _hasMeditatedOnDate(date);
    });
    setState(() {});
  }

  bool _hasMeditatedOnDate(DateTime date) {
    // Simplified logic - in real app, would check stored meditation history
    final today = DateTime.now();
    final daysDifference = today.difference(date).inDays;

    if (daysDifference == 0) return true; // Today's session
    if (daysDifference <= currentStreak - 1) return true;

    return false;
  }

  void _setupAutoTimeout() {
    Future.delayed(const Duration(seconds: 30), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/timer-setup-screen');
      }
    });
  }

  void _onMeditateAgain() {
    Navigator.pushReplacementNamed(context, '/timer-setup-screen');
  }

  void _onDone() {
    Navigator.pushReplacementNamed(context, '/timer-setup-screen');
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
            child: Column(
              children: [
                // Celebration Animation
                SizedBox(height: 2.h),
                CelebrationAnimationWidget(
                  controller: _fadeController,
                ),

                SizedBox(height: 4.h),

                // Personalized Headline
                Text(
                  'Well done, $userName!',
                  style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                    color: AppTheme.accentBlue,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 1.h),

                // Session Duration
                Text(
                  'You meditated for $sessionDuration minutes',
                  style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                    color: AppTheme.textGray,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 4.h),

                // Streak Display
                StreakDisplayWidget(
                  currentStreak: currentStreak,
                ),

                SizedBox(height: 3.h),

                // Encouraging Message
                Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: AppTheme.lightBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    currentStreak >= 7
                        ? 'Amazing consistency! Regular meditation strengthens your mind and reduces stress.'
                        : 'Keep going! Consistency is key to experiencing the full benefits of meditation.',
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.secondaryBlue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 3.h),

                // Streak Calendar
                StreakCalendarWidget(
                  recentMeditationDays: recentMeditationDays,
                ),

                const Spacer(),

                // Action Buttons
                ActionButtonsWidget(
                  onMeditateAgain: _onMeditateAgain,
                  onDone: _onDone,
                ),

                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
