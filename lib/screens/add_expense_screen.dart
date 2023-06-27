import 'package:exp_man/providers/student.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

enum Category { food, travel, work, leisure }

final formatter =
    DateFormat.yMd(); //DateFormat("yyyy-MM-dd").format(DateTime.now())

class AddExpenseScreen extends StatefulWidget {
  AddExpenseScreen({super.key, required this.onNewExpenseSave});

  void Function()? onNewExpenseSave;

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category _selectedCategory = Category.leisure;
  DateTime? _selectedDate;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                maxLength: 50,
                controller: _titleController,
                decoration: const InputDecoration(
                  // focusColor: Color(0xFF50559a),   not working
                  label: Text('Title'),
                ),
              ),
              Row(
                children: [
                  DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                  ),
                  const Spacer(),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _amountController,
                      decoration: const InputDecoration(
                        prefix: Text('\$'),
                        label: Text('Amount'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(_selectedDate == null
                      ? "No Date Selected"
                      : formatter.format(_selectedDate!)),
                  IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month)),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 77, 83, 163),
                    ),
                    onPressed: () async {
                      bool added = await Provider.of<Student>(context,
                              listen: false)
                          .addTransaction(
                              title: _titleController.text,
                              amount: double.tryParse(_amountController.text),
                              date: _selectedDate,
                              category: _selectedCategory.index + 1);
                      if (!added) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Invalid Input'),
                            content: const Text(
                                "Make sure a valid title, amount and category was entered."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Okay'),
                              )
                            ],
                          ),
                        );
                      } else {
                        widget.onNewExpenseSave!();
                      }
                    },
                    child: const Text('Save Expenses'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
