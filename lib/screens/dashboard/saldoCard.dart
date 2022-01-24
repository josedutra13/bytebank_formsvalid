import 'package:bytebank_formsvalid/models/saldo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaldoCard extends StatelessWidget {
  const SaldoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<Saldo>(
            builder: (context, value, child) {
              return Text(
                value.toString(),
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              );
            },
          )
          //
          ),
    );
  }
}
