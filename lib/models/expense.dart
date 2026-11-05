import 'dart:convert';

class Expense {
  const Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    this.note = '',
  });

  final String id;
  final String title;
  final double amount;
  final String category;
  final DateTime date;
  final String note;

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'amount': amount,
        'category': category,
        'date': date.toIso8601String(),
        'note': note,
      };

  factory Expense.fromMap(Map<String, dynamic> map) => Expense(
        id: map['id'] as String,
        title: map['title'] as String,
        amount: (map['amount'] as num).toDouble(),
        category: map['category'] as String,
        date: DateTime.parse(map['date'] as String),
        note: (map['note'] as String?) ?? '',
      );

  static String encodeList(List<Expense> expenses) =>
      jsonEncode(expenses.map((expense) => expense.toMap()).toList());

  static List<Expense> decodeList(String source) {
    final decoded = jsonDecode(source) as List<dynamic>;
    return decoded
        .map((item) => Expense.fromMap(item as Map<String, dynamic>))
        .toList();
  }
}
