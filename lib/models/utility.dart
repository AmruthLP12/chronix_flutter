import 'package:flutter/material.dart';

enum UtilityCategory {
  all('All'),
  communication('Communication'),
  calculators('Calculators'),
  dateTime('Date & Time'),
  finance('Finance');

  final String label;
  const UtilityCategory(this.label);
}

/// Metadata model for a Chronix utility.
final class Utility {
  final String title;
  final String description;
  final String? route;
  final IconData icon;
  final UtilityCategory category;
  final bool isActive;
  final bool isComingSoon;

  const Utility({
    required this.title,
    required this.description,
    this.route,
    required this.icon,
    required this.category,
    this.isActive = true,
    this.isComingSoon = false,
  });
}
