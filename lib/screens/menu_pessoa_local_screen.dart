import 'package:drawer_aula_flutter/helpers/banco_helper.dart';
import 'package:flutter/material.dart';

class SalvarPessoaLocalScreen extends StatelessWidget {
  const SalvarPessoaLocalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Salvar Pessoa Local')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text(
                'Salvar Pessoa Local',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/form-pessoa');
              },
            ),

            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text(
                'Listar Pessoas',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/listar-pessoas');
              },
            ),

            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Deletar Tudo', style: TextStyle(fontSize: 20)),
              onPressed: () async {
                final confirmacao = await showDialog<bool>(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Confirmar'),
                    content: const Text(
                      'Apagar todas as pessoas do banco?',
                      style: TextStyle(fontSize: 20),
                    ),

                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancelar',
                          style: TextStyle(fontSize: 20),                        
                        ),
                      ),

                      TextButton(
                        onPressed: () => Navigator.pop(context,true),
                        child: const Text('Apagar',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),

                    ],

                  ),
                );
                if (confirmacao == true) {
                  final deletadas = await BancoHelper().deletarTodasPessoas();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '######## Deletadas $deletadas pessoas do banco!',
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
