import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CalculadoraAppEP extends StatefulWidget {
  const CalculadoraAppEP({Key? key}) : super(key: key);

  @override
  _CalculadoraStateEP createState() => _CalculadoraStateEP();
}

class _CalculadoraStateEP extends State<CalculadoraAppEP> {
  final TextEditingController _c1Controller = TextEditingController();
  final TextEditingController _c2Controller = TextEditingController();
  String _resultado = '';

  Future<void> _calcular(String tipo) async {
    final c1Text = _c1Controller.text.trim();
    final c2Text = _c2Controller.text.trim();

    if (c1Text.isEmpty || c2Text.isEmpty) {
      setState(() {
        _resultado = 'Por favor, insira os valores.';
      });
      return;
    }

    final double? c1 = double.tryParse(c1Text.replaceAll(',', '.'));
    final double? c2 = double.tryParse(c2Text.replaceAll(',', '.'));

    if (c1 == null || c2 == null) {
      setState(() {
        _resultado = 'Valores inválidos. Use ponto como separador decimal.';
      });
      return;
    }

    final operacaoSimbolo = _mapTipoParaSimbolo(tipo);
    if (operacaoSimbolo.isEmpty) {
      setState(() {
        _resultado = 'Tipo de operação inválida.';
      });
      return;
    }

    const url = 'http://192.168.56.1:8080/calcular/operacao';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'num1': c1,
          'num2': c2,
          'operacao': operacaoSimbolo,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data.containsKey('resultado')) {
          setState(() {
            _resultado = '${_nomeOperacao(tipo)}: ${data['resultado']}';
          });
        } else if (data.containsKey('error')) {
          setState(() {
            _resultado = 'Erro no cálculo (divisão por zero?).';
          });
        } else {
          setState(() {
            _resultado = 'Resposta inesperada do servidor.';
          });
        }
      } else {
        setState(() {
          _resultado = 'Erro ${response.statusCode}: não foi possível calcular.';
        });
      }
    } catch (e) {
      setState(() {
        _resultado = 'Erro de conexão: $e';
      });
    }
  }

  String _mapTipoParaSimbolo(String tipo) {
    switch (tipo.toLowerCase()) {
      case 'somar':
        return '+';
      case 'subtrair':
        return '-';
      case 'multiplicar':
        return '*';
      case 'dividir':
        return '/';
      default:
        return '';
    }
  }

  String _nomeOperacao(String tipo) {
    switch (tipo.toLowerCase()) {
      case 'somar':
        return 'Soma';
      case 'subtrair':
        return 'Subtração';
      case 'multiplicar':
        return 'Multiplicação';
      case 'dividir':
        return 'Divisão';
      default:
        return 'Operação';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora End Point'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _c1Controller,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Digite um número',
                labelStyle: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _c2Controller,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Digite outro número',
                labelStyle: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _calcular('somar'),
                  child: const Text('+'),
                ),
                ElevatedButton(
                  onPressed: () => _calcular('subtrair'),
                  child: const Text('-'),
                ),
                ElevatedButton(
                  onPressed: () => _calcular('multiplicar'),
                  child: const Text('*'),
                ),
                ElevatedButton(
                  onPressed: () => _calcular('dividir'),
                  child: const Text('/'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              _resultado,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

/* class CalculadoraAppEP extends StatefulWidget {
  const CalculadoraAppEP({Key? key}) : super(key: key);

  @override
  _CalculadoraStateEP createState() => _CalculadoraStateEP();
}

class _CalculadoraStateEP extends State<CalculadoraAppEP> {
  final TextEditingController _c1Controller = TextEditingController();
  final TextEditingController _c2Controller = TextEditingController();
  String _resultado = '';

  // Faz a requisição para o backend e exibe o resultado de acordo com o tipo
  Future<void> _CalculadoraEP(String tipo) async {
  final c1Text = _c1Controller.text.trim();
  final c2Text = _c2Controller.text.trim();

  if (c1Text.isEmpty || c2Text.isEmpty) {
    setState(() => _resultado = 'Por favor, insira os valores.');
    return;
  }

  double? c1 = double.tryParse(c1Text.replaceAll(',', '.'));
  double? c2 = double.tryParse(c2Text.replaceAll(',', '.'));

  if (c1 == null || c2 == null) {
    setState(() => _resultado = 'Valores inválidos. Use ponto como separador decimal.');
    return;
  }

  final operacaoSimbolo = _mapTipoParaSimbolo(tipo);
  if (operacaoSimbolo.isEmpty) {
    setState(() => _resultado = 'Tipo de operação inválida.');
    return;
  }

  const String url = 'http://192.168.56.1:8080/calcular/operacao';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'num1': c1,
        'num2': c2,
        'operacao': operacaoSimbolo,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _resultado = '${_nomeOperacao(tipo)}: ${data['resultado']}';
      });
    } else {
      setState(() => _resultado = 'Erro ${response.statusCode}: não foi possível calcular.');
    }
  } catch (e) {
    setState(() => _resultado = 'Erro de conexão: $e');
  }
}

String _mapTipoParaSimbolo(String tipo) {
  switch (tipo.toLowerCase()) {
    case 'somar': return '+';
    case 'subtrair': return '-';
    case 'multiplicar': return '*';
    case 'dividir': return '/';
    default: return '';
  }
}

String _nomeOperacao(String tipo) {
  switch (tipo.toLowerCase()) {
    case 'somar': 
    return 'Soma';
    case 'subtrair': 
    return 'Subtração';
    case 'multiplicar': 
    return 'Multiplicação';
    case 'dividir': 
    return 'Divisão';
    default: 
    return 'Operação';
  }
} */
  
  /* Future<void> _CalculadoraEP(String tipo) async {
    final c1Text = _c1Controller.text.trim();
    final c2Text = _c2Controller.text.trim();

    if (c1Text.isEmpty || c2Text.isEmpty) {
      setState(() => _resultado = 'Por favor, insira os valores.');
      return;
    }

    // Se o user inserir uma ',' ele substitui por '.'
    double? c1 = double.tryParse(c1Text.replaceAll(',', '.'));
    double? c2 = double.tryParse(c2Text.replaceAll(',', '.'));

    if (c1 == null || c2 == null) {
      setState(
        () =>
            _resultado = 'Valores inválidos. Use ponto como separador decimal.',
      );
      return;
    }

    const String url = 'http://192.168.56.1:8080/calcular/operacao';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'c1': c1, 
          'c2': c2,
          'operacao': tipo.characters.join().toLowerCase(),
        }),
      );
      // Verifica se a resposta foi bem-sucedida
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          if (tipo == 'somar') {
            _resultado = 'Soma: ${data['resultado']}';
          } else if (tipo == 'subtrair') {
            _resultado = 'Subtração: ${data['resultado']}';
          } else if (tipo == 'multiplicar') {
            _resultado = 'Multiplicação: ${data['resultado']}';
          } else if (tipo == 'dividir') {
            _resultado = 'Divisão: ${data['resultado']}';
          } else {
            _resultado = 'Tipo de operação inválida.';
          }
        });
      } else {
        setState(() {
          _resultado =
              'Erro ${response.statusCode}: não foi possível calcular.';
        });
      }
    } catch (e) {
      setState(() => _resultado = 'Erro de conexão: $e');
    }
  } */


 /*  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora End Point'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            //textefield para o primeiro número
            TextField(
              controller: _c1Controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Digite um número: ',
                labelStyle: TextStyle(
                  fontSize: 20,
                ), //aumenta o tamanho da label
              ),
            ),
            //textefield para o segundo número
            TextField(
              controller: _c2Controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Digite um número: ',
                labelStyle: TextStyle(
                  fontSize: 20,
                ), //aumenta o tamanho da label
              ),
            ),

            const SizedBox(height: 30),

            //espacamento entre os textfields e os botoes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _CalculadoraEP('somar'),
                  child: const Text('+'),
                ),
                ElevatedButton(
                  onPressed: () => _CalculadoraEP('subtrair'),
                  child: const Text('-'),
                ),
                ElevatedButton(
                  onPressed: () => _CalculadoraEP('multiplicar'),
                  child: const Text('*'),
                ),
                ElevatedButton(
                  onPressed: () => _CalculadoraEP('dividir'),
                  child: const Text('/'),
                ),
              ],
            ),

            //linha com os botoes de op, em horizontal (linha)
            const SizedBox(height: 24),

            Text(
              _resultado,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // exibe o resultado atual e atualiza automaticamente ao clicar no botao.
          ],
        ),
      ),
    );
  }
}
 */