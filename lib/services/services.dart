import 'dart:convert';
import 'package:http/http.dart' as http;
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
    return new Filmes (
    status: status,
    duracao: jsonResponse,
    descricao: jsonResponse,
    id: 0,
    );
  }

  static Future<bool> cadastrarUsuario(String usuario, String senha) async {
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

  static Future<bool> cadastrarFilme(String titulo, String sinopse, String ano, String datalancamento, String genero) async {
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
          'titulo' : titulo,
          'sinopse' : sinopse,
          'ano' : ano,
          'datalancamento' : datalancamento,
          'genero' : genero
        }),
      );
      status = response.statusCode;
      jsonResponse = response.body;
      print("${response.headers} \n ${response.statusCode} \n ${response.body}");
    } catch (e) {
      print(e.toString());
    }
    if(jsonResponse == "true") return true;
    else return false;
  }
}
