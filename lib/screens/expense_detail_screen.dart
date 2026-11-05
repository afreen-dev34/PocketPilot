import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/expense.dart';
import '../providers/expense_provider.dart';
import '../widgets/expense_tile.dart';

class ExpenseDetailScreen extends StatelessWidget {
  const ExpenseDetailScreen({super.key, required this.expense});
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Transaction details')),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        CircleAvatar(radius: 34, backgroundColor: theme.colorScheme.secondaryContainer, child: Icon(categoryIcon(expense.category), size: 30)),
        const SizedBox(height: 16),
        Text(expense.title, textAlign: TextAlign.center, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        Text('-₹${expense.amount.toStringAsFixed(2)}', textAlign: TextAlign.center, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900, color: theme.colorScheme.primary)),
        const SizedBox(height: 24),
        Card(child: Column(children: [
          _DetailRow(label: 'Category', value: expense.category),
          const Divider(height: 1),
          _DetailRow(label: 'Date', value: DateFormat('EEEE, d MMMM yyyy').format(expense.date)),
          const Divider(height: 1),
          _DetailRow(label: 'Description', value: expense.note.isEmpty ? 'No description added' : expense.note),
          const Divider(height: 1),
          _DetailRow(label: 'Transaction ID', value: expense.id),
        ])),
        const SizedBox(height: 20),
        OutlinedButton.icon(
          onPressed: () async {
            final confirmed = await showDialog<bool>(context: context, builder: (dialogContext) => AlertDialog(
              title: const Text('Delete transaction?'),
              content: const Text('This expense will be permanently removed from this device.'),
              actions: [TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Cancel')), FilledButton(onPressed: () => Navigator.pop(dialogContext, true), child: const Text('Delete'))],
            ));
            if (confirmed == true && context.mounted) {
              try {
                await context.read<ExpenseProvider>().deleteExpense(expense.id);
                if (context.mounted) Navigator.pop(context);
              } catch (_) {
                if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not delete. Please try again.')));
              }
            }
          },
          icon: const Icon(Icons.delete_outline), label: const Text('Delete transaction'),
        ),
      ]),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(width: 105, child: Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant))),
      Expanded(child: Text(value, textAlign: TextAlign.end, style: const TextStyle(fontWeight: FontWeight.w600))),
    ]),
  );
}
