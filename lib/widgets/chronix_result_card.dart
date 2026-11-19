import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'chronix_card.dart';

class ResultRow {
  final String label;
  final String value;
  final bool isHighlighted;

  const ResultRow({
    required this.label,
    required this.value,
    this.isHighlighted = false,
  });
}

/// Primary result display card with large figure, spelled-out text, copy action, and rows.
class ChronixResultCard extends StatelessWidget {
  final String title;
  final String mainValue;
  final String? subtitle;
  final List<ResultRow>? rows;
  final String? note;
  final Color? mainValueColor;
  final VoidCallback? onCopy;

  const ChronixResultCard({
    super.key,
    required this.title,
    required this.mainValue,
    this.subtitle,
    this.rows,
    this.note,
    this.mainValueColor,
    this.onCopy,
  });

  void _copyToClipboard(BuildContext context) {
    HapticFeedback.lightImpact();
    Clipboard.setData(ClipboardData(text: '$title: $mainValue${subtitle != null ? " ($subtitle)" : ""}'));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Result copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChronixCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title.toUpperCase(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: theme.colorScheme.secondary,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.copy_rounded, size: 18),
                tooltip: 'Copy Result',
                visualDensity: VisualDensity.compact,
                color: theme.colorScheme.secondary,
                onPressed: () => _copyToClipboard(context),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            mainValue,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              color: mainValueColor ?? theme.colorScheme.primary,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 6),
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.secondary,
                height: 1.35,
              ),
            ),
          ],
          if (rows != null && rows!.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 12),
            ...rows!.map((row) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        row.label,
                        style: TextStyle(
                          fontSize: 13,
                          color: theme.colorScheme.secondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        row.value,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: row.isHighlighted ? FontWeight.w700 : FontWeight.w600,
                          color: row.isHighlighted
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
          if (note != null) ...[
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: theme.inputDecorationTheme.fillColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 15,
                    color: theme.colorScheme.secondary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      note!,
                      style: TextStyle(
                        fontSize: 11,
                        color: theme.colorScheme.secondary,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
