import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:bytebank_formsvalid/components/biometria.dart';
import 'package:bytebank_formsvalid/models/cliente.dart';
import 'package:bytebank_formsvalid/screens/dashboard/dashboard.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Register extends StatelessWidget {
  //Step 1
  final _formData = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _nascimentoController = TextEditingController();

  //Step 2
  final _formAddress = GlobalKey<FormState>();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();

  //Step 3
  final _formAuth = GlobalKey<FormState>();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController =
      TextEditingController();
  final ImagePicker _picker = ImagePicker();

  Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Cadastro de cliente'),
      ),
      body: Consumer<Cliente>(
        builder: (context, cliente, child) {
          return Theme(
            data: Theme.of(context),
            child: Stepper(
              steps: _construirStep(context, cliente),
              currentStep: cliente.stepAtual,
              onStepContinue: () {
                List<Function> functions = [
                  _salvarStep1,
                  _salvarStep2,
                  _salvarStep3
                ];

                functions[cliente.stepAtual](context);
              },
              onStepCancel: () {
                cliente.stepAtual =
                    cliente.stepAtual > 0 ? cliente.stepAtual - 1 : 0;
              },
              controlsBuilder: (context, details) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromRGBO(71, 161, 56, 1))),
                          onPressed: details.onStepContinue,
                          child: const Text(
                            'Salvar',
                            style: TextStyle(color: Colors.white),
                          )),
                      const Padding(padding: EdgeInsets.only(right: 15)),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black)),
                          onPressed: details.onStepCancel,
                          child: const Text(
                            'Voltar',
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  _salvarStep1(context) {
    if (_formData.currentState!.validate()) {
      Cliente cliente = Provider.of<Cliente>(context, listen: false);
      cliente.nome = _nomeController.text;
      _proximoStep(context);
    }
  }

  _salvarStep2(context) {
    if (_formAddress.currentState!.validate()) {
      _proximoStep(context);
    }
  }

  _salvarStep3(context) {
    if (_formAuth.currentState!.validate() &&
        Provider.of<Cliente>(context, listen: false).image != null) {
      FocusScope.of(context).unfocus();
      Provider.of<Cliente>(context, listen: false).image = null;
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard()),
          (route) => false);
    }
  }

  List<Step> _construirStep(BuildContext context, Cliente cliente) {
    List<Step> step = [
      Step(
          isActive: cliente.stepAtual >= 0,
          title: const Text('Seus Dados'),
          content: Form(
            key: _formData,
            child: Column(
              children: [
                TextFormField(
                  controller: _nomeController,
                  keyboardType: TextInputType.text,
                  maxLength: 255,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Digite um nome!';
                    } else if (value.length < 3) {
                      return 'Nome invalido!';
                    } else if (!value.contains(' ')) {
                      return 'Informe pelo menos um sobrenome';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Nome',
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor))),
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 255,
                  validator: (value) =>
                      Validator.email(value) ? 'Email invalido' : null,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor))),
                ),
                TextFormField(
                  controller: _cpfController,
                  keyboardType: TextInputType.number,
                  maxLength: 14,
                  validator: (value) =>
                      Validator.cpf(value) ? 'CPF invalido' : null,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter()
                  ],
                  decoration: InputDecoration(
                      labelText: 'CPF',
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor))),
                ),
                TextFormField(
                  controller: _celularController,
                  keyboardType: TextInputType.number,
                  maxLength: 14,
                  validator: (value) =>
                      Validator.phone(value) ? 'Celular invalido' : null,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter()
                  ],
                  decoration: InputDecoration(
                      labelText: 'Telefone',
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor))),
                ),
                DateTimePicker(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe sua data de nascimento';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Nascimento',
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor))),
                  dateLabelText: 'Nascimento',
                  controller: _nascimentoController,
                  type: DateTimePickerType.date,
                  dateMask: 'dd/MM/yyyy',
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  onChanged: (value) {
                    _nascimentoController.text = value;
                  },
                ),
              ],
            ),
          )),
      Step(
          isActive: cliente.stepAtual >= 1,
          title: const Text('Endereço'),
          content: Form(
            key: _formAddress,
            child: Column(
              children: [
                TextFormField(
                  controller: _cepController,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  validator: (value) =>
                      Validator.cep(value) ? 'Cep invalido' : null,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CepInputFormatter(ponto: false)
                  ],
                  decoration: InputDecoration(
                      labelText: 'Cep',
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor))),
                ),
                DropdownButtonFormField(
                    validator: (value) {
                      if (value == null) {
                        return 'Selecione um estado';
                      }
                      return null;
                    },
                    isExpanded: true,
                    decoration: InputDecoration(
                        labelText: 'Estado',
                        labelStyle:
                            TextStyle(color: Theme.of(context).primaryColor),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor))),
                    items: Estados.listaEstados.map((e) {
                      return DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      );
                    }).toList(),
                    onChanged: (value) {
                      _estadoController.text = value.toString();
                    }),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _cidadeController,
                  keyboardType: TextInputType.text,
                  maxLength: 255,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Digite uma Cidade!';
                    } else if (value.length < 3) {
                      return 'Cidade invalido!';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Cidade',
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor))),
                ),
                TextFormField(
                  controller: _bairroController,
                  keyboardType: TextInputType.text,
                  maxLength: 255,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Digite um Bairro!';
                    } else if (value.length < 3) {
                      return 'Bairro invalido!';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Bairro',
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor))),
                ),
                TextFormField(
                  controller: _logradouroController,
                  keyboardType: TextInputType.text,
                  maxLength: 255,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Digite um Logradouro!';
                    } else if (value.length < 3) {
                      return 'Logradouro invalido!';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Logradouro',
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor))),
                ),
                TextFormField(
                  controller: _numeroController,
                  keyboardType: TextInputType.text,
                  maxLength: 255,
                  decoration: InputDecoration(
                      labelText: 'Numero',
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor))),
                ),
              ],
            ),
          )),
      Step(
          isActive: cliente.stepAtual >= 2,
          title: const Text('Autenticação'),
          content: Form(
            key: _formAuth,
            child: Column(
              children: [
                TextFormField(
                  controller: _senhaController,
                  keyboardType: TextInputType.text,
                  maxLength: 255,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Digite uma senha!';
                    } else if (value.length < 8) {
                      return 'Senha muito pequena!';
                    } else {
                      return null;
                    }
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Senha',
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor))),
                ),
                TextFormField(
                  controller: _confirmarSenhaController,
                  keyboardType: TextInputType.text,
                  maxLength: 255,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Digite sua confirmação de senha!';
                    } else if (value != _senhaController.text) {
                      return 'Valor diferente da senha informada no campo anterior!';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Confirmar Senha',
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor))),
                ),
                const Text(
                  'Para prosseguir com o seu cadastro é necessário que tenhamos uma foto do seu RG',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromRGBO(71, 161, 56, 1))),
                    onPressed: () => _capturarRG(cliente),
                    child: const Text(
                      'Tirar foto do meu RG',
                      style: TextStyle(color: Colors.white),
                    )),
                _rgCapturado(context) ? _imageRG(context) : _pedirRG(context),
                Biometria()
              ],
            ),
          ))
    ];
    return step;
  }

  _proximoStep(context) {
    Cliente cliente = Provider.of<Cliente>(context, listen: false);
    irPara(cliente.stepAtual + 1, cliente);
  }

  irPara(int step, Cliente cliente) {
    cliente.stepAtual = step;
  }

  void _capturarRG(cliente) async {
    final pickedImage = await _picker.pickImage(source: ImageSource.camera);
    cliente.image = File(pickedImage!.path);
  }

  Image _imageRG(context) {
    return Image.file(Provider.of<Cliente>(context).image!);
  }

  Column _pedirRG(BuildContext context) {
    return Column(
      children: const <Widget>[
        SizedBox(
          height: 15,
        ),
        Text(
          'Foto do RG pendente',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  bool _rgCapturado(BuildContext context) {
    if (Provider.of<Cliente>(context).image != null) {
      return true;
    }

    return false;
  }
}
