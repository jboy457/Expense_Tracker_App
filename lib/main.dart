import 'package:flutter/material.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: '1',
      title: 'For Eating',
      amount: 50.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: '2',
      title: 'New Shoes',
      amount: 35.00,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: '3',
      title: 'Laptop',
      amount: 17.00,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
  ];

  void _addNewTransactions(String trxTitle, double trxAmount, trxDate) {
    final newTrx = Transaction(
      amount: trxAmount,
      title: trxTitle,
      date: trxDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactions.add(newTrx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((trx) {
        return trx.id == id;
      });
    });
  }

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((trx) {
      return trx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _showModal(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: NewTransaction(_addNewTransactions),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showModal(context);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransaction),
            _userTransactions.isEmpty
                ? Column(
                    children: <Widget>[
                      Text(
                        'No transaction added yet!',
                        style: Theme.of(context).textTheme.title,
                      ),
                      Container(
                        height: 350,
                        child: Image.asset(
                          'assets/images/no_trx.png',
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  )
                : TransactionList(_userTransactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).accentColor,
        elevation: 3,
        onPressed: () {
          _showModal(context);
        },
      ),
    );
  }
}
