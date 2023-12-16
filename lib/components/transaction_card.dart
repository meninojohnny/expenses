import 'dart:math';

import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatefulWidget {
  final Transaction tr;
  final Function(String) onPressed;
  TransactionCard({super.key, required this.tr, required this.onPressed});

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.orange,
  ];

  late Color _background;

  @override
  void initState() {
    int i = Random().nextInt(3);
    _background = colors[i];
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _background,
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'R\$ ${widget.tr.value.toStringAsFixed(2)}',
                style: const TextStyle(
                  color:Color.fromARGB(255, 231, 218, 218), 
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        trailing: 
          mediaQuery.size.width > 480 
          ? TextButton(
            onPressed: () => widget.onPressed(widget.tr.id), 
            child: const Text(
              'Excluir', 
              style: TextStyle(
                color: Colors.red, 
                fontWeight: FontWeight.bold,
              ),
            ),
          )
          : IconButton(
            icon: const Icon(          
              Icons.delete,
              color: Color.fromARGB(255, 240, 40, 26),
            ),
            onPressed: () => widget.onPressed(widget.tr.id),
          ),
        title: Column(
          children: [
            Text(
              widget.tr.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              DateFormat('d MMM y').format(widget.tr.date),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15
              ),  
            )
          ],
        ),
      ),
    );
  }
}