import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

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
                    child: const Text(
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
                child: ListView(
                  children: transactions
                      .map(
                        (tx) => TransactionItem(
                          key: ValueKey(tx.id),
                          transaction: tx,
                          deleteTransaction: deleteTransaction,
                        ),
                      )
                      .toList(),
                ),
              );
      },
    );
  }
}
