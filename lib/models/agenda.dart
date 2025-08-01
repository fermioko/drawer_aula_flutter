import 'package:drawer_aula_flutter/models/contato.dart';

class Agenda {
  final List<Contato> dados;

  Agenda(
    {
      required this.dados
      }
  );

  factory Agenda.fromJson(Map<String, dynamic> json) {
    return Agenda(
      dados: List<Contato>.from(
        json['dados'].map((e) => Contato.fromJson(e))
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dados': dados.map((e) => e.toJson()).toList(),
    };
  }

}
