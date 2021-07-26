class Series {
  final String IdSerie;
  final String Titulo;
  final String Sinopse;
  final String Ano;
  final String NumeroTemporada;
  final String AnoFim;
  final List<Genero> Generos;


  Series( {
    this.Titulo,
    this.Sinopse,
    this.Ano,
    this.NumeroTemporada,
    this.AnoFim,
    this.Generos,
    this.IdSerie,
  });



  factory Series.fromJson(dynamic json) {
    List<dynamic> generos = json['listaGenero'];
    List<Genero> genero = generos.map((genero) => Genero.fromJson(genero)).toList();

    return new Series(
      IdSerie: json['idSerie'].toString().trim(),
      Titulo: json['titulo'].toString().trim(),
      Sinopse: json['sinopse'].toString().trim(),
      Ano: json['ano'].toString().trim(),
      NumeroTemporada: json['numeroTemporada'].toString().trim(),
      AnoFim: json['anoFim'],
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
