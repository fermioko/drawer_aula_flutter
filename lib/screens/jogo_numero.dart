import 'dart:math';
import 'package:flutter/material.dart';

class JogoNumero extends StatefulWidget {
  const JogoNumero({Key? key}) : super(key: key);

  @override
  _JogoNumeroState createState() => _JogoNumeroState();
}

class _JogoNumeroState extends State<JogoNumero> {
  final TextEditingController _controller = TextEditingController();
  int? _numeroSorteado;
  String _mensagemResultado = '';

  void _jogar() {
    final numeroDigitado = int.tryParse(_controller.text.trim());
    if (numeroDigitado == null || numeroDigitado < 1 || numeroDigitado > 3) {
      setState(() {
        _mensagemResultado = 'Digite um número válido entre 1 e 3';
        _numeroSorteado = null;
      });
      return;
    }

    final random = Random();
    final numeroAleatorio = random.nextInt(3) + 1; // 1 a 3

    setState(() {
      _numeroSorteado = numeroAleatorio;
      if (numeroDigitado == numeroAleatorio) {
        _mensagemResultado = 'ACERTOU';
      } else {
        _mensagemResultado = 'ERRRROU';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adivinhar o Número'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Digite um número entre 1 a 3',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _jogar,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 60), // largura: 200, altura: 60
                ),
              child: const Text('Jogar',
              style: TextStyle(fontSize: 24),
                ),
            ),
            const SizedBox(height: 40),
            if (_numeroSorteado != null) ...[
              Text(
                'Número sorteado = $_numeroSorteado',
                style: const TextStyle(fontSize: 35),
              ),
              const SizedBox(height: 40),
              Text(
                _mensagemResultado,
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: _mensagemResultado == 'ACERTOU' ? Colors.green : Colors.red,
                ),
              ),
            ],

            if (_numeroSorteado == null) ...[
              Text(
                _mensagemResultado,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

/*import 'package:flutter/material.dart';

class JogoNumero extends StatefulWidget {
  const JogoNumero({Key? key}) : super(key: key);

  @override
  _JogoNumeroState createState() => _JogoNumeroState();
}

class _JogoNumeroState extends State<JogoNumero>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adivinhar o Número'),
      ),
      body: Center(
        child: Text('Aqui será o jogo de adivinhar o número!'),
      ),
    );
  }
}*/