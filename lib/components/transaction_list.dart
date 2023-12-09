import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;

  const TransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child: transactions.isEmpty 
      ? Column(
        children: [
          SizedBox(height: 10,),
          const Text('Nenhuma transação encontrada!!'),
          SizedBox(height: 10,),
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
        return Card(child: Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.purple,
                    width: 2
                  ),
                  // shape: BoxShape.circle  
                ),
                child: Text(
                  'R\$ ${tr.value}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.purple
                  )
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat('d MMM y').format(tr.date),
                    style: const TextStyle(
                      color: Colors.grey
                    ),  
                  )
                ],
              )
            ],
          ),);}
      ),
    );
  }
}