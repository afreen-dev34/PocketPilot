import 'package:shared_preferences/shared_preferences.dart';

import '../models/expense.dart';

class ExpenseStorage {
  static const _storageKey = 'pocketpilot_expenses_v1';

  Future<List<Expense>> loadExpenses() async {
    final preferences = await SharedPreferences.getInstance();
    final raw = preferences.getString(_storageKey);
    if (raw == null || raw.isEmpty) return <Expense>[];
    return Expense.decodeList(raw);
  }

  Future<void> saveExpenses(List<Expense> expenses) async {
    final preferences = await SharedPreferences.getInstance();
    final saved = await preferences.setString(
      _storageKey,
      Expense.encodeList(expenses),
    );
    if (!saved) throw Exception('Your expenses could not be saved. Please try again.');
  }
}
