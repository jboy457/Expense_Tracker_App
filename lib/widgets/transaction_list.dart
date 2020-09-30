import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraint) {
        return transactions.isEmpty
            ? Column(
                children: <Widget>[
                  Container(
                    height: constraint.maxHeight * 0.1,
                    child: Text(
                      'No transaction added yet!',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    height: constraint.maxHeight * 0.8,
                    child: Image.asset(
                      'assets/images/no_trx.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              )
            : Container(
                height: constraint.maxHeight * 0.9,
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
                        trailing: MediaQuery.of(context).size.width > 500
                            ? FlatButton.icon(
                                onPressed: () {
                                  deleteTransaction(transactions[index].id);
                                },
                                icon: Icon(Icons.delete),
                                label: Text('Delete'),
                                textColor: Theme.of(context).errorColor,
                              )
                            : IconButton(
                                icon: Icon(Icons.delete),
                                color: Theme.of(context).errorColor,
                                onPressed: () {
                                  deleteTransaction(transactions[index].id);
                                },
                              ),
                      ),
                    );
                  },
                  itemCount: transactions.length,
                ),
              );
      },
    );
  }
}
