import 'package:drawer_aula_flutter/screens/cadastro_pessoa.dart';
import 'package:drawer_aula_flutter/screens/calculadora.dart';
import 'package:drawer_aula_flutter/screens/converter_moeda.dart';
import 'package:drawer_aula_flutter/screens/form_pessoa_screen.dart';
import 'package:drawer_aula_flutter/screens/home.dart';
import 'package:drawer_aula_flutter/screens/jogo_numero.dart';
import 'package:drawer_aula_flutter/screens/lista_telefonica.dart';
import 'package:drawer_aula_flutter/screens/listar_pessoas_screen.dart';
import 'package:drawer_aula_flutter/screens/menu_pessoa_local_screen.dart';
import 'package:drawer_aula_flutter/screens/temperatura.dart';
import 'package:drawer_aula_flutter/screens/temperatura_end_point.dart';
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
        '/converter-moeda': (context) => const ConverterMoedaApp(),
        '/converter-temperatura': (context) => const TemperaturaApp(),
        '/converter-temperatura-ep': (context) => const TemperaturaEPApp(),
        '/lista-telefonica': (context) => const ListaTelefonica(),
        '/cadastro-pessoa': (context) => CadastroPessoaApp(),

        '/menu-sqlite': (context) => const SalvarPessoaLocalScreen(),
        '/form-pessoa': (context) => const FormPessoaScreen(),
        '/listar-pessoas': (context) => const ListarPessoasScreen(),

      },
          
    );
  }
}
