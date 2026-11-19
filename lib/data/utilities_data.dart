import 'package:flutter/material.dart';
import '../models/utility.dart';

abstract final class UtilitiesData {
  static const List<Utility> activeUtilities = [
    Utility(
      title: 'WhatsApp',
      description: 'Enter a phone number and open the corresponding WhatsApp chat directly.',
      route: '/whatsapp',
      icon: Icons.chat_bubble_outline_rounded,
      category: UtilityCategory.communication,
    ),
    Utility(
      title: 'Age Calculator',
      description: 'Precision time interval calculation. Compute years, months, weeks, and total days elapsed between two selected dates.',
      route: '/age',
      icon: Icons.calendar_month_outlined,
      category: UtilityCategory.calculators,
    ),
    Utility(
      title: 'Time Converter',
      description: 'Standard to military format conversion. Seamlessly shift formats between 12-hour AM/PM cycles and 24-hour logs.',
      route: '/time',
      icon: Icons.access_time_rounded,
      category: UtilityCategory.dateTime,
    ),
    Utility(
      title: 'Service Calculator',
      description: 'Calculate overall service duration and remaining tenure till retirement.',
      route: '/service',
      icon: Icons.badge_outlined,
      category: UtilityCategory.calculators,
    ),
    Utility(
      title: 'Salary Leave Calculator',
      description: 'Calculate leave salary. Supports basic pay, DA, and EL/HPL balances.',
      route: '/leave_salary',
      icon: Icons.account_balance_wallet_outlined,
      category: UtilityCategory.finance,
    ),
    Utility(
      title: 'Gratuity Details',
      description: 'Calculate gratuity based on basic pay, DA, service period, and GPF or NPS category.',
      route: '/gratuity',
      icon: Icons.currency_rupee_rounded,
      category: UtilityCategory.finance,
    ),
  ];

  static const List<Utility> upcomingUtilities = [
    Utility(
      title: 'Timezone Sync',
      description: 'Track relative offsets, clock conversions, and coordinates across international cities concurrently.',
      icon: Icons.public_rounded,
      category: UtilityCategory.dateTime,
      isActive: false,
      isComingSoon: true,
    ),
    Utility(
      title: 'Chrono Countdown',
      description: 'Visual stopwatches, precision loop interval timers, and custom helper alarms.',
      icon: Icons.timer_outlined,
      category: UtilityCategory.dateTime,
      isActive: false,
      isComingSoon: true,
    ),
  ];
}
