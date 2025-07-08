import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the meditation application.
/// Implements Mindful Minimalism design with Monochromatic Serenity color scheme.
class AppTheme {
  AppTheme._();

  // Monochromatic Serenity Color Palette
  static const Color primaryBlack = Color(0xFF000000);
  static const Color primaryWhite = Color(0xFFFFFFFF);
  static const Color accentBlue = Color(0xFF2196F3);
  static const Color secondaryBlue = Color(0xFF1976D2);
  static const Color lightBlue = Color(0xFFE3F2FD);
  static const Color textGray = Color(0xFF424242);
  static const Color borderGray = Color(0xFFE0E0E0);
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color warningAmber = Color(0xFFFF9800);
  static const Color surfaceGray = Color(0xFFF5F5F5);

  // Shadow colors for subtle elevation
  static const Color shadowLight = Color(0x0A000000);
  static const Color shadowDark = Color(0x0AFFFFFF);

  // Divider colors for minimal separation
  static const Color dividerLight = Color(0x1A000000);
  static const Color dividerDark = Color(0x1AFFFFFF);

  // Text emphasis levels for contemplative clarity
  static const Color textHighEmphasisLight = Color(0xDE000000); // 87% opacity
  static const Color textMediumEmphasisLight = Color(0x99000000); // 60% opacity
  static const Color textDisabledLight = Color(0x61000000); // 38% opacity

  static const Color textHighEmphasisDark = Color(0xDEFFFFFF); // 87% opacity
  static const Color textMediumEmphasisDark = Color(0x99FFFFFF); // 60% opacity
  static const Color textDisabledDark = Color(0x61FFFFFF); // 38% opacity

