import 'package:flutter/material.dart';

/// Section Header with uppercase title and optional badge pill.
class ChronixSectionHeader extends StatelessWidget {
  final String title;
  final String? badge;
  final Color? badgeColor;

  const ChronixSectionHeader({
    super.key,
    required this.title,
    this.badge,
    this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0,
            color: theme.colorScheme.secondary,
          ),
        ),
        if (badge != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: badgeColor ?? theme.inputDecorationTheme.fillColor,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: theme.dividerColor, width: 0.8),
            ),
            child: Text(
              badge!,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.secondary,
                letterSpacing: 0.4,
              ),
            ),
          ),
      ],
    );
  }
}
