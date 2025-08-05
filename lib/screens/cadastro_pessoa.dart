import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CadastroPessoaApp extends StatefulWidget {
  const CadastroPessoaApp({super.key});

  @override
  _CadastroPessoaAppState createState() => _CadastroPessoaAppState();
}

class _CadastroPessoaAppState extends State<CadastroPessoaApp> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _documentoController = TextEditingController();
  String _mensagem = '';

  Future<void> _salvarPessoa() async {
    final String nome = _nomeController.text.trim();
    final int? idade = int.tryParse(_idadeController.text.trim());
    final int? documento = int.tryParse(_documentoController.text.trim());

    if (nome.isEmpty || idade == null || documento == null) {
      setState(() {
        _mensagem = 'Preencha todos os campos corretamente.';
      });
      return;
    }

    // Mapa <key, Value> no caso string e o dynamic
    //que pode ser de qualquer tipo
    final Map<String, dynamic> pessoaJson = {
      'nome': nome,
      'idade': idade,
      'documento': documento,
    };

    const String url = 'http://192.168.56.1:8080/pessoa/salvar';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(pessoaJson),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          _mensagem = 'Pessoa salva com sucesso!';
        });
      } else {
        setState(() {
          _mensagem = 'Erro ao salvar: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _mensagem = 'Erro de conexão: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Pessoa')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Digite um nome'),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: _idadeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Digite uma idade'),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: _documentoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Digite um documento',
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _salvarPessoa,
              child: const Text('Salvar'),
            ),
            const SizedBox(height: 20),

            Text(
              _mensagem,
              style: const TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 181, 5, 46),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
