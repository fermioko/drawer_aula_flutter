import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TemperaturaEPApp extends StatefulWidget {
  const TemperaturaEPApp({Key? key}) : super(key: key);

  @override
  _TemperaturaStateEP createState() => _TemperaturaStateEP();
}

class _TemperaturaStateEP extends State<TemperaturaEPApp> {
  final TextEditingController _celsiusController = TextEditingController();
  String _resultado = '';

  Future<void> _converterTemperatura() async {
    final String celsius = _celsiusController.text.trim();

    if (celsius.isEmpty) {
      setState(() {
        _resultado = 'Por favor, insira um valor em Celsius.';
      });
      return;
    }

    final Map<String, dynamic> temperaturaJson = {'celsius': celsius};

    const String url = 'http://192.168.56.1:8080/temperatura/converter';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(temperaturaJson),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final double fahrenheit = data['fahrenheit'];
        final double kelvin = data['kelvin'];

        setState(() {
          _resultado = 'Fahrenheit: $fahrenheit\nKelvin: $kelvin';
        });
      } else {
        setState(() {
          _resultado = 'Erro ao converter temperatura: ${response.statusCode}';
        });
      }   


    } catch (e) {
      setState(() {
        _resultado = 'Erro de conexão: $e';
      });
    }
  }

  /* double converter_para_fahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }

  double converter_para_kelvin(double celsius) {
    return celsius + 273.15;
  }

  void _converter(String op) {
    final temperatura = double.tryParse(_tempC.text.replaceAll(',', '.'));

    if (temperatura == null) {
      setState(() => _resultado = 'Entrada invalida');
      return;
    }

    double res;
    switch (op) {
      case 'Fahrenheit':
        res = converter_para_fahrenheit(temperatura);
        break;
      default:
        res = converter_para_kelvin(temperatura);
        break;
    }

    setState(() => _resultado = res.toString());
  }
 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Conversor de Temperatura EndPoint'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _celsiusController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Digite uma temperatura em Celsius: ',
              ),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () =>  _converterTemperatura,
                  child: const Text('Fahrenheit'),
                ),
                ElevatedButton(
                  onPressed: () =>  _converterTemperatura,
                  child: const Text('Kelvin'),
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
