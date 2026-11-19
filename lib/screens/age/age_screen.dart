import 'package:flutter/material.dart';
import '../../models/age_result.dart';
import '../../utils/date_calculators.dart';
import '../../utils/formatters.dart';
import '../../widgets/chronix_app_bar.dart';
import '../../widgets/chronix_button.dart';
import '../../widgets/chronix_card.dart';
import '../../widgets/chronix_date_field.dart';
import '../../widgets/chronix_section_header.dart';
import '../../widgets/chronix_stat_card.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  DateTime _fromDate = DateTime(2000, 1, 1);
  DateTime _toDate = DateTime.now();
  AgeResult? _result;

  void _handleCalculate() {
    if (_fromDate.isAfter(_toDate)) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Date Range'),
          content: const Text('Start Date cannot be greater than End Date.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    setState(() {
      _result = DateCalculators.calculateAge(_fromDate, _toDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const ChronixAppBar(
        title: 'Age Calculator',
        subtitle: 'Calculate precise intervals between dates',
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
                    const ChronixSectionHeader(title: 'Select Dates'),
                    const SizedBox(height: 14),
                    ChronixDateField(
                      label: 'Start Date',
                      date: _fromDate,
                      icon: Icons.calendar_today_rounded,
                      onDateSelected: (newDate) {
                        setState(() {
                          _fromDate = newDate;
                          _result = null; // Invalidate previous result
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    ChronixDateField(
                      label: 'End Date',
                      date: _toDate,
                      icon: Icons.event_available_rounded,
                      onDateSelected: (newDate) {
                        setState(() {
                          _toDate = newDate;
                          _result = null; // Invalidate previous result
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ChronixButton(
                text: 'Calculate Age',
                icon: Icons.calculate_outlined,
                onPressed: _handleCalculate,
              ),
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 250),
                crossFadeState: _result != null
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: _result != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 24),
                          const ChronixSectionHeader(title: 'Calculation Results'),
                          const SizedBox(height: 12),
                          ChronixStatGrid(
                            cards: [
                              ChronixStatCard(
                                value: _result!.years,
                                label: 'Years',
                                valueColor: theme.colorScheme.primary,
                              ),
                              ChronixStatCard(
                                value: _result!.months,
                                label: 'Months',
                                valueColor: theme.colorScheme.primary,
                              ),
                              ChronixStatCard(
                                value: _result!.days,
                                label: 'Days',
                                valueColor: theme.colorScheme.primary,
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          ChronixCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'TOTAL DURATION',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.8,
                                    color: theme.colorScheme.secondary,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  Formatters.number(_result!.totalDays),
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.5,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Total Elapsed Calendar Days',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: theme.colorScheme.secondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                secondChild: const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
