import 'package:flutter/material.dart';

/// Civix's Material theme. Kept deliberately calm and neutral — no red
/// vs. blue color coding anywhere near the argument panel, since color
/// itself can read as a side signal in political content.
class CivixTheme {
  static const _seed = Color(0xFF2E5C4E); // muted teal-green, party-neutral

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(seedColor: _seed, brightness: Brightness.light);
    return ThemeData(useMaterial3: true, colorScheme: scheme, textTheme: _textTheme(scheme));
  }

  static ThemeData dark() {
    final scheme = ColorScheme.fromSeed(seedColor: _seed, brightness: Brightness.dark);
    return ThemeData(useMaterial3: true, colorScheme: scheme, textTheme: _textTheme(scheme));
  }

  static TextTheme _textTheme(ColorScheme scheme) {
    return const TextTheme().apply(
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
    );
  }
}
