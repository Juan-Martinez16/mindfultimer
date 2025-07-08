import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import './widgets/bell_sound_selector_widget.dart';
import './widgets/duration_selector_widget.dart';
import './widgets/start_meditation_button_widget.dart';
import './widgets/streak_counter_widget.dart';

class TimerSetupScreen extends StatefulWidget {
  const TimerSetupScreen({Key? key}) : super(key: key);

  @override
  State<TimerSetupScreen> createState() => _TimerSetupScreenState();
}

class _TimerSetupScreenState extends State<TimerSetupScreen> {
  int selectedDuration = 5;
  String selectedBellSound = 'Gentle Bell';
  int currentStreak = 0;

  final List<Map<String, dynamic>> bellSounds = [
    {
      "id": 1,
      "name": "Gentle Bell",
      "description": "Soft and calming bell tone",
      "waveform":
          "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400&h=100&fit=crop",
      "audioUrl": "assets/sounds/gentle_bell.mp3",
    },
    {
      "id": 2,
      "name": "Tibetan Bowl",
      "description": "Deep resonant singing bowl",
      "waveform":
          "https://images.unsplash.com/photo-1511379938547-c1f69419868d?w=400&h=100&fit=crop",
      "audioUrl": "assets/sounds/tibetan_bowl.mp3",
    },
    {
      "id": 3,
      "name": "Nature Chime",
      "description": "Peaceful wind chime sound",
      "waveform":
          "https://images.unsplash.com/photo-1518837695005-2083093ee35b?w=400&h=100&fit=crop",
      "audioUrl": "assets/sounds/nature_chime.mp3",
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadSavedPreferences();
    _loadStreakData();
  }

  Future<void> _loadSavedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedDuration = prefs.getInt('selected_duration') ?? 5;
      selectedBellSound =
          prefs.getString('selected_bell_sound') ?? 'Gentle Bell';
    });
  }

  Future<void> _loadStreakData() async {
    final prefs = await SharedPreferences.getInstance();
    final lastMeditationDate = prefs.getString('last_meditation_date');
    final streakCount = prefs.getInt('streak_count') ?? 0;

    if (lastMeditationDate != null) {
      final lastDate = DateTime.parse(lastMeditationDate);
      final today = DateTime.now();
      final difference = today.difference(lastDate).inDays;

      if (difference == 1) {
        // Continue streak
        setState(() {
          currentStreak = streakCount;
        });
      } else if (difference == 0) {
        // Same day
        setState(() {
          currentStreak = streakCount;
        });
      } else {
        // Reset streak
        setState(() {
          currentStreak = 0;
        });
        await prefs.setInt('streak_count', 0);
      }
    }
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selected_duration', selectedDuration);
    await prefs.setString('selected_bell_sound', selectedBellSound);
  }

  void _onDurationChanged(int duration) {
    setState(() {
      selectedDuration = duration;
    });
    _savePreferences();
  }

  void _onBellSoundChanged(String soundName) {
    setState(() {
      selectedBellSound = soundName;
    });
    _savePreferences();
  }

  void _startMeditation() {
    Navigator.pushNamed(
      context,
      '/active-meditation-screen',
      arguments: {
        'duration': selectedDuration,
        'bellSound': selectedBellSound,
      },
    );
  }

  Future<void> _refreshStreak() async {
    await _loadStreakData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshStreak,
          color: AppTheme.accentBlue,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Streak Counter
                    StreakCounterWidget(
                      streakCount: currentStreak,
                    ),

                    SizedBox(height: 4.h),

                    // Duration Selector
                    DurationSelectorWidget(
                      selectedDuration: selectedDuration,
                      onDurationChanged: _onDurationChanged,
                    ),

                    SizedBox(height: 4.h),

                    // Bell Sound Selector
                    BellSoundSelectorWidget(
                      bellSounds: bellSounds,
                      selectedBellSound: selectedBellSound,
                      onBellSoundChanged: _onBellSoundChanged,
                    ),

                    SizedBox(height: 6.h),

                    // Start Meditation Button
                    StartMeditationButtonWidget(
                      onPressed: _startMeditation,
                    ),

                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
