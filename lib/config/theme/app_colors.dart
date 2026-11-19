import 'package:flutter/material.dart';

/// Centralized color tokens for the Chronix Precision Utility System.
abstract final class AppColors {
  // Light Theme Palette
  static const Color lightBackground = Color(0xFFF8FAFC); // Slate 50
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceSubtle = Color(0xFFF1F5F9); // Slate 100
  static const Color lightBorder = Color(0xFFE2E8F0); // Slate 200
  static const Color lightBorderFocus = Color(0xFF2563EB); // Blue 600
  static const Color lightTextPrimary = Color(0xFF0F172A); // Slate 900
  static const Color lightTextSecondary = Color(0xFF475569); // Slate 600
  static const Color lightTextMuted = Color(0xFF94A3B8); // Slate 400
  static const Color lightPrimary = Color(0xFF2563EB); // Cobalt Blue
  static const Color lightPrimaryDark = Color(0xFF1D4ED8);
  static const Color lightPrimaryContainer = Color(0xFFEFF6FF);

  // Dark Theme Palette
  static const Color darkBackground = Color(0xFF0B0F19); // Midnight Charcoal
  static const Color darkSurface = Color(0xFF161E2E); // Deep Slate Navy
  static const Color darkSurfaceSubtle = Color(0xFF1E293B); // Slate 800
  static const Color darkBorder = Color(0x1FFFFFFF); // 12% White Hairline
  static const Color darkBorderFocus = Color(0xFF60A5FA); // Blue 400
  static const Color darkTextPrimary = Color(0xFFF8FAFC); // Slate 50
  static const Color darkTextSecondary = Color(0xFF94A3B8); // Slate 400
  static const Color darkTextMuted = Color(0xFF64748B); // Slate 500
  static const Color darkPrimary = Color(0xFF3B82F6); // Vibrant Blue
  static const Color darkPrimaryLight = Color(0xFF60A5FA);
  static const Color darkPrimaryContainer = Color(0x263B82F6);

  // Semantic Status Colors (Universal)
  static const Color success = Color(0xFF10B981); // Emerald 500
  static const Color successContainer = Color(0x1A10B981);
  static const Color warning = Color(0xFFF59E0B); // Amber 500
  static const Color warningContainer = Color(0x1AF59E0B);
  static const Color error = Color(0xFFEF4444); // Crimson 500
  static const Color errorContainer = Color(0x1AEF4444);
  static const Color info = Color(0xFF0EA5E9); // Sky 500

  // Category Colors
  static const Color catCommunication = Color(0xFF25D366); // WhatsApp Green
  static const Color catCalculators = Color(0xFF3B82F6); // Blue
  static const Color catDateTime = Color(0xFF8B5CF6); // Purple
  static const Color catFinance = Color(0xFF10B981); // Emerald
}
