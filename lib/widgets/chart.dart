import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactionsList;

  Chart(this.recentTransactionsList);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));
        var totalSum = 0.0;

        for (var i = 0; i < recentTransactionsList.length; i++) {
          if (weekDay.day == recentTransactionsList[i].date.day &&
              weekDay.month == recentTransactionsList[i].date.month &&
              weekDay.year == recentTransactionsList[i].date.year) {
            totalSum += recentTransactionsList[i].amount;
          }
        }

        return {
          'day': DateFormat.E().format(weekDay).substring(0,1),
          'amount': totalSum,
        };
      },
    ).reversed.toList();
  }

  double get totalSpending{
    return groupedTransactionValues.fold(0.0, (sum, element) {
      return sum + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: data['day'],
                spendingAmount: data['amount'],
                spendingFrctnOfTotal: (totalSpending == 0.0)? 0.0 : (data['amount'] as double)/totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
