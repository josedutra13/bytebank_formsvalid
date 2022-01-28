import 'package:bytebank_formsvalid/models/cliente.dart';
import 'package:bytebank_formsvalid/models/saldo.dart';
import 'package:bytebank_formsvalid/screens/autenticacao/login.dart';
import 'package:bytebank_formsvalid/screens/deposito/formulario.dart';
import 'package:bytebank_formsvalid/screens/transferencia/formulario.dart';
import 'package:bytebank_formsvalid/screens/transferencia/ultimas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'saldoCard.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: const Text('Bytebank'),
      ),
      body: ListView(
        children: [
          Consumer<Cliente>(builder: (context, cliente, child) {
            final clienteNome = cliente.nome!.split(' ')[0];
            if (cliente.nome!.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Olá, $clienteNome seu saldo hoje e de : ',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              );
            }
            return Text('Olá, ${cliente.nome} seu saldo hoje e de ');
          }),
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
                  child: const Text('Nova transferência')),
            ],
          ),
          const UltimasTransferencias(),
          Center(
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green)),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                      (routes) => false);
                },
                child: const Text('Sair')),
          )
        ],
      ),
    );
  }
}
