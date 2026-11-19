import 'package:flutter/material.dart';
import '../screens/age/age_screen.dart';
import '../screens/gratuity/gratuity_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/leave_salary/leave_salary_screen.dart';
import '../screens/service/service_screen.dart';
import '../screens/time/time_screen.dart';
import '../screens/whatsapp/whatsapp_screen.dart';

abstract final class AppRoutes {
  static const String home = '/';
  static const String whatsapp = '/whatsapp';
  static const String age = '/age';
  static const String time = '/time';
  static const String service = '/service';
  static const String leaveSalary = '/leave_salary';
  static const String gratuity = '/gratuity';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );
      case whatsapp:
        return MaterialPageRoute(
          builder: (_) => const WhatsAppScreen(),
          settings: settings,
        );
      case age:
        return MaterialPageRoute(
          builder: (_) => const AgeScreen(),
          settings: settings,
        );
      case time:
        return MaterialPageRoute(
          builder: (_) => const TimeScreen(),
          settings: settings,
        );
      case service:
        return MaterialPageRoute(
          builder: (_) => const ServiceScreen(),
          settings: settings,
        );
      case leaveSalary:
        return MaterialPageRoute(
          builder: (_) => const LeaveSalaryScreen(),
          settings: settings,
        );
      case gratuity:
        return MaterialPageRoute(
          builder: (_) => const GratuityScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Not Found')),
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
          settings: settings,
        );
    }
  }
}
