import 'package:flutter/material.dart';
import '../../models/leave_salary_result.dart';
import '../../utils/financial_calculators.dart';
import '../../utils/formatters.dart';
import '../../widgets/chronix_app_bar.dart';
import '../../widgets/chronix_button.dart';
import '../../widgets/chronix_card.dart';
import '../../widgets/chronix_input_field.dart';
import '../../widgets/chronix_result_card.dart';
import '../../widgets/chronix_section_header.dart';
import '../../widgets/chronix_stat_card.dart';

class LeaveSalaryScreen extends StatefulWidget {
  const LeaveSalaryScreen({super.key});

  @override
  State<LeaveSalaryScreen> createState() => _LeaveSalaryScreenState();
}

class _LeaveSalaryScreenState extends State<LeaveSalaryScreen> {
  final _basicPayController = TextEditingController();
  final _daPercentController = TextEditingController();
  final _elBalanceController = TextEditingController();
  final _hplBalanceController = TextEditingController();

  LeaveSalaryResult? _result;

  @override
  void dispose() {
    _basicPayController.dispose();
    _daPercentController.dispose();
    _elBalanceController.dispose();
    _hplBalanceController.dispose();
    super.dispose();
  }

  void _handleCalculate() {
    final basicStr = _basicPayController.text.trim();
    final daStr = _daPercentController.text.trim();
    final elStr = _elBalanceController.text.trim();
    final hplStr = _hplBalanceController.text.trim();

    if (basicStr.isEmpty || daStr.isEmpty || elStr.isEmpty || hplStr.isEmpty) {
      _showAlert('Missing Fields', 'Please fill in all salary and leave balance fields.');
      return;
    }

    final basic = double.tryParse(basicStr);
    final da = double.tryParse(daStr);
    final el = int.tryParse(elStr);
    final hpl = int.tryParse(hplStr);

    if (basic == null || da == null || el == null || hpl == null) {
      _showAlert('Invalid Values', 'Please enter valid numeric values.');
      return;
    }

    if (basic < 0 || da < 0 || el < 0 || hpl < 0) {
      _showAlert('Invalid Input', 'Values cannot be negative.');
      return;
    }

    setState(() {
      _result = FinancialCalculators.calculateLeaveSalary(
        basicPay: basic,
        daPercent: da,
        elBalance: el,
        hplBalance: hpl,
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
        title: 'Leave Salary Calculator',
        subtitle: 'Calculate EL & HPL leave encashment benefits',
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
                    const ChronixSectionHeader(title: 'Employee & Leave Details'),
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
                    const SizedBox(height: 12),
                    ChronixInputField(
                      label: 'Earned Leave (EL) Balance (Days)',
                      placeholder: '300',
                      controller: _elBalanceController,
                      keyboardType: TextInputType.number,
                      prefixIcon: const Icon(Icons.date_range_rounded, size: 18),
                      onChanged: (_) => _onFieldChanged(),
                    ),
                    const SizedBox(height: 12),
                    ChronixInputField(
                      label: 'Half Pay Leave (HPL) Balance (Days)',
                      placeholder: '180',
                      controller: _hplBalanceController,
                      keyboardType: TextInputType.number,
                      prefixIcon: const Icon(Icons.event_note_rounded, size: 18),
                      onChanged: (_) => _onFieldChanged(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ChronixButton(
                text: 'Calculate Leave Salary',
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
                          const ChronixSectionHeader(title: 'Leave Days Encashed'),
                          const SizedBox(height: 12),
                          ChronixStatGrid(
                            cards: [
                              ChronixStatCard(
                                value: _result!.elDaysUsed,
                                label: 'EL Used',
                                valueColor: theme.colorScheme.primary,
                              ),
                              ChronixStatCard(
                                value: _result!.hplDaysUsed,
                                label: 'HPL Used',
                                valueColor: theme.colorScheme.primary,
                              ),
                              ChronixStatCard(
                                value: _result!.totalDaysUsed,
                                label: 'Total Days',
                                valueColor: theme.colorScheme.primary,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ChronixResultCard(
                            title: 'Total Leave Encashment',
                            mainValue: Formatters.currency(_result!.totalLeaveSalary),
                            subtitle: _result!.amountInWords,
                            rows: [
                              ResultRow(
                                label: 'Basic Pay',
                                value: Formatters.currency(_result!.basicPay),
                              ),
                              ResultRow(
                                label: 'DA Amount (${_result!.daPercent}%)',
                                value: Formatters.currency(_result!.daAmount),
                              ),
                              ResultRow(
                                label: 'Monthly Salary with DA',
                                value: Formatters.currency(_result!.salaryWithDA),
                              ),
                              ResultRow(
                                label: 'EL Leave Encashment',
                                value: Formatters.currency(_result!.elLeaveSalary),
                              ),
                              ResultRow(
                                label: 'HPL Leave Encashment (Half-Pay)',
                                value: Formatters.currency(_result!.hplLeaveSalary),
                              ),
                            ],
                            note: 'Statutory ceiling: Maximum 300 days total encashment. EL consumed first, HPL fills remaining balance.',
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
