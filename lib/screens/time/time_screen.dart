import 'package:flutter/material.dart';
import '../../models/time_result.dart';
import '../../utils/time_calculators.dart';
import '../../widgets/chronix_app_bar.dart';
import '../../widgets/chronix_button.dart';
import '../../widgets/chronix_card.dart';
import '../../widgets/chronix_numeric_input.dart';
import '../../widgets/chronix_section_header.dart';
import '../../widgets/chronix_segmented_control.dart';

class TimeScreen extends StatefulWidget {
  const TimeScreen({super.key});

  @override
  State<TimeScreen> createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  // 24 to 12 state
  final _hour24Controller = TextEditingController();
  final _minute24Controller = TextEditingController();
  TimeResult? _result12;

  // 12 to 24 state
  final _hour12Controller = TextEditingController();
  final _minute12Controller = TextEditingController();
  String _period = 'AM';
  TimeResult? _result24;

  @override
  void dispose() {
    _hour24Controller.dispose();
    _minute24Controller.dispose();
    _hour12Controller.dispose();
    _minute12Controller.dispose();
    super.dispose();
  }

  void _convert24To12() {
    setState(() {
      _result12 = TimeCalculators.convert24To12(
        _hour24Controller.text,
        _minute24Controller.text,
      );
    });
  }

  void _convert12To24() {
    setState(() {
      _result24 = TimeCalculators.convert12To24(
        _hour12Controller.text,
        _minute12Controller.text,
        _period,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const ChronixAppBar(
        title: 'Time Converter',
        subtitle: 'Format-shift temporal layouts in real-time',
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
              // 24 to 12 Hour Card
              ChronixCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ChronixSectionHeader(title: '24 → 12 Hour Format'),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        ChronixNumericInput(
                          label: 'Hours (0-23)',
                          placeholder: '14',
                          controller: _hour24Controller,
                          onChanged: (_) {
                            if (_result12 != null) setState(() => _result12 = null);
                          },
                        ),
                        const SizedBox(width: 12),
                        ChronixNumericInput(
                          label: 'Minutes (0-59)',
                          placeholder: '30',
                          controller: _minute24Controller,
                          onChanged: (_) {
                            if (_result12 != null) setState(() => _result12 = null);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ChronixButton(
                      text: 'Convert to 12-Hour',
                      icon: Icons.transform_rounded,
                      onPressed: _convert24To12,
                    ),
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 250),
                      crossFadeState: _result12 != null
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      firstChild: _result12 != null
                          ? Padding(
                              padding: const EdgeInsets.only(top: 14),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: theme.inputDecorationTheme.fillColor,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: theme.dividerColor, width: 1),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'STANDARD RESULT',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.8,
                                        color: theme.colorScheme.secondary,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _result12!.isValid
                                          ? _result12!.formatted
                                          : _result12!.errorMessage!,
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800,
                                        color: _result12!.isValid
                                            ? theme.colorScheme.primary
                                            : theme.colorScheme.error,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      secondChild: const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 12 to 24 Hour Card
              ChronixCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ChronixSectionHeader(title: '12 → 24 Hour Format'),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        ChronixNumericInput(
                          label: 'Hours (1-12)',
                          placeholder: '02',
                          controller: _hour12Controller,
                          onChanged: (_) {
                            if (_result24 != null) setState(() => _result24 = null);
                          },
                        ),
                        const SizedBox(width: 12),
                        ChronixNumericInput(
                          label: 'Minutes (0-59)',
                          placeholder: '30',
                          controller: _minute12Controller,
                          onChanged: (_) {
                            if (_result24 != null) setState(() => _result24 = null);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'SELECT PERIOD',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    ChronixSegmentedControl<String>(
                      items: const ['AM', 'PM'],
                      selectedItem: _period,
                      labelBuilder: (item) => item,
                      onSelected: (val) {
                        setState(() {
                          _period = val;
                          _result24 = null;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    ChronixButton(
                      text: 'Convert to 24-Hour',
                      icon: Icons.transform_rounded,
                      onPressed: _convert12To24,
                    ),
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 250),
                      crossFadeState: _result24 != null
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      firstChild: _result24 != null
                          ? Padding(
                              padding: const EdgeInsets.only(top: 14),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: theme.inputDecorationTheme.fillColor,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: theme.dividerColor, width: 1),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'MILITARY RESULT',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.8,
                                        color: theme.colorScheme.secondary,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _result24!.isValid
                                          ? _result24!.formatted
                                          : _result24!.errorMessage!,
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800,
                                        color: _result24!.isValid
                                            ? theme.colorScheme.primary
                                            : theme.colorScheme.error,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      secondChild: const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
