import 'package:bytebank_formsvalid/components/editor.dart';
import 'package:bytebank_formsvalid/models/saldo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormularioDeposito extends StatelessWidget {
  FormularioDeposito({Key? key}) : super(key: key);

  static const String _tituloAppBar = 'Deposito';
  static const String _dicaCampoValor = '0.00';
  static const String _rotuloCampoValor = 'Digite o valor que será depositado';
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[900],
          title: Text(_tituloAppBar),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Editor(
                dica: _dicaCampoValor,
                controlador: _controladorCampoValor,
                rotulo: _rotuloCampoValor,
                icone: Icons.monetization_on,
              ),
              ElevatedButton(
                child: Text('Realizar deposito'),
                onPressed: () => _criaDeposito(context),
              ),
            ],
          ),
        ));
  }

  _criaDeposito(BuildContext context) {
    final double valor = double.tryParse(_controladorCampoValor.text)!;
    final depositoValido = _validaDeposito(valor);
    if (depositoValido) {
      _atualizaSaldo(context, valor);
      Navigator.pop(context);
    }
  }

  _validaDeposito(double valor) {
    final depositoValido = valor != null;
    return depositoValido;
  }

  _atualizaSaldo(context, valor) {
    Provider.of<Saldo>(context, listen: false).adiciona(valor);
  }
}
