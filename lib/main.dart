import 'package:drawer_aula_flutter/screens/cadastro_pessoa.dart';
import 'package:drawer_aula_flutter/screens/calculadora.dart';
import 'package:drawer_aula_flutter/screens/converter_moeda.dart';
import 'package:drawer_aula_flutter/screens/home.dart';
import 'package:drawer_aula_flutter/screens/jogo_numero.dart';
import 'package:drawer_aula_flutter/screens/lista_telefonica.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DrawerDemo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 75, 3, 138),
        ),
      ),
      routes: {
        '/home': (context) => const HomePage(),
        '/adivinhar': (context) => const JogoNumero(), 
        '/calculadora': (context) => const CalculadoraApp(),
        '/converterMoeda': (context) => const ConverterMoedaApp(),
       // '/temperatura': (context) => const TemperaturaApp(),
        '/listaTelefonica': (context) => const ListaTelefonica(),
        '/cadastro-pessoa': (context) => CadastroPessoaApp(),
      },
          
    );
  }
}
