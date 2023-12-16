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
    return transactions.isEmpty
    ? LayoutBuilder(
        builder: (context, constraint) {
          return Column(
      children: [

        SizedBox(height: constraint.maxHeight * .15,),

        SizedBox(
          height: constraint.maxHeight * .2,
          child: const Text(
            'Nenhuma transação encontrada!!',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        SizedBox(height: constraint.maxHeight * .15,),
        
        SizedBox(
          height: constraint.maxHeight * .5,
          child: Image.asset(
            'assets/images/waiting.png',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
        },
      )
    : 
      ListView(
        children: transactions.map((tr) {
          return TransactionCard(
            key: ValueKey(tr.id),
            tr: tr, 
            onPressed: onPressed,
          );
        }).toList(),
      );
    // ListView.builder(
    //     itemCount: transactions.length,
    //     itemBuilder: (context, index) {
    //     final tr = transactions[index];
    //     return Card(
    //       margin: const EdgeInsets.all(5),
    //       elevation: 5,
    //       child: TransactionCard(tr: tr, onPressed: onPressed,),
    //     );
    //   }
    // );
  }
}