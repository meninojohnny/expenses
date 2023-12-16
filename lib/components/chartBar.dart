import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  const ChartBar({super.key, required this.label, required this.value, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Column(
          children:[
        
            SizedBox(
              height: constraint.maxHeight * .15,
              child: FittedBox(child: Text(value.toStringAsFixed(2)),)),
        
            SizedBox(height: constraint.maxHeight * 0.05,),
        
            Container(
              height: constraint.maxHeight * .6,
              width: 10,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 198, 197, 197),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 108, 15, 108),
                        borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ),
                ],
              ),
            ),
        
            SizedBox(height: constraint.maxHeight * 0.05,),
        
            SizedBox(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  label, 
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
        
          ],
        );
      },
    );
  }
}