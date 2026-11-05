import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/expense_provider.dart';

class ExpenseListBody extends StatelessWidget {
  const ExpenseListBody({super.key, required this.dataBuilder});
  final Widget Function(BuildContext context) dataBuilder;

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(builder: (context, provider, _) {
      switch (provider.loadState) {
        case ExpenseLoadState.loading:
          return const Center(child: CircularProgressIndicator());
        case ExpenseLoadState.error:
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Icon(Icons.cloud_off_outlined, size: 48),
                const SizedBox(height: 12),
                Text(provider.errorMessage ?? 'Something went wrong.', textAlign: TextAlign.center),
                const SizedBox(height: 12),
                FilledButton.icon(onPressed: provider.loadExpenses, icon: const Icon(Icons.refresh), label: const Text('Retry')),
              ]),
            ),
          );
        case ExpenseLoadState.empty:
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.wallet_outlined, size: 56, color: Theme.of(context).colorScheme.primary),
                const SizedBox(height: 12),
                Text('No expenses yet', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 6),
                const Text('Add your first expense and start understanding your spending.', textAlign: TextAlign.center),
              ]),
            ),
          );
        case ExpenseLoadState.data:
          return dataBuilder(context);
      }
    });
  }
}
