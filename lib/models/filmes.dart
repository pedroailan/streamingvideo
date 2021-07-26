class Filmes {
  final String idFilme;
  final String Titulo;
  final String Sinopse;
  final String Ano;
  final String DataLancamento;
  final List<Genero> Generos;


  Filmes( {
    this.Titulo,
    this.Sinopse,
    this.Ano,
    this.DataLancamento,
    this.Generos,
    this.idFilme,
  });



  factory Filmes.fromJson(dynamic json) {
    List<dynamic> generos = json['listaGenero'];
    List<Genero> genero = generos.map((genero) => Genero.fromJson(genero)).toList();

    return new Filmes(
      idFilme: json['idFilme'].toString().trim(),
      Titulo: json['titulo'].toString().trim(),
      Sinopse: json['sinopse'].toString().trim(),
      Ano: json['ano'].toString().trim(),
      DataLancamento: json['dataLancamento'].toString().trim(),
      Generos: genero,
    );
  }
}

class Genero {
  final String Gen;
  final String IdGen;

  Genero({
    this.Gen,
    this.IdGen,
  });

  factory Genero.fromJson(Map<String, dynamic> genero) {
    return Genero (
        Gen: genero['genero'].toString().trim(),
        IdGen: genero['idGenero'].toString().trim()
    );
  }
}
