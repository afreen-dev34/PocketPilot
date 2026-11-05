import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/expense_provider.dart';
import '../widgets/expense_list_body.dart';
import '../widgets/expense_tile.dart';
import 'expense_detail_screen.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('All transactions')),
      body: ExpenseListBody(dataBuilder: (context) => ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        itemCount: provider.expenses.length,
        itemBuilder: (context, index) {
          final expense = provider.expenses[index];
          return ExpenseTile(expense: expense, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ExpenseDetailScreen(expense: expense))));
        },
      )),
    );
  }
}
