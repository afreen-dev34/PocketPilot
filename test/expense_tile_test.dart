import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pocketpilot/models/expense.dart';
import 'package:pocketpilot/widgets/expense_tile.dart';

void main() {
  testWidgets('expense tile displays title, category and amount', (tester) async {
    final expense = Expense(
      id: 'widget-test', title: 'Bus pass', amount: 45,
      category: 'Travel', date: DateTime(2026, 11, 3),
    );
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: ExpenseTile(expense: expense, onTap: () {})),
    ));
    expect(find.text('Bus pass'), findsOneWidget);
    expect(find.text('Travel • 3 Nov'), findsOneWidget);
    expect(find.text('-₹45.00'), findsOneWidget);
  });
}
