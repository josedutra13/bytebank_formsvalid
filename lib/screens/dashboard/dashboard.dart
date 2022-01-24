import 'package:bytebank_formsvalid/screens/deposito/formulario.dart';
import 'package:bytebank_formsvalid/screens/transferencia/formulario.dart';
import 'package:bytebank_formsvalid/screens/transferencia/ultimas.dart';
import 'package:flutter/material.dart';

import 'saldoCard.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text('Bytebank'),
      ),
      body: ListView(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: SaldoCard(),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FormularioDeposito(),
                        ));
                  },
                  child: const Text('Receber deposito')),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FormularioTransferencia(),
                        ));
                  },
                  child: const Text('Nova transferência'))
            ],
          ),
          const UltimasTransferencias()
        ],
      ),
    );
  }
}
