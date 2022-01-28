import 'package:bytebank_formsvalid/models/cliente.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class Biometria extends StatelessWidget {
  final LocalAuthentication autenticacaoLocal = LocalAuthentication();

  Biometria({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _biometriaDisponivel(),
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Text(
                  'Detectamos que você tem sensor biométrico no seu celular, deseja auntenticar com biometria?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(71, 161, 56, 1))),
                  onPressed: () async {
                    await _autenticarCliente(context);
                  },
                  child: const Text(
                    'Habilitar impressão digital',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          );
        }
        return Container();
      },
    );
  }

  Future<bool> _biometriaDisponivel() async {
    try {
      return await autenticacaoLocal.canCheckBiometrics &&
          await autenticacaoLocal.isDeviceSupported();
    } on PlatformException catch (error) {
      print(error);
      return false;
    }
  }

  Future<void> _autenticarCliente(context) async {
    bool autenticacao = false;
    autenticacao = await autenticacaoLocal.authenticate(
        localizedReason:
            'Por favor, autentique-se via biometria para acessar o app do Bytebank',
        useErrorDialogs: true,
        biometricOnly: true);
    Provider.of<Cliente>(context).biometria = autenticacao;
  }
}
