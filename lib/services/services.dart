import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:streamingvideo/models/episodios.dart';
import 'package:streamingvideo/models/filmes.dart';
import 'package:streamingvideo/models/series.dart';
import 'package:streamingvideo/pages/listarfilmes.dart';

class Service {

  static Future<Filmes> autenticar(String usuario, String senha) async {
    String jsonResponse;
    int status;
    try {
      var url = Uri.parse('https://streamingvideoapi.herokuapp.com/usuario/autenticar');
      var response =
        await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8'
        },
        body:
        jsonEncode(<String, String>{
          'email' : usuario,
          'senha' : senha,
        }),
      );
      status = response.statusCode;
      jsonResponse = response.body;
      print("${response.headers} \n ${response.statusCode} \n ${response.body}");
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<bool> cadastrarUsuario(String usuario, String nome, String senha) async {
    String jsonResponse;
    int status;
    try {
      var url = Uri.parse('https://streamingvideoapi.herokuapp.com/usuario/insert');
      var response =
      await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8'
        },
        body:
        jsonEncode(<String, dynamic>{
          'login' : usuario,
          'nome' : nome,
          'senha' : senha,
          'administrador' : true,
        }),
      );
      status = response.statusCode;
      jsonResponse = response.body;
      print("${response.headers} \n ${response.statusCode} \n ${response.body}");
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<bool> cadastrarFilme(String titulo, String sinopse, String ano, String datalancamento, String genero) async {
    String jsonResponse;
    int status;
    print(titulo);
    try {
      var url = Uri.parse('https://streamingvideoapi.herokuapp.com/filme/insert');
      var response =
          await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8'
        },
        body:
        jsonEncode(<String, dynamic>{
          'titulo' : titulo,
          'sinopse' : sinopse,
          'ano' : int.parse(ano),
          'dataLancamento' : datalancamento,
          'listaGenero' : genero,
        }),
      );
      status = response.statusCode;
      jsonResponse = response.body;
      print("${response.headers} \n ${response.statusCode} \n ${response.body}");
    } catch (e) {
      print(e.toString());
    }
    if(status == 200) return true;
    else return false;
  }

  static Future<List<Filmes>> listarFilmes() async {
    http.Response response;
    try {
      response = await http.get("https://streamingvideoapi.herokuapp.com/filme/find-all/");
      print("${response.headers} \n ${response.statusCode} \n ${response.body}");

      List<dynamic> dados = await json.decode(response.body);
      List<Filmes> filmes = dados.map((filme) => Filmes.fromJson(filme)).toList();
      return filmes;
    } catch (Exception) {
      print(Exception);
      return null;
    }
  }

  static Future<bool> atualizarFilme(String id, String titulo, String sinopse, String ano, String datalancamento, String genero) async {
    String jsonResponse;
    int status;
    print(titulo);
    try {
      var url = Uri.parse('https://streamingvideoapi.herokuapp.com/filme/update');
      var response =
          await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8'
        },
        body:
        jsonEncode(<String, dynamic>{
          'idTitulo' : int.parse(id),
          'titulo' : titulo,
          'sinopse' : sinopse,
          'ano' : int.parse(ano),
          'dataLancamento' : datalancamento,
          'listaGenero' : genero,
        }),
      );
      status = response.statusCode;
      jsonResponse = response.body;
      print("${response.headers} \n ${response.statusCode} \n ${response.body}");
    } catch (e) {
      print(e.toString());
    }
    if(status == 200) return true;
    else return false;

  }

  static Future<Filmes> listarFilmePorId(int id) async {
    http.Response response;
    try {
      response = await http.get("https://streamingvideoapi.herokuapp.com/filme/find-by-id/$id");
      print("${response.headers} \n ${response.statusCode} \n ${response.body}");

      Map<String, dynamic> dados = await json.decode(response.body);
      Filmes filme = Filmes.fromJson(dados);
      return filme;
    } catch (Exception) {
      print(Exception);
      return null;
    }
  }

  static Future<bool> deletarFilme(String id) async {
    http.Response response;
    int idtitulo = int.parse(id);
    try {
      response = await http.post("https://streamingvideoapi.herokuapp.com/filme/delete/$idtitulo");
      print("${response.headers} \n ${response.statusCode} \n ${response.body}");
    } catch (Exception) {
      print(Exception);
    }
    if(response.statusCode == 200) return true;
    else return false;
  }

  static Future<bool> cadastrarSerie(String titulo, String sinopse, String ano, String numeroTemporada, String anoFim, String genero) async {
    String jsonResponse;
    int status;
    try {
      var url = Uri.parse('https://streamingvideoapi.herokuapp.com/serie/insert-serie');
      var response =
      await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8'
        },
        body:
        jsonEncode(<String, dynamic>{
          'titulo' : titulo,
          'sinopse' : sinopse,
          'ano' : int.parse(ano),
          'numeroTemporada' : int.parse(numeroTemporada),
          'anoFim' : anoFim,
          'listaGenero' : genero,
          'listaEpisodio' : [],
        }),
      );
      status = response.statusCode;
      jsonResponse = response.body;
      print("${response.headers} \n ${response.statusCode} \n ${response.body}");
    } catch (e) {
      print(e.toString());
    }
    if(status == 200) return true;
    else return false;
  }

  static Future<List<Series>> listarSeries() async {
    http.Response response;
    try {
      response = await http.get("https://streamingvideoapi.herokuapp.com/serie/find-all");
      print(" --- Listar Series --- ");
      print("${response.headers} \n ${response.statusCode} \n ${response.body}");

      List<dynamic> dados = await json.decode(response.body);
      List<Series> series = dados.map((serie) => Series.fromJson(serie)).toList();
      return series;
    } catch (Exception) {
      print(Exception);
      return null;
    }
  }

  static Future<Series> listarSeriePorId(int id) async {
    http.Response response;
    try {
      response = await http.get("https://streamingvideoapi.herokuapp.com/serie/find-by-id/$id");
      print(" --- Listar Series Por ID --- ");
      print("${response.headers} \n ${response.statusCode} \n ${response.body}");

      Map<String, dynamic> dados = await json.decode(response.body);
      Series serie = Series.fromJson(dados);
      return serie;
    } catch (Exception) {
      print(Exception);
      return null;
    }
  }

  static Future<bool> atualizarSerie(String id, String titulo, String sinopse, String ano, String numeroTemporada, String anoFim, String genero) async {
    String jsonResponse;
    int status;
    try {
      var url = Uri.parse('https://streamingvideoapi.herokuapp.com/serie/update-serie');
      var response =
      await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8'
        },
        body:
        jsonEncode(<String, dynamic>{
          'idSerie' : int.parse(id),
          'titulo' : titulo,
          'sinopse' : sinopse,
          'ano' : int.parse(ano),
          'numeroTemporada' : int.parse(numeroTemporada),
          'anoFim' : anoFim,
          'listaGenero' : genero,
        }),
      );
      status = response.statusCode;
      jsonResponse = response.body;
      print(" --- Atualizar Serie --- ");
      print("${response.headers} \n ${response.statusCode} \n ${response.body}");
    } catch (e) {
      print(" --- Atualizar Serie --- ");
      print(e.toString());
    }
    if(status == 200) return true;
    else return false;

  }

  static Future<List<Episodios>> listarEpisodios(String idSerie) async {
    http.Response response;
    try {
      response = await http.get("https://streamingvideoapi.herokuapp.com/serie/find-episodio-by-id-serie/$idSerie");
      print("${response.headers} \n ${response.statusCode} \n ${response.body}");

      List<dynamic> dados = await json.decode(response.body);
      List<Episodios> episodios = dados.map((e) => Episodios.fromJson(e)).toList();
      return episodios;
    } catch (Exception) {
      print(Exception);
      return null;
    }
  }

  static Future<Episodios> listarEpisodioPorId(int idEpisodio) async {
    http.Response response;
    try {
      response = await http.get("https://streamingvideoapi.herokuapp.com/serie/find-episodio-by-id/$idEpisodio");
      print("${response.headers} \n ${response.statusCode} \n ${response.body}");

      Map<String, dynamic> dados = await json.decode(response.body);
      Episodios episodio = Episodios.fromJson(dados);
      return episodio;
    } catch (Exception) {
      print(Exception);
      return null;
    }
  }

  static
  atualizarEpisodio(String idEpisodio, String titulo, String sinopse, String numero, String temporada, String idSerie) async {
    String jsonResponse;
    int status;
    print(titulo);
    try {
      var url = Uri.parse(
          'https://streamingvideoapi.herokuapp.com/serie/update-episodio');
      var response =
      await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8'
        },
        body:
        jsonEncode(<String, dynamic>{
          "idEpisodio": idEpisodio,
          "numero": numero,
          "titulo": titulo,
          "sinopse": sinopse,
          "temporada": temporada,
          "idSerie": idSerie,
        }),
      );
      status = response.statusCode;
      jsonResponse = response.body;
      print(
          "${response.headers} \n ${response.statusCode} \n ${response.body}");
    } catch (e) {
      print(e.toString());
    }
    if (status == 200)
      return true;
    else
      return false;
  }

  static deletarEpisodio(idEpisodio) async {
    http.Response response;
    int idEp = int.parse(idEpisodio);
    try {
      response = await http.post("https://streamingvideoapi.herokuapp.com/serie/delete-episodio/$idEp");
      print("${response.headers} \n ${response.statusCode} \n ${response.body}");
    } catch (Exception) {
      print(Exception);
    }
    if(response.statusCode == 200) return true;
    else return false;
  }

  static CadastrarEpisodio(String titulo, String sinopse, String numero, String temporada, String idSerie) async {
    String jsonResponse;
    int status;
    print(titulo);
    try {
      var url = Uri.parse(
          'https://streamingvideoapi.herokuapp.com/serie/insert-episodio');
      var response =
          await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8'
        },
        body:
        jsonEncode(<String, dynamic>{
          "numero": int.parse(numero),
          "titulo": titulo,
          "sinopse": sinopse,
          "temporada": int.parse(temporada),
          "idSerie": int.parse(idSerie),
        }),
      );
      status = response.statusCode;
      jsonResponse = response.body;
      print("${response.headers} \n ${response.statusCode} \n ${response.body}");
    } catch (e) {
      print(e.toString());
    }
    if (status == 200)
      return true;
    else
      return false;
  }

  static Future<bool> deletarSerie(String id) async {
    http.Response response;
    int idSerie = int.parse(id);
    try {
      response = await http.post("https://streamingvideoapi.herokuapp.com/serie/delete-serie/$idSerie");
      print("${response.headers} \n ${response.statusCode} \n ${response.body}");
    } catch (Exception) {
      print(Exception);
    }
    if(response.statusCode == 200) return true;
    else return false;
  }
}
