import 'package:flutter/material.dart';

import 'theme.dart';

/// Gives each story a colour and icon derived from its first topic, so a
/// brief reads as five distinct cards rather than five identical ones.
///
/// The mapping is keyed on **subject matter** (education, climate, courts),
/// never on political position, and the palette deliberately contains no
/// red/blue pair that could be read as party coding. Unknown topics hash
/// into the same accent ramp, so a topic the pipeline invents later still
/// gets a stable, sensible colour instead of a default grey.
class TopicStyle {
  const TopicStyle({required this.color, required this.icon, required this.label});

  final Color color;
  final IconData icon;
  final String label;

  static const _icons = <String, IconData>{
    'education': Icons.school_outlined,
    'climate': Icons.eco_outlined,
    'environment': Icons.eco_outlined,
    'health': Icons.favorite_outline,
    'healthcare': Icons.favorite_outline,
    'economy': Icons.trending_up,
    'labor': Icons.badge_outlined,
    'courts': Icons.gavel_outlined,
    'justice': Icons.gavel_outlined,
    'immigration': Icons.public_outlined,
    'foreign': Icons.public_outlined,
    'technology': Icons.memory_outlined,
    'privacy': Icons.lock_outline,
    'elections': Icons.how_to_vote_outlined,
    'housing': Icons.home_outlined,
    'transport': Icons.directions_bus_outlined,
    'energy': Icons.bolt_outlined,
    'defense': Icons.shield_outlined,
  };

  factory TopicStyle.forStory(List<String> topics) {
    final raw = topics.isEmpty ? 'politics' : topics.first;
    final key = raw.toLowerCase().trim();

    final icon = _icons.entries
            .firstWhere(
              (e) => key.contains(e.key),
              orElse: () => const MapEntry('', Icons.article_outlined),
            )
            .value;

    // Stable hash so the same topic always gets the same accent, across
    // launches and across briefs.
    final hash = key.codeUnits.fold<int>(7, (a, b) => (a * 31 + b) & 0x7fffffff);
    final color = CivixTheme.accents[hash % CivixTheme.accents.length];

    return TopicStyle(color: color, icon: icon, label: _titleCase(raw));
  }

  static String _titleCase(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }
}

/// A small pill showing the topic, used on story cards and archive rows.
class TopicChip extends StatelessWidget {
  const TopicChip({super.key, required this.style, this.compact = false});

  final TopicStyle style;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: compact ? 10 : 12, vertical: compact ? 5 : 7),
      decoration: BoxDecoration(
        color: style.color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: style.color.withValues(alpha: 0.45)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(style.icon, size: compact ? 13 : 15, color: style.color),
          const SizedBox(width: 6),
          Text(
            style.label,
            style: TextStyle(
              color: style.color,
              fontWeight: FontWeight.w800,
              fontSize: compact ? 11 : 12.5,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
