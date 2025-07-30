import 'package:drawer_aula_flutter/screens/home.dart';
import 'package:drawer_aula_flutter/screens/jogo_numero.dart';
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
          seedColor: const Color.fromARGB(255, 245, 225, 5),
        ),
      ),
      routes: {
        '/home': (context) => const HomePage(),
        '/adivinhar': (context) => const JogoNumero(),   
      },
          
    );
  }
}
