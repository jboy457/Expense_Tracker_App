import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);
  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _createTrx() {
    final inputedTitle = _titleController.text;
    final inputedAmount = double.parse(_amountController.text);
    final inputedDate = _selectedDate;

    if (inputedTitle.isEmpty || inputedAmount <= 0 || _selectedDate == null)
      return;

    widget.addNewTransaction(
      inputedTitle,
      inputedAmount,
      inputedDate,
    );

    Navigator.of(context).pop();
  }

  void _viewDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: _titleController,
              onSubmitted: (_) => _createTrx(),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
              ),
              onSubmitted: (_) => _createTrx(),
            ),
            Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    _selectedDate == null
                        ? 'No Date Chosen'
                        : 'Picked Date: ${DateFormat.yMMMEd().format(_selectedDate)}',
                    // style: Theme.of(context).textTheme.title,
                  ),
                  FlatButton(
                    child: Text(
                      'Choose date',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: _viewDatePicker,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              child: RaisedButton(
                child: Text(
                  'Add Transaction',
                  style: TextStyle(
                      fontFamily: 'QuickSand',
                      color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: _createTrx,
              ),
            )
          ],
        ),
      ),
    );
  }
}
