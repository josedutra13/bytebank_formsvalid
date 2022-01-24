import 'package:bytebank_formsvalid/components/editor.dart';
import 'package:bytebank_formsvalid/models/saldo.dart';
import 'package:bytebank_formsvalid/models/transferencia.dart';
import 'package:bytebank_formsvalid/models/transferencias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _tituloAppBar = 'Criando Transferência';

const _rotuloCampoValor = 'Valor';
const _dicaCampoValor = '0.00';

const _rotuloCampoNumeroConta = 'Número da conta';
const _dicaCampoNumeroConta = '0000';

const _textoBotaoConfirmar = 'Confirmar';

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
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
                controlador: _controladorCampoNumeroConta,
                dica: _dicaCampoNumeroConta,
                rotulo: _rotuloCampoNumeroConta,
              ),
              Editor(
                dica: _dicaCampoValor,
                controlador: _controladorCampoValor,
                rotulo: _rotuloCampoValor,
                icone: Icons.monetization_on,
              ),
              ElevatedButton(
                child: Text(_textoBotaoConfirmar),
                onPressed: () => _criaTransferencia(context),
              ),
            ],
          ),
        ));
  }

  void _criaTransferencia(BuildContext context) {
    final int numeroConta = int.tryParse(_controladorCampoNumeroConta.text)!;
    final double valor = double.tryParse(_controladorCampoValor.text)!;
    final transferenciaValida =
        _validaTransferencia(context, numeroConta, valor);
    if (transferenciaValida) {
      final novaTransferencia = Transferencia(valor, numeroConta);
      _atualizaDeposito(context, novaTransferencia, valor);
      Navigator.pop(context);
    }
  }

  bool _validaTransferencia(
      BuildContext context, int numeroConta, double valor) {
    final saldoSuficiente =
        valor <= Provider.of<Saldo>(context, listen: false).valor;

    return numeroConta != null && valor != null && saldoSuficiente;
  }

  void _atualizaDeposito(context, novaTransferencia, valor) {
    Provider.of<Transferencias>(context, listen: false)
        .adiciona(novaTransferencia);
    Provider.of<Saldo>(context, listen: false).subtrai(valor);
  }
}