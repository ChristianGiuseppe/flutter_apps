import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartTransaction extends StatelessWidget {
  final List<Transaction> currentTransations;

  ChartTransaction(this.currentTransations);

  List<Map<String, dynamic>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for (var i = 0; i < currentTransations.length; i++) {
        if (currentTransations[i].date.day == weekDay.day &&
            currentTransations[i].date.month == weekDay.month &&
            currentTransations[i].date.year == weekDay.year) {
          totalSum += currentTransations[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.all(20),
        elevation: 5,
        child: Row(
          children: groupedTransactionValues.isEmpty ? [] : groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
                child: ChartBar(
                    (data['day']),
                    (data['amount']),
                    totalSpending == 0
                        ? 0
                        : (data['amount'] as double) / totalSpending));
          }).toList(),
        ),
      ),
    );
  }

  //column chart
  //pie chart

}
