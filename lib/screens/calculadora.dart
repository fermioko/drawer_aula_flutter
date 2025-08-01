import 'package:flutter/material.dart';

/* void main() {
  runApp(const CalculadoraApp());
} */

class CalculadoraApp extends StatefulWidget {
  const CalculadoraApp({Key? key}) : super(key: key);

  @override
  _CalculadoraState createState() => _CalculadoraState();
}

/* class CalculadoraScreen extends StatefulWidget {
  const CalculadoraScreen({super.key, required this.title});

  final String title;

  @override
  State<CalculadoraScreen> createState() => _CalculadoraScreenState();
}  */

class _CalculadoraState extends State<CalculadoraApp> {
  final TextEditingController _c1 = TextEditingController();
  final TextEditingController _c2 = TextEditingController();
  String _resultado = '';

  void _calcular(String op) {
    final n1 = double.tryParse(_c1.text.replaceAll(',', '.'));
    final n2 = double.tryParse(_c2.text.replaceAll(',', '.'));
    //(_c1.text.replaceAll(',','.'));
    //Se o user inserir uma ','ele subistitue por '.'
    if (n1 == null || n2 == null) {
      setState(() => _resultado = 'Entrada inválida');
      return;
    }

    //operações matemáticas e switch case para escolha
    double res;
    switch (op) {
      case '+':
        res = n1 + n2;
        break;
      case '-':
        res = n1 - n2;
        break;
      case '*':
        res = n1 * n2;
        break;
      case '/':
        if (n2 == 0) {
          setState(() => _resultado = 'Divisão por zero');
          return;
        }
        res = n1 / n2;
        break;
      default:
        return;
    }

    setState(() => _resultado = res.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            //textefield para o primeiro número
            TextField(
              controller: _c1,
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
              controller: _c2,
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
                  onPressed: () => _calcular('+'),
                  child: const Text('+'),
                ),
                ElevatedButton(
                  onPressed: () => _calcular('-'),
                  child: const Text('-'),
                ),
                ElevatedButton(
                  onPressed: () => _calcular('*'),
                  child: const Text('*'),
                ),
                ElevatedButton(
                  onPressed: () => _calcular('/'),
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
