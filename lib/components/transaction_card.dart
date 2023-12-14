import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final Transaction tr;
  final Function(String) onPressed;
  const TransactionCard({super.key, required this.tr, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color.fromARGB(255, 108, 15, 108),
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              'R\$' + tr.value.toString(),
              style: const TextStyle(color:Color.fromARGB(255, 231, 218, 218), fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.delete,
          color: Color.fromARGB(255, 240, 40, 26),
        ),
        onPressed: () => onPressed(tr.id),
      ),
      title: Column(
        children: [
          Text(
            tr.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            DateFormat('d MMM y').format(tr.date),
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 15
            ),  
          )
        ],
      ),
    );
  }
}