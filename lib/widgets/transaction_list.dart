import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

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
                SizedBox(
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
              // return Card(
              //     child: Row(
              //   children: [
              //     Container(
              //       decoration: BoxDecoration(
              //           border: Border.all(
              //         color: Theme.of(context).primaryColorDark,
              //         width: 2,
              //       )),
              //       margin: EdgeInsets.symmetric(
              //         vertical: 10,
              //         horizontal: 15,
              //       ),
              //       padding: EdgeInsets.all(10),
              //       child: Text(
              //         "₹${Transactions[index].amount.toStringAsFixed(1)}",
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 20,
              //           color: Theme.of(context).primaryColorDark,
              //         ),
              //       ),
              //     ),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       children: [
              //         Container(
              //           // margin: EdgeInsets.all(10),
              //           // padding: EdgeInsets.all(5),
              //           child: Text(
              //             Transactions[index].title,
              //             style: Theme.of(context).textTheme.titleMedium,
              //           ),
              //         ),
              //         Container(
              //           // margin: EdgeInsets.all(10),
              //           // padding: EdgeInsets.all(5),
              //           child: Text(
              //             // 'dd MMM, yyyy'
              //             // new DateFormat.yMMMMEEEEd().format(txn.date),
              //             new DateFormat('EEEE, MMMM d, y')
              //                 .format(Transactions[index].date),
              //             style: TextStyle(
              //                 fontSize: 13,
              //                 fontWeight: FontWeight.w500,
              //                 color: Colors.grey),
              //           ),
              //         ),
              //       ],
              //     )
              //   ],
              // ));
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                          child: Text("₹${Transactions[index].amount}")),
                    ),
                  ),
                  // leading: Container(
                  //   height: 70,
                  //   width: 70,
                  //   decoration: BoxDecoration(
                  //     color: Theme.of(context).primaryColor,
                  //     shape: BoxShape.circle,
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(10.0),
                  //     child: FittedBox(
                  //         child: Text("₹${Transactions[index].amount}")),
                  //   ),
                  // ),
                  title: Text(
                    Transactions[index].title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle:
                      Text(DateFormat.yMMMd().format(Transactions[index].date)),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () {
                      deleteTx(Transactions[index].id);
                    },
                  ),
                ),
              );
            },
            itemCount: Transactions.length,
          );
  }
}
