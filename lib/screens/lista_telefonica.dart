import 'dart:convert';
import 'package:drawer_aula_flutter/models/agenda.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListaTelefonica extends StatefulWidget {
  const ListaTelefonica({Key? key}) : super(key: key);

  @override
  _ListaTelefonicaState createState() => _ListaTelefonicaState();
}

class _ListaTelefonicaState extends State<ListaTelefonica> {
  late Future<Agenda> _agendaFuture;

  @override
  void initState() {
    super.initState();
    _agendaFuture = carregarAgenda();
  }

  Future<Agenda> carregarAgenda() async {
    final urlString =
        'https://6ac96b23-6d8a-47ad-9214-e3b57319eabc.mock.pstmn.io/lista-telefonica';
    final url = Uri.parse(urlString);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Agenda.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao carregar agenda: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista Telefônica')),
      body: FutureBuilder<Agenda>(
        future: _agendaFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          final contatos = snapshot.data!.dados;

          return ListView.builder(
            itemCount: contatos.length,
            itemBuilder: (context, index) {
              final contato = contatos[index];
              return ListTile(
                leading: const Icon(Icons.person),
                title: Text(contato.pessoa),
                subtitle: Text(contato.telefone),
              );
            },
          );
        },
      ),
    );
  }
}
