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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {

  final List<Transaction> _transactions = [
    Transaction(id: '1', title: 'Conta de agua', value: 10, date: DateTime.now().subtract(const Duration(days: 1))),
    Transaction(id: '2', title: 'Conta de luz', value: 20, date: DateTime.now().subtract(const Duration(days: 2))),
    Transaction(id: '3', title: 'Conta de internet', value: 30, date: DateTime.now().subtract(const Duration(days: 3))),
    Transaction(id: '4', title: 'Conta de funeraria', value: 40, date: DateTime.now().subtract(const Duration(days: 4))),
    Transaction(id: '5', title: 'Conta de veterinario', value: 50, date: DateTime.now().subtract(const Duration(days: 5))),
    Transaction(id: '6', title: 'Conta medica', value: 10, date: DateTime.now().subtract(const Duration(days: 1))),
    Transaction(id: '7', title: 'Roupas', value: 20, date: DateTime.now().subtract(const Duration(days: 2))),
    Transaction(id: '8', title: 'Roupa pra gato', value: 30, date: DateTime.now().subtract(const Duration(days: 3))),
    Transaction(id: '9', title: 'Conta de funeraria', value: 40, date: DateTime.now().subtract(const Duration(days: 4))),
    Transaction(id: '10', title: 'Conta de veterinario', value: 50, date: DateTime.now().subtract(const Duration(days: 5))),
  ];

  bool _showChart = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

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

    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;

    MediaQueryData mediaQuery = MediaQuery.of(context);

    final appBar = AppBar(
      title: const Text(
        'Despesas Pessoais', 
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      actions: [

        if (isLandScape)
        IconButton(
          onPressed: () {
            setState(() {
              _showChart = !_showChart;
            });
          }, 
          icon: Icon(
            _showChart ? Icons.list : Icons.pie_chart, 
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () => _openTransactionFormModal(context), 
          icon: const Icon(
            Icons.add, 
            color: Colors.white,
          ),
        ),
      ],
    );

    final avaliableHeight = 
      mediaQuery.size.height - 
      appBar.preferredSize.height - 
      mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            if (_showChart || !isLandScape)
            SizedBox(
              height: avaliableHeight * (isLandScape ? .7 : .3),
              child: Chart(recentTransations: _recentTransation),
            ),

            if (!_showChart || !isLandScape)
            SizedBox(
              height: avaliableHeight * 1,
              child: TransactionList(transactions: _transactions, onPressed: _removeTransation,)),
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