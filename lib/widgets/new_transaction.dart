import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  // String titleInput;
  // String amountInput;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  DateTime _selectedDate;

  void _datePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((onValue) {
      if (onValue == null) {
        return;
      }
      setState(() {
        _selectedDate = onValue;
      });
    });
  }

  void submitData() {
    final eneteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredAmount <= 0 || eneteredTitle.isEmpty || _selectedDate == null) {
      return;
    }
    widget.addTx(eneteredTitle, enteredAmount, _selectedDate);

    Navigator.of(context).pop(); //close the modal sheet
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
              // onChanged: (val) {
              //   titleInput = val;
              // },
              onSubmitted: (_) => submitData(),
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              // onChanged: (val) {
              //   amountInput = val;
              // },
              controller: amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(_selectedDate == null
                      ? 'No Date Chosen!'
                      : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'),
                  FlatButton(
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    onPressed: () => _datePicker(),
                  )
                ],
              ),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColorDark,
              textColor: Colors.white,
              child: Text(
                'Add Transaction',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: submitData,
              //color: Colors.pinkAccent,
            )
          ],
        ),
      ),
    );
  }
}
