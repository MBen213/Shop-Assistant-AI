import 'package:flutter/material.dart';
import 'package:mobile/l10n/app_localizations.dart';

import '../../domain/entities/dashboard_stats.dart';

class TodayOverview extends StatelessWidget {
  final DashboardStats stats;

  final VoidCallback? onSalesTap;
  final VoidCallback? onRevenueTap;
  final VoidCallback? onProfitTap;

  const TodayOverview({
    super.key,
    required this.stats,
    this.onSalesTap,
    this.onRevenueTap,
    this.onProfitTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.todayOverview,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),

        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: _OverviewCard(
                title: l10n.todaySales,
                value: stats.todaySales.toString(),
                icon: Icons.shopping_cart,
                color: Colors.green,
                onTap: onSalesTap,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: _OverviewCard(
                title: l10n.revenue,
                value:
                    "${stats.todayRevenue.toStringAsFixed(2)} DA",
                icon: Icons.payments,
                color: Colors.blue,
                onTap: onRevenueTap,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        _OverviewCard(
          title: l10n.todayProfit,
          value:
              "${stats.todayProfit.toStringAsFixed(2)} DA",
          icon: Icons.trending_up,
          color: Colors.orange,
          onTap: onProfitTap,
        ),
      ],
    );
  }
}

class _OverviewCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _OverviewCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: color.withValues(alpha: 0.15),
                child: Icon(
                  icon,
                  color: color,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}