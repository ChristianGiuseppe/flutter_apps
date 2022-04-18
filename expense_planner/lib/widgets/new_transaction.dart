import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  NewTransaction(this.addTransaction);
  final Function addTransaction;

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Titolo del movimento'),
              ),
              TextField(
                controller: amountController,
                keyboardType:
                    TextInputType.numberWithOptions(decimal: true, signed: false),
                decoration: InputDecoration(labelText: 'Totale'),
              ),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_selectedDate == null
                        ? "Seleziona una data"
                        : "Data selezionata: ${DateFormat.yMd().format(_selectedDate!)} "),
                    TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.all(16),
                        ),
                        onPressed: () => _presentiDatePicker(context),
                        child: Text(
                          "Seleziona",
                        ))
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(16),
                ),
                onPressed: () {
                  double amount = double.parse(amountController.text);
    
                  if (titleController.text.isEmpty ||
                      amount < 0 ||
                      _selectedDate == null) return;
    
                  widget.addTransaction(
                      titleController.text, amount, _selectedDate);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Aggiungi Transizione',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _presentiDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        print(pickedDate);
        _selectedDate = pickedDate;
      });
    });
  }
}
