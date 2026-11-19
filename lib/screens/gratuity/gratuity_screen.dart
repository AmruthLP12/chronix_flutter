import 'package:flutter/material.dart';
import '../../models/gratuity_result.dart';
import '../../utils/financial_calculators.dart';
import '../../utils/formatters.dart';
import '../../widgets/chronix_app_bar.dart';
import '../../widgets/chronix_button.dart';
import '../../widgets/chronix_card.dart';
import '../../widgets/chronix_date_field.dart';
import '../../widgets/chronix_input_field.dart';
import '../../widgets/chronix_result_card.dart';
import '../../widgets/chronix_section_header.dart';
import '../../widgets/chronix_segmented_control.dart';
import '../../widgets/chronix_stat_card.dart';

class GratuityScreen extends StatefulWidget {
  const GratuityScreen({super.key});

  @override
  State<GratuityScreen> createState() => _GratuityScreenState();
}

class _GratuityScreenState extends State<GratuityScreen> {
  final _basicPayController = TextEditingController();
  final _daPercentController = TextEditingController();

  GratuityCategory _category = GratuityCategory.gpf;
  DateTime _joiningDate = DateTime(2014, 3, 14);
  DateTime _calculationDate = DateTime.now();

  GratuityResult? _result;

  @override
  void dispose() {
    _basicPayController.dispose();
    _daPercentController.dispose();
    super.dispose();
  }

  void _handleCalculate() {
    final basicStr = _basicPayController.text.trim();
    final daStr = _daPercentController.text.trim();

    if (basicStr.isEmpty || daStr.isEmpty) {
      _showAlert('Missing Details', 'Please fill in Basic Pay and DA percentage.');
      return;
    }

    final basic = double.tryParse(basicStr);
    final da = double.tryParse(daStr);

    if (basic == null || da == null) {
      _showAlert('Invalid Values', 'Please enter valid salary values.');
      return;
    }

    if (basic < 0 || da < 0) {
      _showAlert('Invalid Input', 'Salary values cannot be negative.');
      return;
    }

    if (_calculationDate.isBefore(_joiningDate)) {
      _showAlert('Invalid Dates', 'Calculation/Retirement date cannot be before joining date.');
      return;
    }

    setState(() {
      _result = FinancialCalculators.calculateGratuity(
        basicPay: basic,
        daPercent: da,
        category: _category,
        joiningDate: _joiningDate,
        calculationDate: _calculationDate,
      );
    });
  }

  void _showAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
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

  void _onFieldChanged() {
    if (_result != null) {
      setState(() => _result = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const ChronixAppBar(
        title: 'Gratuity Details',
        subtitle: 'Calculate terminal gratuity under GPF and NPS rules',
      ),
      body: GestureDetector(
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
                    const ChronixSectionHeader(title: 'Employee & Salary Details'),
                    const SizedBox(height: 14),
                    ChronixInputField(
                      label: 'Basic Pay (₹)',
                      placeholder: '44900',
                      controller: _basicPayController,
                      keyboardType: TextInputType.number,
                      prefixIcon: const Icon(Icons.currency_rupee_rounded, size: 18),
                      onChanged: (_) => _onFieldChanged(),
                    ),
                    const SizedBox(height: 12),
                    ChronixInputField(
                      label: 'Dearness Allowance (DA %)',
                      placeholder: '55',
                      controller: _daPercentController,
                      keyboardType: TextInputType.number,
                      prefixIcon: const Icon(Icons.percent_rounded, size: 18),
                      onChanged: (_) => _onFieldChanged(),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'PENSION / GRATUITY CATEGORY',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    ChronixSegmentedControl<GratuityCategory>(
                      items: GratuityCategory.values,
                      selectedItem: _category,
                      labelBuilder: (cat) => cat.label,
                      onSelected: (val) {
                        setState(() {
                          _category = val;
                          _result = null;
                        });
                      },
                    ),
                    const SizedBox(height: 14),
                    ChronixDateField(
                      label: 'Date of Joining',
                      date: _joiningDate,
                      icon: Icons.calendar_today_rounded,
                      onDateSelected: (newDate) {
                        setState(() {
                          _joiningDate = newDate;
                          _result = null;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    ChronixDateField(
                      label: 'Relieving / Retirement Date',
                      date: _calculationDate,
                      icon: Icons.event_available_rounded,
                      onDateSelected: (newDate) {
                        setState(() {
                          _calculationDate = newDate;
                          _result = null;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ChronixButton(
                text: 'Calculate Gratuity',
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
                          const ChronixSectionHeader(title: 'Qualifying Service'),
                          const SizedBox(height: 12),
                          ChronixStatGrid(
                            cards: [
                              ChronixStatCard(
                                value: _result!.completedYears,
                                label: 'Years',
                                valueColor: theme.colorScheme.primary,
                              ),
                              ChronixStatCard(
                                value: _result!.completedMonths,
                                label: 'Months',
                                valueColor: theme.colorScheme.primary,
                              ),
                              ChronixStatCard(
                                value: _result!.serviceYears,
                                label: 'Gratuity Units',
                                valueColor: theme.colorScheme.primary,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ChronixResultCard(
                            title: 'Total Gratuity Payable',
                            mainValue: Formatters.currency(_result!.gratuityAmount),
                            subtitle: _result!.amountInWords,
                            rows: [
                              ResultRow(
                                label: 'Service Completed',
                                value: _result!.completedServiceDisplay,
                              ),
                              ResultRow(
                                label: 'Pension Category',
                                value: _result!.category.label,
                              ),
                              ResultRow(
                                label: 'Gratuity Service Units',
                                value: '${_result!.serviceYears} year(s)',
                              ),
                              ResultRow(
                                label: 'Monthly Emoluments (Basic + DA)',
                                value: Formatters.currency(_result!.salaryWithDA),
                              ),
                              ResultRow(
                                label: 'Gross Calculated Gratuity',
                                value: Formatters.currency(_result!.gratuityBeforeLimit),
                              ),
                              ResultRow(
                                label: 'Statutory Maximum Ceiling',
                                value: Formatters.currency(FinancialCalculators.maxGratuityAmount),
                              ),
                            ],
                            note: _result!.category == GratuityCategory.gpf
                                ? 'GPF Rules: Credit for first year after 3 months. Formula: (Basic+DA × Years × 2) / 4. Maximum 33 years considered.'
                                : 'NPS Rules: Credit for first year after 6 months. Formula: (Basic+DA × Years × 15) / 26. Maximum 33 years considered.',
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
