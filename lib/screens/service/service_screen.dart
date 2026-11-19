import 'package:flutter/material.dart';
import '../../models/service_result.dart';
import '../../utils/date_calculators.dart';
import '../../widgets/chronix_app_bar.dart';
import '../../widgets/chronix_button.dart';
import '../../widgets/chronix_card.dart';
import '../../widgets/chronix_date_field.dart';
import '../../widgets/chronix_section_header.dart';
import '../../widgets/chronix_stat_card.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  DateTime _joiningDate = DateTime.now();
  DateTime _retirementDate = DateTime.now();

  ServiceDuration? _overallService;
  ServiceDuration? _remainingService;

  void _handleCalculate() {
    final today = DateTime.now();
    final todayNormalized = DateTime(today.year, today.month, today.day);

    setState(() {
      _overallService = DateCalculators.calculateServiceDifference(
        _joiningDate,
        _retirementDate,
      );
      _remainingService = DateCalculators.calculateServiceDifference(
        todayNormalized,
        _retirementDate,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const ChronixAppBar(
        title: 'Service Calculator',
        subtitle: 'Calculate relative employment duration metrics',
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
                    const ChronixSectionHeader(title: 'Employment Dates'),
                    const SizedBox(height: 14),
                    ChronixDateField(
                      label: 'Date of Joining',
                      date: _joiningDate,
                      icon: Icons.work_outline_rounded,
                      onDateSelected: (newDate) {
                        setState(() {
                          _joiningDate = newDate;
                          _overallService = null;
                          _remainingService = null;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    ChronixDateField(
                      label: 'End Date / Retirement',
                      date: _retirementDate,
                      icon: Icons.flag_outlined,
                      onDateSelected: (newDate) {
                        setState(() {
                          _retirementDate = newDate;
                          _overallService = null;
                          _remainingService = null;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ChronixButton(
                text: 'Calculate Service',
                icon: Icons.assessment_outlined,
                onPressed: _handleCalculate,
              ),
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 250),
                crossFadeState: _overallService != null
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: _overallService != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 24),
                          const ChronixSectionHeader(title: 'Service Telemetry Results'),
                          const SizedBox(height: 12),

                          // Overall Service Card
                          ChronixCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.business_center_rounded,
                                      size: 16,
                                      color: theme.colorScheme.primary,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'OVERALL SERVICE DURATION',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.8,
                                        color: theme.colorScheme.secondary,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                ChronixStatGrid(
                                  cards: [
                                    ChronixStatCard(
                                      value: _overallService!.years,
                                      label: 'Years',
                                      valueColor: theme.colorScheme.primary,
                                    ),
                                    ChronixStatCard(
                                      value: _overallService!.months,
                                      label: 'Months',
                                      valueColor: theme.colorScheme.primary,
                                    ),
                                    ChronixStatCard(
                                      value: _overallService!.days,
                                      label: 'Days',
                                      valueColor: theme.colorScheme.primary,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Remaining Service Card (if different from overall service)
                          if (_remainingService != null && _remainingService != _overallService) ...[
                            const SizedBox(height: 14),
                            ChronixCard(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.hourglass_bottom_rounded,
                                        size: 16,
                                        color: theme.colorScheme.primary,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'REMAINING SERVICE TENURE',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.8,
                                          color: theme.colorScheme.secondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 14),
                                  ChronixStatGrid(
                                    cards: [
                                      ChronixStatCard(
                                        value: _remainingService!.years,
                                        label: 'Years',
                                        valueColor: theme.colorScheme.primary,
                                      ),
                                      ChronixStatCard(
                                        value: _remainingService!.months,
                                        label: 'Months',
                                        valueColor: theme.colorScheme.primary,
                                      ),
                                      ChronixStatCard(
                                        value: _remainingService!.days,
                                        label: 'Days',
                                        valueColor: theme.colorScheme.primary,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
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