  /// Light theme optimized for meditation practice
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: accentBlue,
      onPrimary: primaryWhite,
      primaryContainer: lightBlue,
      onPrimaryContainer: secondaryBlue,
      secondary: secondaryBlue,
      onSecondary: primaryWhite,
      secondaryContainer: lightBlue,
      onSecondaryContainer: secondaryBlue,
      tertiary: successGreen,
      onTertiary: primaryWhite,
      tertiaryContainer: successGreen.withValues(alpha: 0.1),
      onTertiaryContainer: successGreen,
      error: warningAmber,
      onError: primaryWhite,
      surface: primaryWhite,
      onSurface: primaryBlack,
      onSurfaceVariant: textGray,
      outline: borderGray,
      outlineVariant: borderGray.withValues(alpha: 0.5),
      shadow: shadowLight,
      scrim: shadowLight,
      inverseSurface: primaryBlack,
      onInverseSurface: primaryWhite,
      inversePrimary: accentBlue,
    ),
    scaffoldBackgroundColor: primaryWhite,
    cardColor: surfaceGray,
    dividerColor: borderGray,

    // AppBar theme for minimal distraction
    appBarTheme: AppBarTheme(
      backgroundColor: primaryWhite,
      foregroundColor: primaryBlack,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: primaryBlack,
      ),
      iconTheme: const IconThemeData(color: primaryBlack),
    ),

    // Card theme with subtle elevation
    cardTheme: CardTheme(
      color: surfaceGray,
      elevation: 2.0,
      shadowColor: shadowLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.all(8.0),
    ),

    // Bottom navigation for meditation app navigation
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: primaryWhite,
      selectedItemColor: accentBlue,
      unselectedItemColor: textGray,
      elevation: 4.0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Floating action button for primary meditation actions
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: accentBlue,
      foregroundColor: primaryWhite,
      elevation: 4.0,
      shape: CircleBorder(),
    ),

    // Button themes optimized for meditation interface
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: primaryWhite,
        backgroundColor: accentBlue,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        elevation: 2.0,
        shadowColor: shadowLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: accentBlue,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side: const BorderSide(color: accentBlue, width: 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: accentBlue,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    // Typography theme using Inter font family
    textTheme: _buildTextTheme(isLight: true),

    // Input decoration for meditation settings and forms
    inputDecorationTheme: InputDecorationTheme(
      fillColor: surfaceGray,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: borderGray, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: borderGray, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: accentBlue, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: warningAmber, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: warningAmber, width: 2.0),
      ),
      labelStyle: GoogleFonts.inter(
        color: textGray,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.inter(
        color: textMediumEmphasisLight,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Switch theme for meditation settings
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentBlue;
        }
        return borderGray;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentBlue.withValues(alpha: 0.3);
        }
        return borderGray.withValues(alpha: 0.3);
      }),
    ),

    // Checkbox theme for meditation preferences
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentBlue;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(primaryWhite),
      side: const BorderSide(color: borderGray, width: 2.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    ),

    // Radio theme for meditation options
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentBlue;
        }
        return borderGray;
      }),
    ),

    // Progress indicator for meditation timers
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: accentBlue,
      linearTrackColor: borderGray,
      circularTrackColor: borderGray,
    ),

    // Slider theme for meditation duration controls
    sliderTheme: SliderThemeData(
      activeTrackColor: accentBlue,
      thumbColor: accentBlue,
      overlayColor: accentBlue.withValues(alpha: 0.2),
      inactiveTrackColor: borderGray,
      trackHeight: 4.0,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
    ),

    // Tab bar theme for meditation categories
    tabBarTheme: TabBarTheme(
      labelColor: accentBlue,
      unselectedLabelColor: textGray,
      indicatorColor: accentBlue,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Tooltip theme for meditation guidance
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: primaryBlack.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8.0),
      ),
      textStyle: GoogleFonts.inter(
        color: primaryWhite,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),

    // SnackBar theme for meditation feedback
    snackBarTheme: SnackBarThemeData(
      backgroundColor: primaryBlack,
      contentTextStyle: GoogleFonts.inter(
        color: primaryWhite,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: accentBlue,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4.0,
    ), dialogTheme: DialogThemeData(backgroundColor: primaryWhite),
  );

  /// Dark theme optimized for evening meditation sessions
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: accentBlue,
      onPrimary: primaryBlack,
      primaryContainer: secondaryBlue,
      onPrimaryContainer: primaryWhite,
      secondary: secondaryBlue,
      onSecondary: primaryWhite,
      secondaryContainer: secondaryBlue.withValues(alpha: 0.3),
      onSecondaryContainer: primaryWhite,
      tertiary: successGreen,
      onTertiary: primaryBlack,
      tertiaryContainer: successGreen.withValues(alpha: 0.2),
      onTertiaryContainer: successGreen,
      error: warningAmber,
      onError: primaryBlack,
      surface: primaryBlack,
      onSurface: primaryWhite,
      onSurfaceVariant: textGray,
      outline: textGray,
      outlineVariant: textGray.withValues(alpha: 0.5),
      shadow: shadowDark,
      scrim: shadowDark,
      inverseSurface: primaryWhite,
      onInverseSurface: primaryBlack,
      inversePrimary: accentBlue,
    ),
    scaffoldBackgroundColor: primaryBlack,
    cardColor: textGray.withValues(alpha: 0.1),
    dividerColor: textGray.withValues(alpha: 0.3),

    // AppBar theme for dark meditation interface
    appBarTheme: AppBarTheme(
      backgroundColor: primaryBlack,
      foregroundColor: primaryWhite,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: primaryWhite,
      ),
      iconTheme: const IconThemeData(color: primaryWhite),
    ),

    // Card theme with subtle dark elevation
    cardTheme: CardTheme(
      color: textGray.withValues(alpha: 0.1),
      elevation: 2.0,
      shadowColor: shadowDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.all(8.0),
    ),

    // Bottom navigation for dark mode
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: primaryBlack,
      selectedItemColor: accentBlue,
      unselectedItemColor: textGray,
      elevation: 4.0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Floating action button for dark theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: accentBlue,
      foregroundColor: primaryBlack,
      elevation: 4.0,
      shape: CircleBorder(),
    ),

    // Button themes for dark meditation interface
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: primaryBlack,
        backgroundColor: accentBlue,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        elevation: 2.0,
        shadowColor: shadowDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: accentBlue,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side: const BorderSide(color: accentBlue, width: 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: accentBlue,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    // Typography theme for dark mode
    textTheme: _buildTextTheme(isLight: false),

    // Input decoration for dark meditation interface
    inputDecorationTheme: InputDecorationTheme(
      fillColor: textGray.withValues(alpha: 0.1),
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide:
            BorderSide(color: textGray.withValues(alpha: 0.5), width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide:
            BorderSide(color: textGray.withValues(alpha: 0.5), width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: accentBlue, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: warningAmber, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: warningAmber, width: 2.0),
      ),
      labelStyle: GoogleFonts.inter(
        color: textGray,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.inter(
        color: textMediumEmphasisDark,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Switch theme for dark settings
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentBlue;
        }
        return textGray;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentBlue.withValues(alpha: 0.3);
        }
        return textGray.withValues(alpha: 0.3);
      }),
    ),

    // Checkbox theme for dark preferences
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentBlue;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(primaryBlack),
      side: BorderSide(color: textGray.withValues(alpha: 0.5), width: 2.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    ),

    // Radio theme for dark options
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentBlue;
        }
        return textGray;
      }),
    ),

    // Progress indicator for dark timers
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: accentBlue,
      linearTrackColor: textGray.withValues(alpha: 0.3),
      circularTrackColor: textGray.withValues(alpha: 0.3),
    ),

    // Slider theme for dark controls
    sliderTheme: SliderThemeData(
      activeTrackColor: accentBlue,
      thumbColor: accentBlue,
      overlayColor: accentBlue.withValues(alpha: 0.2),
      inactiveTrackColor: textGray.withValues(alpha: 0.3),
      trackHeight: 4.0,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
    ),

    // Tab bar theme for dark categories
    tabBarTheme: TabBarTheme(
      labelColor: accentBlue,
      unselectedLabelColor: textGray,
      indicatorColor: accentBlue,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Tooltip theme for dark guidance
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: primaryWhite.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8.0),
      ),
      textStyle: GoogleFonts.inter(
        color: primaryBlack,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),

    // SnackBar theme for dark feedback
    snackBarTheme: SnackBarThemeData(
      backgroundColor: primaryWhite,
      contentTextStyle: GoogleFonts.inter(
        color: primaryBlack,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: accentBlue,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4.0,
    ), dialogTheme: DialogThemeData(backgroundColor: primaryBlack),
  );

  /// Helper method to build text theme optimized for meditation interface
  static TextTheme _buildTextTheme({required bool isLight}) {
    final Color textHighEmphasis =
        isLight ? textHighEmphasisLight : textHighEmphasisDark;
    final Color textMediumEmphasis =
        isLight ? textMediumEmphasisLight : textMediumEmphasisDark;
    final Color textDisabled = isLight ? textDisabledLight : textDisabledDark;

    return TextTheme(
      // Display styles for meditation headers
      displayLarge: GoogleFonts.inter(
        fontSize: 96,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
        letterSpacing: -1.5,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 60,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
        letterSpacing: -0.5,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 48,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
      ),

      // Headline styles for meditation sections
      headlineLarge: GoogleFonts.inter(
        fontSize: 40,
        fontWeight: FontWeight.w500,
        color: textHighEmphasis,
        letterSpacing: 0.25,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: textHighEmphasis,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: textHighEmphasis,
      ),

      // Title styles for meditation content
      titleLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textHighEmphasis,
        letterSpacing: 0.15,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textHighEmphasis,
        letterSpacing: 0.15,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textHighEmphasis,
        letterSpacing: 0.1,
      ),

      // Body styles for meditation descriptions
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
        letterSpacing: 0.5,
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
        letterSpacing: 0.25,
        height: 1.4,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textMediumEmphasis,
        letterSpacing: 0.4,
        height: 1.3,
      ),

      // Label styles for meditation controls
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textHighEmphasis,
        letterSpacing: 1.25,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textMediumEmphasis,
        letterSpacing: 0.4,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: textDisabled,
        letterSpacing: 1.5,
      ),
    );
  }

  /// Custom text style for meditation timer display using monospace font
  static TextStyle timerTextStyle(
      {required bool isLight, required double fontSize}) {
    return GoogleFonts.jetBrainsMono(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: isLight ? textHighEmphasisLight : textHighEmphasisDark,
      letterSpacing: 2.0,
    );
  }

  /// Custom text style for meditation data display
  static TextStyle dataTextStyle(
      {required bool isLight, required double fontSize}) {
    return GoogleFonts.jetBrainsMono(
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      color: isLight ? textHighEmphasisLight : textHighEmphasisDark,
      letterSpacing: 1.0,
    );
  }
}
