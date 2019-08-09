import 'package:flutter/material.dart';

import './model/Transaction.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.indigoAccent,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          ),
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 20
              ),
            button: TextStyle(color:Colors.white),
          ),
    ),
    home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where(
      (tx) {
        return tx.date.isAfter(DateTime.now().subtract(Duration(days:7)));
      }).toList();
  }

  void _addNewTransaction(String txtitle, double txamount, DateTime date) {
    final newTx = Transaction(
        title: txtitle,
        amount: txamount,
        date: date,
        id: DateTime.now().toString());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((element) {
        return element.id==id;
      });
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
  showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: NewTransaction(_addNewTransaction));
      },
      isScrollControlled: true);
}

  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context);
    final appBar= AppBar(
          title: Text('Personal Expenses'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context),
            )
          ],
        );
    return Scaffold(
        appBar: appBar,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () =>  _startAddNewTransaction(context),
        ),
        body: Container(
          padding: EdgeInsets.all(5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
              Container(
                height: (mQuery.size.height - appBar.preferredSize.height - mQuery.padding.top) * 0.27,
                child: Chart(_recentTransactions)),
              Container(
                height: (mQuery.size.height - appBar.preferredSize.height - mQuery.padding.top) * 0.73,
                child: TransactionList(_userTransactions, _deleteTransaction))
              ],
            ),
          ),
        ));
  }
}
