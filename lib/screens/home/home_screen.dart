import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/utilities_data.dart';
import '../../models/utility.dart';
import '../../widgets/chronix_section_header.dart';
import '../../widgets/chronix_utility_card.dart';
import '../about/about_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UtilityCategory _selectedCategory = UtilityCategory.all;

  List<Utility> get _filteredUtilities {
    if (_selectedCategory == UtilityCategory.all) {
      return UtilitiesData.activeUtilities;
    }
    return UtilitiesData.activeUtilities
        .where((u) => u.category == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeCount = UtilitiesData.activeUtilities.length;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'CHRONIX',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: 2.0,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 1),
            Text(
              'Personal Helper Workspace',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
                color: theme.colorScheme.secondary,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded, size: 22),
            tooltip: 'About Chronix',
            onPressed: () {
              HapticFeedback.lightImpact();
              AboutSheet.show(context);
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Active Utilities Header
              ChronixSectionHeader(
                title: 'Active Utilities',
                badge: '$activeCount Active',
              ),
              const SizedBox(height: 12),

              // Category Filter Bar
              SizedBox(
                height: 38,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: UtilityCategory.values.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final category = UtilityCategory.values[index];
                    final isSelected = category == _selectedCategory;

                    return GestureDetector(
                      onTap: () {
                        HapticFeedback.selectionClick();
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? theme.colorScheme.primary
                              : theme.cardTheme.color,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? theme.colorScheme.primary
                                : theme.dividerColor,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            category.label,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                              color: isSelected
                                  ? Colors.white
                                  : theme.colorScheme.secondary,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Active Utilities List
              if (_filteredUtilities.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Text(
                      'No utilities found in this category.',
                      style: TextStyle(
                        fontSize: 13,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                  ),
                )
              else
                ..._filteredUtilities.map(
                  (utility) => ChronixUtilityCard(
                    utility: utility,
                    onTap: () {
                      if (utility.route != null) {
                        Navigator.of(context).pushNamed(utility.route!);
                      }
                    },
                  ),
                ),

              const SizedBox(height: 20),

              // Pipeline Modules Header
              const ChronixSectionHeader(
                title: 'Pipeline Modules',
                badge: 'Future Growth',
              ),
              const SizedBox(height: 12),

              // Upcoming Utilities List
              ...UtilitiesData.upcomingUtilities.map(
                (utility) => ChronixUtilityCard(
                  utility: utility,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
