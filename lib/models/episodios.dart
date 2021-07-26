class Episodios {
  final String idEpisodio;
  final String idSerie;
  final String Numero;
  final String Titulo;
  final String Sinopse;
  final String Temporada;

  Episodios( {
    this.idEpisodio,
    this.Numero,
    this.Titulo,
    this.Sinopse,
    this.Temporada,
    this.idSerie,
  });

  factory Episodios.fromJson(dynamic json) {
    return new Episodios(
      idEpisodio: json['idEpisodio'].toString().trim(),
      idSerie: json['idSerie'].toString().trim(),
      Numero: json['numero'].toString().trim(),
      Titulo: json['titulo'].toString().trim(),
      Sinopse: json['sinopse'].toString().trim(),
      Temporada: json['temporada'].toString().trim(),
    );
  }
}

