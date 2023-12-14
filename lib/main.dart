import 'dart:math';
import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Open Sans',
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _transactions = [
    Transaction(id: '1', title: 'Conta de agua', value: 10, date: DateTime.now().subtract(const Duration(days: 1))),
    Transaction(id: '2', title: 'Conta de luz', value: 20, date: DateTime.now().subtract(const Duration(days: 2))),
    Transaction(id: '3', title: 'Conta de internet', value: 30, date: DateTime.now().subtract(const Duration(days: 3))),
    Transaction(id: '4', title: 'Conta de funeraria', value: 40, date: DateTime.now().subtract(const Duration(days: 4))),
    Transaction(id: '5', title: 'Conta de veterinario', value: 50, date: DateTime.now().subtract(const Duration(days: 5))),
  ];

  void addTransaction(String title, double value, DateTime date) {
    _transactions.add(
      Transaction(
        id: Random().nextDouble().toString(), 
        title: title, 
        value: value, 
        date: date
      ),
    );
    setState(() {});
  }

  void _removeTransation(String id) => setState(() {
    _transactions.removeWhere((tr) => tr.id == id);
  });
    
    

  List<Transaction> get _recentTransation {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  void 
  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context, 
      builder: (_) => TransactionForm(onPressed: addTransaction),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Despesas Pessoais', 
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () => _openTransactionFormModal(context), 
            icon: const Icon(
              Icons.add, 
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(recentTransations: _recentTransation),
            TransactionList(transactions: _transactions, onPressed: _removeTransation,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () => _openTransactionFormModal(context),
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}