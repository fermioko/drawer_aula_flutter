import 'package:flutter/material.dart';

class ConverterMoedaApp extends StatefulWidget {
  const ConverterMoedaApp({Key? key}) : super(key: key);

  @override
  _ConverterMoedaState createState() => _ConverterMoedaState();
}

class _ConverterMoedaState extends State<ConverterMoedaApp> {
  final TextEditingController _moedaReal = TextEditingController();
  String _resultado = '';

  void _converterMoeda(String moeda) {
    final m1 = double.tryParse(_moedaReal.text.replaceAll(',', '.'));

    if (m1 == null) {
      setState(() => _resultado = 'Valor inválido');
      return;
    }

    double res;
    switch (moeda) {
      case 'dolar':
        res = m1 / 5.5239005; //dólar americano
        break;
      case 'iene':
        res = m1 / 0.0376; //iene japonês
        break;
      case 'pesoAr':
        res = m1 / 0.004388; //peso argentino
        break;
      default:
        res = m1 / 0.004029; // won sul-coreano
        break;
    }
    setState(() => _resultado = res.toString());
  }

  /* Cotacao para dia 24/07/2025
  Dólar Americano (USD) USD (dólar)
  Cotação: 5,5239005 BRL
  Cálculo: 790 ÷ 5,5239005 = 143,06 USD

  Iene Japonês (JPY) JPY (iene)
  Cotação: 0,0376 BRL
  Cálculo: 790 ÷ 0,0376 = 21.010,64 JPY

  Peso Argentino (ARS) ARS (peso)
  Cotação: 0,004388 BRL
  Cálculo: 790 ÷ 0,004388 = 180.066,49 ARS

  Won Sul-Coreano (KRW) KRW (won)
  Cotação: 0,004029 BRL
  Cálculo: 790 ÷ 0,004029 = 196.164,89 KRW

*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor de Moeda'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(180, 60), // Tamanho padrão só nesta tela
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _moedaReal,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Moeda em Real',
                  labelStyle: TextStyle(fontSize: 24),
                ),
              ),

             
              const SizedBox(height: 40), // espacamento entre o campo e botao

              Center(
                child: Wrap(
                  spacing: 16, // espço horizontal entre os botoes
                  runSpacing: 16, //espaco vertical entre botoes
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _converterMoeda('dolar'),
                      child: const Text(' USD'),
                    ),
                    ElevatedButton(
                      onPressed: () => _converterMoeda('iene'),
                      child: const Text('Iene'),
                    ),
                    ElevatedButton(
                      onPressed: () => _converterMoeda('pesoAr'),
                      child: const Text('Peso Arg'),
                    ),
                    ElevatedButton(
                      onPressed: () => _converterMoeda('won'),
                      child: const Text('Won-Krw'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50), //botoes de moeda em linha

              Text(
                _resultado,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
