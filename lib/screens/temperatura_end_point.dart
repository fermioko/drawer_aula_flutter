import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TemperaturaEPApp extends StatefulWidget {
  const TemperaturaEPApp({Key? key}) : super(key: key);

  @override
  State<TemperaturaEPApp> createState() => _TemperaturaStateEP();
}

class _TemperaturaStateEP extends State<TemperaturaEPApp> {
  final TextEditingController _celsiusController = TextEditingController();
  String _resultado = '';

  /// Faz a requisição para o backend e exibe o resultado de acordo com o tipo
  Future<void> _converterTemperatura(String tipo) async {
    final celsiusText = _celsiusController.text.trim();

    if (celsiusText.isEmpty) {
      setState(() => _resultado = 'Por favor, insira um valor em Celsius.');
      return;
    }

    //Se o user inserir uma ','ele subistitue por '.'
    double? celsius = double.tryParse(celsiusText.replaceAll(',', '.'));

    if (celsius == null) {
      setState(() => _resultado = 'Valor inválido. Use ponto como separador decimal.');
      return;
    }

    const String url = 'http://192.168.56.1:8080/converter/temperatura';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'celsius': celsius,
          'tipo': tipo.toLowerCase(),
          }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          if (tipo == 'Fahrenheit') {
            _resultado = 'Fahrenheit: ${data['fahrenheit']}';
          } else if (tipo == 'Kelvin') {
            _resultado = 'Kelvin: ${data['kelvin']}';
          } else {
            _resultado = 'Tipo de conversão inválido.';
          }
        });
      } else {
        setState(() {
          _resultado = 'Erro ${response.statusCode}: não foi possível converter.';
        });
      }
    } catch (e) {
      setState(() => _resultado = 'Erro de conexão: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor de Temperatura'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _celsiusController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Digite a temperatura em Celsius:',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _converterTemperatura('Fahrenheit'),
                  child: const Text('Fahrenheit'),
                ),
                ElevatedButton(
                  onPressed: () => _converterTemperatura('Kelvin'),
                  child: const Text('Kelvin'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              _resultado,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
