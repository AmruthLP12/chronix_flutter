import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/chronix_app_bar.dart';
import '../../widgets/chronix_button.dart';
import '../../widgets/chronix_card.dart';
import '../../widgets/chronix_input_field.dart';

class WhatsAppScreen extends StatefulWidget {
  const WhatsAppScreen({super.key});

  @override
  State<WhatsAppScreen> createState() => _WhatsAppScreenState();
}

class _WhatsAppScreenState extends State<WhatsAppScreen> {
  final _phoneController = TextEditingController();
  String? _errorText;
  bool _isLaunching = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _handleOpenWhatsApp() async {
    final rawInput = _phoneController.text.trim();
    if (rawInput.isEmpty) {
      setState(() {
        _errorText = 'Please enter a phone number';
      });
      return;
    }

    // Strip non-digits
    var phone = rawInput.replaceAll(RegExp(r'\D'), '');

    // If 10-digit Indian number without country code
    if (phone.length == 10) {
      phone = '91$phone';
    }

    // Must be 12 digits starting with 91
    if (phone.length != 12 || !phone.startsWith('91')) {
      setState(() {
        _errorText = 'Please enter a valid 10-digit Indian phone number';
      });
      return;
    }

    setState(() {
      _errorText = null;
      _isLaunching = true;
    });

    final uri = Uri.parse('https://wa.me/$phone');

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && mounted) {
        _showErrorDialog('Unable to open WhatsApp on this device.');
      }
    } catch (_) {
      if (mounted) {
        _showErrorDialog('Unable to open WhatsApp.');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLaunching = false;
        });
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('WhatsApp Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const ChronixAppBar(
        title: 'WhatsApp',
        subtitle: 'Open a WhatsApp chat using a phone number',
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 16,
            bottom: MediaQuery.paddingOf(context).bottom + 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ChronixCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PHONE NUMBER',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ChronixInputField(
                      label: 'WhatsApp Number',
                      placeholder: '+91 98765 43210',
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      errorText: _errorText,
                      prefixIcon: const Icon(Icons.phone_outlined, size: 20),
                      onChanged: (_) {
                        if (_errorText != null) {
                          setState(() => _errorText = null);
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Enter or paste a phone number with or without the country code.',
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ChronixButton(
                text: 'Open WhatsApp',
                icon: Icons.chat_rounded,
                isLoading: _isLaunching,
                onPressed: _handleOpenWhatsApp,
              ),
              const SizedBox(height: 24),
              ChronixCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'HOW IT WORKS',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildStepRow(1, 'Enter or paste a phone number.', theme),
                    const SizedBox(height: 10),
                    _buildStepRow(2, 'Tap "Open WhatsApp".', theme),
                    const SizedBox(height: 10),
                    _buildStepRow(3, 'WhatsApp opens the chat for that number.', theme),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepRow(int number, String text, ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$number',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
