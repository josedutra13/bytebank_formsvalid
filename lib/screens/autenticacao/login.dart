import 'package:brasil_fields/brasil_fields.dart';
import 'package:bytebank_formsvalid/components/mensagem.dart';
import 'package:bytebank_formsvalid/screens/autenticacao/register.dart';
import 'package:bytebank_formsvalid/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';

class Login extends StatelessWidget {
  final TextEditingController cpf_controller = TextEditingController();
  final TextEditingController senha_controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/bytebank_logo.png',
                  width: 200,
                )),
            const SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 300,
                height: 455,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: _criarForm(context)),
              ),
            )
          ],
        )),
      ),
    );
  }

  Widget _criarForm(context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text(
            'Faça seu login',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            validator: (value) => Validator.cpf(value) ? 'CPF invalido' : null,
            controller: cpf_controller,
            inputFormatters: [
              // Para pegar apenas numeros
              FilteringTextInputFormatter.digitsOnly,
              CpfInputFormatter()
            ],
            decoration: InputDecoration(
                labelText: 'CPF',
                labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor))),
            maxLength: 14,
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Digite sua senha!';
              }
              // else if (value.length < 15) {
              //   return 'Senha invalida!';
              // }
              else {
                return null;
              }
            },
            controller: senha_controller,
            decoration: InputDecoration(
                labelText: 'Senha',
                labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor))),
            obscureText: true,
            maxLength: 15,
            keyboardType: TextInputType.text,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (cpf_controller.text == '111.111.111-11' &&
                      senha_controller.text == 'abc123') {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Dashboard()),
                        (route) => false);
                  } else {
                    emitirAlerta(
                        context: context,
                        title: 'ALERTA',
                        content: 'CPF ou Senha incorretos!');
                  }
                }
              },
              style: ButtonStyle(
                  side: MaterialStateProperty.all<BorderSide>(BorderSide(
                      width: 2,
                      color: Theme.of(context).colorScheme.secondary)),
                  textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                      color: Theme.of(context).colorScheme.secondary))),
              child: Text(
                'CONTINUAR',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Esqueci minha senha >',
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          OutlinedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Register()));
              },
              style: ButtonStyle(
                  side: MaterialStateProperty.all<BorderSide>(BorderSide(
                      width: 2,
                      color: Theme.of(context).colorScheme.secondary)),
                  textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                      color: Theme.of(context).colorScheme.secondary))),
              child: Text('Criar uma conta',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold)))
        ],
      ),
    );
  }
}
