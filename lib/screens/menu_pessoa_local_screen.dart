import 'package:flutter/material.dart';

class SalvarPessoaLocalScreen extends StatelessWidget {
  const SalvarPessoaLocalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salvar Pessoa Localmente'),
      ),
      body: Center(
        child: Text('Tela para salvar pessoa localmente'),
      ),
    );
  }

}
