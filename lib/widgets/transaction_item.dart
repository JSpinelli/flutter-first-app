import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/Transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    @required this.transaction,
    @required this.deleteTx,
  });

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
            radius: 30,
            child: Container(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                    child: Text(
                        '\$${transaction.amount}')))),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
            DateFormat.yMMMd().format(transaction.date)),
        trailing: IconButton(
          icon:Icon(Icons.delete), 
          color: Theme.of(context).errorColor,
          onPressed: () => deleteTx(transaction.id),
          ),
      ),
    );
  }
}