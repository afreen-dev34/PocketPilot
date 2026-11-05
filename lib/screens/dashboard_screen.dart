import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/expense.dart';
import '../providers/expense_provider.dart';
import '../widgets/expense_tile.dart';
import '../widgets/expense_list_body.dart';
import 'expense_detail_screen.dart';
import 'expense_form_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();
    final recent = provider.expenses.take(4).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('PocketPilot'), actions: [
        IconButton(tooltip: 'Add expense', onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ExpenseFormScreen())), icon: const Icon(Icons.add_circle_outline)),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ExpenseFormScreen())),
        icon: const Icon(Icons.add), label: const Text('Add expense'),
      ),
      body: RefreshIndicator(
        onRefresh: provider.loadExpenses,
        child: ListView(padding: const EdgeInsets.fromLTRB(20, 4, 20, 100), children: [
          Text('Your money, in focus.', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 5),
          Text(DateFormat('EEEE, d MMMM').format(DateTime.now()), style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
          const SizedBox(height: 20),
          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('SPENT THIS MONTH', style: Theme.of(context).textTheme.labelLarge?.copyWith(letterSpacing: 1.2)),
                const SizedBox(height: 8),
                Text('₹${provider.spentThisMonth.toStringAsFixed(2)}', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
                const SizedBox(height: 16),
                Row(children: [
                  const Icon(Icons.account_balance_wallet_outlined, size: 18),
                  const SizedBox(width: 7),
                  Text('${provider.expenses.length} recorded transactions'),
                ]),
              ]),
            ),
          ),
          const SizedBox(height: 24),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Recent activity', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
            TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ExpenseFormScreen())), child: const Text('Add new')),
          ]),
          SizedBox(
            height: 290,
            child: ExpenseListBody(dataBuilder: (_) => ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: recent.length,
              itemBuilder: (context, index) {
                final Expense expense = recent[index];
                return ExpenseTile(expense: expense, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ExpenseDetailScreen(expense: expense))));
              },
            )),
          ),
        ]),
      ),
    );
  }
}
