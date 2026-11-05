import 'package:flutter/foundation.dart';

import '../models/expense.dart';
import '../services/expense_storage.dart';

enum ExpenseLoadState { loading, error, empty, data }

class ExpenseProvider extends ChangeNotifier {
  ExpenseProvider({ExpenseStorage? storage}) : _storage = storage ?? ExpenseStorage();

  final ExpenseStorage _storage;
  List<Expense> _expenses = [];
  bool _isLoading = true;
  String? _errorMessage;

  List<Expense> get expenses => List.unmodifiable(_expenses);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  ExpenseLoadState get loadState {
    if (_isLoading) return ExpenseLoadState.loading;
    if (_errorMessage != null) return ExpenseLoadState.error;
    if (_expenses.isEmpty) return ExpenseLoadState.empty;
    return ExpenseLoadState.data;
  }

  double get totalSpent => _expenses.fold(0, (sum, item) => sum + item.amount);

  double get spentThisMonth {
    final now = DateTime.now();
    return _expenses
        .where((item) => item.date.year == now.year && item.date.month == now.month)
        .fold(0, (sum, item) => sum + item.amount);
  }

  Map<String, double> get categoryTotals {
    final totals = <String, double>{};
    for (final expense in _expenses) {
      totals.update(expense.category, (value) => value + expense.amount,
          ifAbsent: () => expense.amount);
    }
    return totals;
  }

  Future<void> loadExpenses() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _expenses = await _storage.loadExpenses();
      _expenses.sort((a, b) => b.date.compareTo(a.date));
    } catch (_) {
      _errorMessage = 'We could not load your expenses. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addExpense(Expense expense) async {
    final updated = [expense, ..._expenses];
    await _storage.saveExpenses(updated);
    _expenses = updated;
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> deleteExpense(String id) async {
    final updated = _expenses.where((item) => item.id != id).toList();
    await _storage.saveExpenses(updated);
    _expenses = updated;
    notifyListeners();
  }
}
