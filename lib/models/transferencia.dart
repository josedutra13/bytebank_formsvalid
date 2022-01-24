class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(
    this.valor,
    this.numeroConta,
  );

  String toStringValor() {
    return 'R\$ $valor';
  }

  String toStringNumeroConta() {
    return 'Numero da conta: $numeroConta';
  }
}
