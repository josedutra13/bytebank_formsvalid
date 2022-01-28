import 'package:bytebank_formsvalid/models/cliente.dart';
import 'package:bytebank_formsvalid/screens/autenticacao/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/saldo.dart';
import 'models/transferencias.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Saldo(0),
        ),
        ChangeNotifierProvider(create: (context) => Transferencias()),
        ChangeNotifierProvider(create: (context) => Cliente())
      ],
      child: const BytebankApp(),
    ));

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green[900],
        buttonTheme: const ButtonThemeData(
          buttonColor: Color.fromRGBO(71, 161, 56, 1),
          textTheme: ButtonTextTheme.primary,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.green[900],
            secondary: const Color.fromRGBO(71, 161, 56, 1),
            onSurface: Colors.green[900]),
      ),
      home: Login(),
    );
  }
}
