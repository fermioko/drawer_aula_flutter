import 'package:flutter/material.dart';

class JogoNumero extends StatefulWidget {
  const JogoNumero({Key? key}) : super(key: key);

  @override
  _JogoNumeroState createState() => _JogoNumeroState();
}

class _JogoNumeroState extends State<JogoNumero> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adivinhar o número'),
      ),
     
      body: Center(
        child: Text('Aqui será o jogo de adivinhar o número!'),
      ),
    );
  }
}