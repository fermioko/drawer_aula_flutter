import 'package:drawer_aula_flutter/helpers/banco_helper.dart';
import 'package:drawer_aula_flutter/models/pessoa.dart';
import 'package:flutter/material.dart';

class FormPessoaScreen extends StatefulWidget {
  const FormPessoaScreen({super.key});

  @override
  State<FormPessoaScreen> createState() => _FormPessoaScreenState();
}

class _FormPessoaScreenState extends State<FormPessoaScreen> {
  final nomeController = TextEditingController();
  final idadeController = TextEditingController();

  void salvarPessoa() async {
    final nome = nomeController.text.trim();
    final idade = int.tryParse(idadeController.text.trim()) ?? 0;

    if (nome.isNotEmpty && idade > 0) {
      final pessoa = Pessoa(nome: nome, idade: idade);
      await BancoHelper().inserirPessoa(pessoa);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pessoa salva com sucesso!')),
      );

      Navigator.pop(context); // Voltar para a tela anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Pessoa')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children:[
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: 'Nome da Pessoa'),
              style: const TextStyle(fontSize: 20),
            ),

            TextField(
              controller: idadeController,
              decoration: const InputDecoration(labelText: 'Idade da Pessoa'),
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: salvarPessoa,
              child: const Text('Salvar',
                style: TextStyle(fontSize: 20),
              ),
            ),

          ],          
        ),
      ),
    );
  }
}
