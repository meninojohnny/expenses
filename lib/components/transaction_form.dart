import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onPressed;

  const TransactionForm({super.key, required this.onPressed});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _valueController = TextEditingController();

  void _onSubmittedForm() {
    final String title = _titleController.text;
    final double value = double.parse(_valueController.text);

    if (title.isEmpty || value <= 0) {
      return;
    }
    widget.onPressed(title, value);
    Navigator.pop(context);
  } 

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              onSubmitted: (_) {_onSubmittedForm();},
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Titulo:'
              ),
            ),
            TextField(
              onSubmitted: (_) 
              {_onSubmittedForm();},
              keyboardType: TextInputType.number,
              controller: _valueController,
              decoration: const InputDecoration(
                hintText: 'Valor (R\$):'
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _onSubmittedForm,
                child: const Text('Nova transação'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}