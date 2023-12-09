import 'dart:math';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionUserState extends StatefulWidget {
  const TransactionUserState({super.key});

  @override
  State<TransactionUserState> createState() => _TransactionUserStateState();
}

class _TransactionUserStateState extends State<TransactionUserState> {

  final List<Transaction> _transactions = [];

  void gerarLista() {
    for (double i = 0;i < 20;i++) {
      addTransaction('Conta #$i', i);
    }
  }

  void addTransaction(String title, double value) {
    _transactions.add(
      Transaction(
        id: Random().nextDouble().toString(), 
        title: title, 
        value: value, 
        date: DateTime.now(),
      ),
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    gerarLista();
  }

  @override
  Widget build(BuildContext context) {
    // gerarLista();
    return Column(
      children: [
        TransactionForm(onPressed: addTransaction),
        TransactionList(transactions: _transactions),
      ],
    );
  }
}