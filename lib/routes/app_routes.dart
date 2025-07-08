import 'package:flutter/material.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/onboarding_flow/onboarding_flow.dart';
import '../presentation/user_setup_screen/user_setup_screen.dart';
import '../presentation/active_meditation_screen/active_meditation_screen.dart';
import '../presentation/timer_setup_screen/timer_setup_screen.dart';
import '../presentation/session_complete_screen/session_complete_screen.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String splashScreen = '/splash-screen';
  static const String onboardingFlow = '/onboarding-flow';
  static const String userSetupScreen = '/user-setup-screen';
  static const String activeMeditationScreen = '/active-meditation-screen';
  static const String timerSetupScreen = '/timer-setup-screen';
  static const String sessionCompleteScreen = '/session-complete-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    splashScreen: (context) => const SplashScreen(),
    onboardingFlow: (context) => const OnboardingFlow(),
    userSetupScreen: (context) => const UserSetupScreen(),
    activeMeditationScreen: (context) => const ActiveMeditationScreen(),
    timerSetupScreen: (context) => const TimerSetupScreen(),
    sessionCompleteScreen: (context) => const SessionCompleteScreen(),
    // TODO: Add your other routes here
  };
}
