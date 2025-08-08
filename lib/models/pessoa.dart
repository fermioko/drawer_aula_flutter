class Pessoa {
  final int? id;
  final String nome;
  final int idade;

  Pessoa({this.id, required this.nome, required this.idade});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'idade': idade,
    };
  }

  static Pessoa fromMap(Map<String, dynamic> map) {
    return Pessoa(
      id: map['id'],
      nome: map['nome'],
      idade: map['idade'],
    );
  }
}