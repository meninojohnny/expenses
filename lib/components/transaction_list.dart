import 'package:expenses/components/transaction_card.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;

  final Function(String) onPressed;

  const TransactionList({super.key, required this.transactions, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child: transactions.isEmpty 
      ? Column(
        children: [
          const SizedBox(height: 10,),
          const Text('Nenhuma transação encontrada!!'),
          const SizedBox(height: 10,),
          SizedBox(
            height: 250,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ) 
      : ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
          final tr = transactions[index];
          return Card(
            margin: const EdgeInsets.all(5),
            elevation: 5,
            child: TransactionCard(tr: tr, onPressed: onPressed,),
          );
        }
      ),
    );
  }
}