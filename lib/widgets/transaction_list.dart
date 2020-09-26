import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            margin: EdgeInsets.all(10),
            elevation: 3,
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Theme.of(context).primaryColorLight,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: FittedBox(
                    child: Text(
                      '\$${transactions[index].amount.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                ),
              ),
              title: Text(
                transactions[index].title,
                style: Theme.of(context).textTheme.title,
              ),
              subtitle: Text(
                DateFormat.yMMMMd().format(transactions[index].date),
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  color: Colors.grey,
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () {
                  deleteTransaction(transactions[index].id);
                },
              ),
            ),
            // child: Row(
            //   children: <Widget>[
            //     Container(
            //       margin: EdgeInsets.symmetric(
            //         vertical: 10,
            //         horizontal: 15,
            //       ),
            //       decoration: BoxDecoration(
            //         border: Border.all(
            //           color: Theme.of(context).primaryColorLight,
            //           width: 2,
            //         ),
            //         borderRadius: BorderRadius.circular(5),
            //       ),
            //       padding: EdgeInsets.all(10),
            //       child: Text(
            //         '\$${transactions[index].amount.toStringAsFixed(2)}',
            //         style: TextStyle(
            //           fontWeight: FontWeight.bold,
            //           fontSize: 20,
            //           color: Theme.of(context).primaryColor,
            //         ),
            //       ),
            //     ),
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: <Widget>[
            //         Text(
            //           transactions[index].title,
            //           style: Theme.of(context).textTheme.title,
            //         ),
            //         Text(
            //           DateFormat.yMMMMd().format(transactions[index].date),
            //           style: TextStyle(
            //             color: Colors.grey,
            //           ),
            //         )
            //       ],
            //     ),
            //   ],
            // ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
