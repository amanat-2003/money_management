import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction_item.dart';


class TransactionList extends StatelessWidget {
  final List<Transaction> Transactions;
  final Function deleteTx;

  TransactionList(this.Transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return (Transactions.isEmpty)
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text(
                  "No transaction added yet!",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (cxt, index) {
              return TransactionItem(transaction: Transactions[index], deleteTx: deleteTx);
            },
            itemCount: Transactions.length,
          );
  }
}
