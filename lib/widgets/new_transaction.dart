import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    final textInput = _titleController.text;
    final amountInput = _amountController.text;
    if (textInput.isEmpty || amountInput.isEmpty || _selectedDate == null) {
      return;
    }
    var enteredAmount = double.parse(amountInput);
    widget.addTx(
      textInput,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              autofillHints: ["username", "name"],
              cursorColor: Colors.orange,
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
              // onChanged: (String val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              autofillHints: ["username", "name"],
              cursorColor: Colors.orange,
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
              // onChanged: (String val) {
              //   amountInput = val;
              // },
            ),
            Container(
              height: 80,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text((_selectedDate == null)
                        ? 'No date chosen!'
                        : "Picked Date: ${DateFormat.yMMMd().format(_selectedDate)}"),
                  ),
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: Text("Choose Date",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    // textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _submitData,
              child: Text('Add Transaction'),
              // color: Theme.of(context).primaryColor,
              // textColor: Theme.of(context).textTheme.button.color,
              // textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
