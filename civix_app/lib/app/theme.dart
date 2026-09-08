import 'package:flutter/material.dart';

/// Civix's Material theme.
///
/// The party-neutrality rule still holds and always will: **no red/blue
/// anywhere** — not in the palette, not in the accents, not near the
/// argument panel, because color itself reads as a side signal in
/// political content. What changed is that "neutral" no longer has to mean
/// "grey and quiet." The accents below are teal, violet, lime and amber:
/// high-energy, and none of them carries a partisan reading in a US
/// context.
class CivixTheme {
  /// Deep teal — the brand anchor. Party-neutral by construction.
  static const seed = Color(0xFF00A88E);

  /// Accent ramp used for topic chips, progress and celebration. Ordered
  /// so adjacent topics in a brief land on visibly different hues.
  static const accents = <Color>[
    Color(0xFF00C2A8), // teal
    Color(0xFF7C5CFF), // violet
    Color(0xFFFFB020), // amber
    Color(0xFF00B4D8), // cyan
    Color(0xFF9BE12E), // lime
    Color(0xFFFF7A45), // coral (warm, but not political red)
  ];

  /// Correct / incorrect feedback on the comprehension check. Green and
  /// amber rather than green and red — an incorrect answer is a nudge,
  /// not a failure, and red carries baggage we don't want in this app.
  static const correct = Color(0xFF00C26E);
  static const nudge = Color(0xFFFFB020);

  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: brightness,
    ).copyWith(
      primary: isDark ? const Color(0xFF2AE0BE) : const Color(0xFF00806D),
      secondary: const Color(0xFF7C5CFF),
      tertiary: const Color(0xFFFFB020),
      surface: isDark ? const Color(0xFF0E1513) : const Color(0xFFF6FBF8),
    );

    final base = ThemeData(useMaterial3: true, colorScheme: scheme);

    return base.copyWith(
      scaffoldBackgroundColor: scheme.surface,
      textTheme: _textTheme(base.textTheme, scheme),
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: scheme.onSurface,
          fontSize: 26,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.8,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.zero,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.2,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
          side: BorderSide(color: scheme.outlineVariant, width: 1.5),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: scheme.primary.withValues(alpha: 0.18),
        elevation: 0,
        height: 68,
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: scheme.onSurface),
        ),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
        side: BorderSide(color: scheme.outlineVariant),
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),
    );
  }

  /// Tighter tracking and heavier weights than Material's defaults. The
  /// headline sizes in particular are much larger — a story headline is
  /// the thing on screen, so it should read like a poster, not a label.
  static TextTheme _textTheme(TextTheme base, ColorScheme scheme) {
    return base
        .copyWith(
          displaySmall: base.displaySmall?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -1.5,
            height: 1.05,
          ),
          headlineLarge: base.headlineLarge?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -1.2,
            height: 1.1,
          ),
          headlineMedium: base.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.8,
            height: 1.15,
          ),
          headlineSmall: base.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
            height: 1.2,
          ),
          titleMedium: base.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          bodyLarge: base.bodyLarge?.copyWith(fontSize: 17, height: 1.5),
          bodyMedium: base.bodyMedium?.copyWith(height: 1.45),
          labelLarge: base.labelLarge?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: 0.6,
          ),
        )
        .apply(bodyColor: scheme.onSurface, displayColor: scheme.onSurface);
  }
}
