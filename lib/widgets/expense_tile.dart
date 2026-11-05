import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/expense.dart';

IconData categoryIcon(String category) => switch (category) {
      'Food' => Icons.restaurant,
      'Travel' => Icons.directions_bus,
      'Shopping' => Icons.shopping_bag,
      'Education' => Icons.menu_book,
      'Bills' => Icons.receipt,
      _ => Icons.category,
    };

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({super.key, required this.expense, required this.onTap});
  final Expense expense;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.secondaryContainer,
          child: Icon(categoryIcon(expense.category), color: theme.colorScheme.onSecondaryContainer),
        ),
        title: Text(expense.title, maxLines: 1, overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
        subtitle: Text('${expense.category} • ${DateFormat('d MMM').format(expense.date)}'),
        trailing: Text('-₹${expense.amount.toStringAsFixed(2)}',
            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)),
      ),
    );
  }
}
