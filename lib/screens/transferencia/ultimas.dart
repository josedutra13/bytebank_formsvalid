import 'package:bytebank_formsvalid/models/transferencias.dart';
import 'package:bytebank_formsvalid/screens/transferencia/lista.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UltimasTransferencias extends StatelessWidget {
  const UltimasTransferencias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Ultimas Transferências',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Consumer<Transferencias>(
          builder: (context, transferencias, child) {
            final ultimasTransfer =
                transferencias.transferencias.reversed.toList();
            final _quantidadeTransfer = transferencias.transferencias.length;
            var tamanho = 2;

            if (_quantidadeTransfer < 2) {
              tamanho = _quantidadeTransfer;
            }

            return _quantidadeTransfer == 0
                ? Card(
                    margin: EdgeInsets.all(40.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Você não possui nenhuma transferência'),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: tamanho,
                        itemBuilder: (context, index) {
                          return ItemTransferencia(ultimasTransfer[index]);
                        }),
                  );
          },
        ),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green)),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListaTransferencias(),
                  ));
            },
            child: Text('Ver todas as transferências'))
      ],
    );
  }
}
