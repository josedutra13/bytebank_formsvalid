import 'dart:io';

import 'package:flutter/material.dart';

class Cliente extends ChangeNotifier {
  String? _nome;
  String? _email;
  String? _cpf;
  String? _celular;
  String? _nascimento;
  String? _cep;
  String? _estado;
  String? _cidade;
  String? _bairro;
  String? _logradouro;
  String? _numero;
  String? _senha;

  String? get nome => _nome;

  set nome(String? nome) {
    _nome = nome;

    notifyListeners();
  }

  String? get email => _email;

  set email(String? email) {
    _email = email;
  }

  String? get cpf => _cpf;

  set cpf(String? cpf) {
    _cpf = cpf;
  }

  String? get celular => _celular;

  set celular(String? celular) {
    _celular = celular;
  }

  String? get nascimento => _nascimento;

  set nascimento(String? nascimento) {
    _nascimento = nascimento;
  }

  String? get cep => _cep;

  set cep(String? cep) {
    _cep = cep;
  }

  String? get estado => _estado;

  set estado(String? estado) {
    _estado = estado;
  }

  String? get cidade => _cidade;

  set cidade(String? cidade) {
    _cidade = cidade;
  }

  String? get bairro => _bairro;

  set bairro(String? bairro) {
    _bairro = bairro;
  }

  String? get logradouro => _logradouro;

  set logradouro(String? logradouro) {
    _logradouro = logradouro;
  }

  String? get numero => _numero;

  set numero(String? numero) {
    _numero = numero;
  }

  String? get senha => _senha;

  set senha(String? senha) {
    _senha = senha;
  }

  int _stepAtual = 0;

  int get stepAtual => _stepAtual;

  set stepAtual(int stepAtual) {
    _stepAtual = stepAtual;

    notifyListeners();
  }

  File? _image;

  File? get image => _image;

  set image(File? image) {
    _image = image;

    notifyListeners();
  }

  bool _biometria = false;

  bool get biometria => _biometria;

  set biometria(bool biometria) {
    _biometria = biometria;

    notifyListeners();
  }
}
