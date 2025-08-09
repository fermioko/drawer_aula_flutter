import 'package:drawer_aula_flutter/helpers/banco_helper.dart';
import 'package:drawer_aula_flutter/models/pessoa.dart';
import 'package:flutter/material.dart';

class ListarPessoasScreen extends StatelessWidget {
  const ListarPessoasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pessoas Salvas')),
      body: FutureBuilder<List<Pessoa>>(
        future: BancoHelper().listarPessoas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Nenhuma pessoa salva.',
                style: TextStyle(fontSize: 20),
              ),
            );
          }

          final pessoas = snapshot.data!;

          return ListView.builder(
            itemCount: pessoas.length,
            itemBuilder: (context, index) {
              final p = pessoas[index];
              return ListTile(
                title: Text(p.nome, 
                  style: const TextStyle(fontSize: 20),
                ),
                subtitle: Text('Idade: ${p.idade}', 
                  style: const TextStyle(fontSize: 18),
                ),
              );
            },
          );
        },
      ),
    );
  }
}