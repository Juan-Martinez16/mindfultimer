import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/circular_timer_widget.dart';
import './widgets/session_controls_widget.dart';
import './widgets/timer_display_widget.dart';

class ActiveMeditationScreen extends StatefulWidget {
  const ActiveMeditationScreen({Key? key}) : super(key: key);

  @override
  State<ActiveMeditationScreen> createState() => _ActiveMeditationScreenState();
}

class _ActiveMeditationScreenState extends State<ActiveMeditationScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _progressController;
  late AnimationController _pulseController;
  late Animation<double> _progressAnimation;
  late Animation<double> _pulseAnimation;

  Timer? _timer;
  int _totalDuration = 300; // 5 minutes default
  int _remainingTime = 300;
  bool _isPaused = false;
  bool _isCompleted = false;
  String _selectedBellSound = 'Bell 1';

  // Mock meditation session data
  final Map<String, dynamic> _sessionData = {
    "sessionId": "session_001",
    "startTime": DateTime.now(),
    "duration": 300,
    "bellSound": "Bell 1",
    "isActive": true,
    "pauseCount": 0,
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeAnimations();
    _setupSession();
    _startTimer();
    _hideSystemUI();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    _progressController.dispose();
    _pulseController.dispose();
    _showSystemUI();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        if (!_isPaused && !_isCompleted) {
          _pauseTimer();
        }
        break;
      case AppLifecycleState.resumed:
        if (_isPaused && !_isCompleted) {
          _resumeTimer();
        }
        break;
      default:
        break;
    }
  }

  void _initializeAnimations() {
    _progressController = AnimationController(
      duration: Duration(seconds: _totalDuration),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.linear,
    ));

    _pulseAnimation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _pulseController.repeat(reverse: true);
  }

  void _setupSession() {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      _totalDuration = args['duration'] ?? 300;
      _remainingTime = _totalDuration;
      _selectedBellSound = args['bellSound'] ?? 'Bell 1';

      _sessionData['duration'] = _totalDuration;
      _sessionData['bellSound'] = _selectedBellSound;
    }
  }

  void _startTimer() {
    _progressController.forward();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused && !_isCompleted) {
        setState(() {
          _remainingTime--;
          if (_remainingTime <= 0) {
            _completeSession();
          }
        });
      }
    });
  }

  void _pauseTimer() {
    setState(() {
      _isPaused = true;
      _sessionData['pauseCount'] = (_sessionData['pauseCount'] as int) + 1;
    });
    _progressController.stop();
    HapticFeedback.lightImpact();
  }

  void _resumeTimer() {
    setState(() {
      _isPaused = false;
    });
    _progressController.forward();
    HapticFeedback.lightImpact();
  }

  void _completeSession() {
    setState(() {
      _isCompleted = true;
      _remainingTime = 0;
    });

    _timer?.cancel();
    _progressController.stop();
    _pulseController.stop();

    // Play bell sound and vibrate
    HapticFeedback.heavyImpact();
    _playBellSound();

    // Navigate to completion screen after a brief delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          '/session-complete-screen',
          arguments: {
            'duration': _totalDuration,
            'completedAt': DateTime.now(),
            'bellSound': _selectedBellSound,
            'pauseCount': _sessionData['pauseCount'],
          },
        );
      }
    });
  }

  void _endSessionEarly() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.lightTheme.colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'End Session Early?',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
          ),
          content: Text(
            'Are you sure you want to end your meditation session early?',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Continue',
                style: TextStyle(color: AppTheme.accentBlue),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(
                  context,
                  '/timer-setup-screen',
                );
              },
              child: Text(
                'End Session',
                style: TextStyle(color: AppTheme.warningAmber),
              ),
            ),
          ],
        );
      },
    );
  }

  void _playBellSound() {
    // Mock bell sound playback
    print('Playing bell sound: $_selectedBellSound');
  }

  void _hideSystemUI() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  void _showSystemUI() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBlack,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppTheme.primaryBlack,
                AppTheme.primaryBlack.withValues(alpha: 0.8),
                AppTheme.primaryBlack,
              ],
            ),
          ),
          child: Column(
            children: [
              // Header with session info
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIconWidget(
                      iconName: 'self_improvement',
                      color: AppTheme.accentBlue,
                      size: 6.w,
                    ),
                    Text(
                      'Meditation Session',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        color: AppTheme.primaryWhite,
                        fontSize: 14.sp,
                      ),
                    ),
                    GestureDetector(
                      onLongPress: _endSessionEarly,
                      child: CustomIconWidget(
                        iconName: 'close',
                        color: AppTheme.primaryWhite.withValues(alpha: 0.6),
                        size: 6.w,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 4.h),

              // Main timer section
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Circular timer with animation
                    AnimatedBuilder(
                      animation: Listenable.merge(
                          [_progressAnimation, _pulseAnimation]),
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _pulseAnimation.value,
                          child: CircularTimerWidget(
                            progress: _progressAnimation.value,
                            size: 60.w,
                            strokeWidth: 1.5.w,
                            backgroundColor:
                                AppTheme.textGray.withValues(alpha: 0.3),
                            progressColor: _isCompleted
                                ? AppTheme.successGreen
                                : AppTheme.accentBlue,
                            child: TimerDisplayWidget(
                              timeText: _formatTime(_remainingTime),
                              isCompleted: _isCompleted,
                              isPaused: _isPaused,
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 6.h),

                    // Session duration info
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: AppTheme.textGray.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppTheme.textGray.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomIconWidget(
                            iconName: 'timer',
                            color: AppTheme.accentBlue,
                            size: 5.w,
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            'Session: ${_formatTime(_totalDuration)}',
                            style: AppTheme.dataTextStyle(
                              isLight: false,
                              fontSize: 12.sp,
                            ).copyWith(
                              color:
                                  AppTheme.primaryWhite.withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Session controls
              SessionControlsWidget(
                isPaused: _isPaused,
                isCompleted: _isCompleted,
                onPause: _pauseTimer,
                onResume: _resumeTimer,
                onEnd: _endSessionEarly,
              ),

              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }
}
