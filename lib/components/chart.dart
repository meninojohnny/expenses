import 'package:expenses/components/chartBar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransations;

  const Chart({super.key, required this.recentTransations});

  List get groupedTransations {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (int i = 0; i< recentTransations.length;i++) {
        bool sameDay = recentTransations[i].date.day == weekDay.day;
        bool sameMonth = recentTransations[i].date.month == weekDay.month;
        bool sameYear = recentTransations[i].date.year == weekDay.year;
        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransations[i].value;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    });
  }

  double get _weekTotalSum => groupedTransations.fold(0.0, (sum, tr) => sum + tr['value']);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupedTransations.map((tr) {
          double value = tr['value'];
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Flexible(
              child: ChartBar(
                label: tr['day'], 
                value: value,
                percentage: value/_weekTotalSum,
              ),
            ),
          );
        }).toList()
      ),
    );
  }
}