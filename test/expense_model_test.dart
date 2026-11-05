import 'package:flutter_test/flutter_test.dart';
import 'package:pocketpilot/models/expense.dart';

void main() {
  test('expense data survives encode and decode', () {
    final original = Expense(
      id: 'test-1', title: 'Lunch', amount: 120.50, category: 'Food',
      date: DateTime(2026, 11, 3), note: 'College canteen',
    );
    final encoded = Expense.encodeList([original]);
    final decoded = Expense.decodeList(encoded);
    expect(decoded, hasLength(1));
    expect(decoded.single.id, original.id);
    expect(decoded.single.title, original.title);
    expect(decoded.single.amount, original.amount);
    expect(decoded.single.category, original.category);
    expect(decoded.single.note, original.note);
  });
}
