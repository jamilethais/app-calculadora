import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';


class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final String _limpar = 'Limpar';
  String _expressao = '';
  String _resultado = '';

  void _pressionarBotao(String Valor) {
    setState(() {
      if (Valor == 'Limpar') {
        _expressao = '';
        _resultado = '';
      } else if (Valor == '=') {
        _calcularResultado();
      } else {
        _expressao += Valor;
      }
    });
  }

  void _calcularResultado() {
    setState(() {
      _resultado = _AvaliarExpressao(_expressao).toString();
    });
  }

  double _AvaliarExpressao(String expressao) {
    //Avaliar a espressao com a biblioteca expressions
    ExpressionEvaluator avaliador = const ExpressionEvaluator();
    double resultado = avaliador.eval(Expression.parse(expressao), {});
    return resultado;
  }

  Widget _botao(String Valor) {
    return TextButton(
      child: Text(
        Valor,
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      onPressed: () => _pressionarBotao(Valor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Text(_expressao, style: const TextStyle(fontSize: 24))),
        Expanded(child: Text(_resultado, style: const TextStyle(fontSize: 24))),
        Expanded(
          flex: 4,
          child: GridView.count(
            crossAxisCount: 4,
            childAspectRatio: 1,
            children: [
              _botao('7'),
              _botao('8'),
              _botao('9'),
              _botao('/'),
              _botao('4'),
              _botao('5'),
              _botao('6'),
              _botao('*'),
              _botao('1'),
              _botao('2'),
              _botao('3'),
              _botao('-'),
              _botao('0'),
              _botao('.'),
              _botao('='),
              _botao('+'),
            ],
          ),
        ),
        Expanded(child: _botao(_limpar)),
      ],
    );
  }
}
