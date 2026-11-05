import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/expense.dart';
import '../providers/expense_provider.dart';

class ExpenseFormScreen extends StatefulWidget {
  const ExpenseFormScreen({super.key});
  @override
  State<ExpenseFormScreen> createState() => _ExpenseFormScreenState();
}

class _ExpenseFormScreenState extends State<ExpenseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  final _titleFocus = FocusNode();
  final _amountFocus = FocusNode();
  final _noteFocus = FocusNode();
  final _categories = const ['Food', 'Travel', 'Shopping', 'Education', 'Bills', 'Other'];
  String _category = 'Food';
  DateTime _date = DateTime.now();
  bool _saving = false;

  @override
  void dispose() {
    _titleController.dispose(); _amountController.dispose(); _noteController.dispose();
    _titleFocus.dispose(); _amountFocus.dispose(); _noteFocus.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(context: context, initialDate: _date, firstDate: DateTime(2020), lastDate: DateTime.now());
    if (picked != null && mounted) setState(() => _date = picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final expense = Expense(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      amount: double.parse(_amountController.text.trim()),
      category: _category,
      date: _date,
      note: _noteController.text.trim(),
    );
    try {
      await context.read<ExpenseProvider>().addExpense(expense);
      if (mounted) Navigator.pop(context);
    } catch (_) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Expense could not be saved. Please try again.')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add an expense')),
      body: Form(
        key: _formKey,
        child: ListView(padding: const EdgeInsets.all(20), children: [
          Text('Record a purchase', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          const Text('A few details help you understand where your money goes.'),
          const SizedBox(height: 24),
          TextFormField(
            controller: _titleController, focusNode: _titleFocus, textCapitalization: TextCapitalization.sentences,
            maxLength: 50, decoration: const InputDecoration(labelText: 'Expense title', hintText: 'e.g. Lunch with friends', prefixIcon: Icon(Icons.edit_outlined)),
            textInputAction: TextInputAction.next, onFieldSubmitted: (_) => _amountFocus.requestFocus(),
            validator: (value) { final text = value?.trim() ?? ''; if (text.isEmpty) return 'Please enter an expense title.'; if (text.length < 2) return 'Title must contain at least 2 characters.'; return null; },
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _amountController, focusNode: _amountFocus, keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Amount (₹)', hintText: '0.00', prefixIcon: Icon(Icons.currency_rupee)),
            textInputAction: TextInputAction.next, onFieldSubmitted: (_) => _noteFocus.requestFocus(),
            validator: (value) { final text = value?.trim() ?? ''; final amount = double.tryParse(text); if (text.isEmpty) return 'Please enter an amount.'; if (amount == null || !amount.isFinite) return 'Enter a valid number.'; if (amount <= 0) return 'Amount must be greater than zero.'; if (amount > 10000000) return 'Amount is too large.'; return null; },
          ),
          const SizedBox(height: 18),
          DropdownButtonFormField<String>(
            value: _category, decoration: const InputDecoration(labelText: 'Category', prefixIcon: Icon(Icons.category_outlined)),
            items: _categories.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
            onChanged: (value) { if (value != null) setState(() => _category = value); },
          ),
          const SizedBox(height: 18),
          Card(child: ListTile(
            leading: const Icon(Icons.calendar_month_outlined), title: const Text('Date'), subtitle: Text('${_date.day}/${_date.month}/${_date.year}'),
            trailing: const Icon(Icons.chevron_right), onTap: _pickDate,
          )),
          const SizedBox(height: 14),
          TextFormField(
            controller: _noteController, focusNode: _noteFocus, maxLength: 160, maxLines: 3,
            decoration: const InputDecoration(labelText: 'Note (optional)', hintText: 'Add a short description', prefixIcon: Icon(Icons.notes_outlined), alignLabelWithHint: true),
            validator: (value) => (value?.length ?? 0) > 160 ? 'Note must be 160 characters or fewer.' : null,
          ),
          const SizedBox(height: 20),
          FilledButton.icon(onPressed: _saving ? null : _save, icon: _saving ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.check), label: Text(_saving ? 'Saving...' : 'Save expense'), style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16))),
        ]),
      ),
    );
  }
}
