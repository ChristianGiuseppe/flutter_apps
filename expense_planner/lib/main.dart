import 'package:expense_planner/widgets/chart_transaction.dart';
import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/transaction.dart';
import 'widgets/transaction_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            titleLarge: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final List<Transaction> transactions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Piano Spesa'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ChartTransaction(_recentTransactions),
                TransactionList(
                    transactionUser: transactions,
                    deleteTransaction: _deleteTransaction),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () => modalAddTransaction(context),
          child: Icon(Icons.add),
        ));
  }

  List<Transaction> get _recentTransactions {
    return transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String title, double amount, DateTime date) {
    setState(() {
      transactions.add(new Transaction(
          id: DateTime.now().toString(),
          title: title,
          amount: amount,
          date: date));
    });
  }

  modalAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewTransaction(_addTransaction));
        });
  }

  _deleteTransaction(int index) {
    setState(() {
      transactions.removeAt(index);
    });
  }

  initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
