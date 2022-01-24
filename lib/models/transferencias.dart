import 'package:bytebank_formsvalid/models/transferencia.dart';
import 'package:flutter/foundation.dart';

class Transferencias extends ChangeNotifier {
  final List<Transferencia> _transferencias = [];

  List<Transferencia> get transferencias => _transferencias;

  adiciona(Transferencia ntransferencia) {
    _transferencias.add(ntransferencia);

    notifyListeners();
  }
}
