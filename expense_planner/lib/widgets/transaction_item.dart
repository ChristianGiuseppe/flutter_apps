import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  TransactionItem({Key? key, this.transaction, this.deleteTransaction});
  final Transaction? transaction;
  final VoidCallback? deleteTransaction;
  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text('\$${widget.transaction!.amount}'),
            ),
          ),
        ),
        title: Text(
          widget.transaction!.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction!.date),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).colorScheme.error,
          onPressed: widget.deleteTransaction != null
              ? () => widget.deleteTransaction
              : null,
        ),
      ),
    );
  }
}
