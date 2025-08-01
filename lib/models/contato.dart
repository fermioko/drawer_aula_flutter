class Contato {
  final String pessoa;
  final String telefone;

  Contato(
    {
      required this.pessoa, 
      required this.telefone
    }
  );

  // Converter o objeto Contato em um mapa JSON
  factory Contato.fromJson(Map<String, dynamic> json) {
    return Contato(
      pessoa: json['pessoa'],
      telefone: json['telefone'],
    );
  } 

  // Converter um objeto mapa JSON em um objeto
  Map<String, dynamic> toJson() {
    return {
      'pessoa': pessoa,
      'telefone': telefone,
    };
  }



}