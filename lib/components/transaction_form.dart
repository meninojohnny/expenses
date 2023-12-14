import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onPressed;

  const TransactionForm({super.key, required this.onPressed});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _valueController = TextEditingController();

   DateTime? selectedDate;

  void _onSubmittedForm() {
    final String title = _titleController.text;
    final double value = double.parse(_valueController.text);
    final DateTime? datePicker = selectedDate;

    if (title.isEmpty || value <= 0 || datePicker == null) {
      return;
    }
    widget.onPressed(title, value, datePicker);
    Navigator.pop(context);
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(), 
      firstDate: DateTime(2019), 
      lastDate: DateTime.now(),
    ).then((datePicker) {
      if(datePicker == null) {
        return;
      }
      selectedDate = datePicker;
      setState(() {});
    });
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
            const SizedBox(height: 10,),
            Row(
              children: [
                Text(
                  selectedDate == null 
                  ? 'Nenhuma data selecionada?' 
                  : DateFormat('dd/MM/y').format(selectedDate!),
                ),
                TextButton(
                  onPressed: _showDatePicker, 
                  child: const Text('Selecionar Data'),
                ),
              ],
            ),

            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blue),
                  textStyle: MaterialStatePropertyAll(
                    TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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