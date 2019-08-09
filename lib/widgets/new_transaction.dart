import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {

  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submit(){
    final titleEntered = _titleController.text;
    final amountEntered = double.parse(_amountController.text);
    if (titleEntered.isEmpty || amountEntered <= 0 || _selectedDate==null ) {
        return;
    }
    widget.addTx(_titleController.text,double.parse(_amountController.text), _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2019), 
      lastDate: DateTime.now()
      ).then(
        (date) {
          if (date==null){
            return;
          }else{
           setState(() {
             _selectedDate = date;
           }); 
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.only(
                    top:10, 
                    left: 10, 
                    right:10, 
                    bottom: MediaQuery.of(context).viewInsets.bottom+10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(labelText: 'Title'),
                        controller: _titleController,
                        onSubmitted: (_) => _submit(),
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'Amount  '),
                        keyboardType: TextInputType.number,
                        controller: _amountController,
                        onSubmitted: (_) => _submit(),
                      ),
                      Container(
                        height: 50,
                        child: Row(children: <Widget>[
                          Expanded(
                            child: Text(_selectedDate==null ? 'No Date Chosen' : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}')),
                          FlatButton(
                            textColor: Theme.of(context).primaryColor,
                            child: Text('Choose Date', style: TextStyle(fontWeight: FontWeight.bold),),
                            onPressed: _presentDatePicker,
                          )
                          ],
                        ),
                      ),
                      RaisedButton(
                        child: Text(
                          'Add Transaction',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).textTheme.button.color,
                        onPressed: _submit,
                      )
                    ],
                  ),
                ),
              ),
    );
  }
}