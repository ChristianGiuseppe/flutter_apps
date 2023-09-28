import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  TransactionList(
      {Key? key,
      required this.transactionUser,
      required this.deleteTransaction})
      : super(key: key);

  final List<Transaction> transactionUser;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactionUser.isEmpty
          ? Column(
              children: [
                Text(
                  'No Transactions',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            )
          : ListView(
              scrollDirection: Axis.vertical,
              children: transactionUser.map((tx) {
                return TransactionItem(
                  key: ValueKey(tx.id),
                  transaction: tx,
                  deleteTransaction: () => deleteTransaction(tx.id),
                );
              }).toList(),
            ),
    );
  }
}
