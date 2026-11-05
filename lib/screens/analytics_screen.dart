import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/expense_provider.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();
    final totals = provider.categoryTotals.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Spending insights')),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        Text('Your spending snapshot', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 16),
        Card(child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('TOTAL RECORDED SPENDING'), const SizedBox(height: 8),
          Text('₹${provider.totalSpent.toStringAsFixed(2)}', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
          const SizedBox(height: 6), Text('Across ${provider.expenses.length} transactions'),
        ]))),
        const SizedBox(height: 22),
        Text('By category', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        if (provider.isLoading)
          const Center(child: Padding(padding: EdgeInsets.all(32), child: CircularProgressIndicator()))
        else if (provider.errorMessage != null)
          Center(child: Column(children: [Text(provider.errorMessage!), TextButton(onPressed: provider.loadExpenses, child: const Text('Retry'))]))
        else if (totals.isEmpty)
          const Card(child: Padding(padding: EdgeInsets.all(24), child: Text('Add expenses to see your category breakdown.')))
        else
          ...totals.map((entry) {
            final fraction = provider.totalSpent == 0 ? 0.0 : entry.value / provider.totalSpent;
            return Card(margin: const EdgeInsets.only(bottom: 10), child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
              Row(children: [Expanded(child: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.w700))), Text('₹${entry.value.toStringAsFixed(2)}')]),
              const SizedBox(height: 10), LinearProgressIndicator(value: fraction, minHeight: 8, borderRadius: BorderRadius.circular(8)),
              const SizedBox(height: 5), Align(alignment: Alignment.centerRight, child: Text('${(fraction * 100).toStringAsFixed(1)}%', style: theme.textTheme.labelSmall)),
            ])));
          }),
        const SizedBox(height: 12),
        Text('Tip: Review your largest category regularly to find opportunities to save.', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
      ]),
    );
  }
}
