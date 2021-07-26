import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:streamingvideo/models/episodios.dart';
import 'package:streamingvideo/models/filmes.dart';
import 'package:streamingvideo/models/series.dart';
import 'package:streamingvideo/pages/home.dart';
import 'package:streamingvideo/pages/listarepisodios.dart';
import 'package:streamingvideo/pages/listarfilmes.dart';
import 'package:streamingvideo/services/mensagens.dart';
import 'package:streamingvideo/services/services.dart';
import 'package:streamingvideo/utils/botaoanimado.dart';
import 'package:streamingvideo/utils/textboxcadastrar.dart';

class CadastrarEpisodio extends StatefulWidget {
  final Series serie;

  CadastrarEpisodio({Key key, this.serie}) : super(key: key);

  @override
  _CadastrarEpisodioState createState() => _CadastrarEpisodioState();
}

class _CadastrarEpisodioState extends State<CadastrarEpisodio>{
  String idEpisodio;
  String titulo = "";
  String sinopse = "";
  String temporada = "";
  String numero = "";
  String mensagem = " ";
  bool mensagemTag = false;

  _getTitulo(String text) => titulo = text;

  _getSinopse(String text) => sinopse = text;

  _getTemporada(String text) => temporada = text;

  _getNumero(String text) => numero = text;


  MaskTextInputFormatter maskData = new MaskTextInputFormatter(mask: "##-##-####");
  MaskTextInputFormatter maskAno = new MaskTextInputFormatter(mask: "####");

  bool isLoad = false;


  _onPressed () async {
    var result;
    if(titulo.isNotEmpty && sinopse.isNotEmpty && temporada.isNotEmpty && numero.isNotEmpty){
      try{
        setState(() {
          isLoad = true;
        });
        result = await Service.CadastrarEpisodio(titulo, sinopse, numero, temporada, widget.serie.IdSerie).then((value) async {
          List<Episodios> ep = await Service.listarEpisodios(widget.serie.IdSerie);
          if(value == true) Navigator.push(context, MaterialPageRoute(builder: (context) => ListarEpisodios(episodios: ep,)));
          else {
            setState(() {
              isLoad = false;
              mensagem = Mensagens.errorCadastroFilmes;
              mensagemTag = true;
            });
          }
        });
      } catch (Exception) {
        setState(() {
          isLoad = false;
          mensagem = result.status == 500 ?  Mensagens.errorServidor : '';
          mensagemTag = true;
        });
        print(Exception.toString());
      }
    } else {
      setState(() {
        isLoad = false;
        mensagem = Mensagens.errorCadastroFilmes;
        mensagemTag = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Cadastrar Episodio", style: TextStyle(color: Colors.deepOrange),), backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          children: [
            TextBoxCadastrar(campo: "Título:", getText: _getTitulo, mask: null),
            TextBoxCadastrar(campo: "Sinopse:", getText: _getSinopse, mask: null),
            TextBoxCadastrar(campo: "Temporada:", getText: _getTemporada, mask: null, hintText: "Ex: 3", type: TextInputType.number,),
            TextBoxCadastrar(campo: "Numero", getText: _getNumero, mask: null, hintText: "Ex: 2", type: TextInputType.number,),

            Center(child: Visibility(visible: mensagemTag, child: Text(mensagem, style: TextStyle(color: Colors.white),))),
            SizedBox(height: 10,),
            BotaoAnimado(
              tempo: 1,
              textoBotao: "ENVIAR",
              isLoad: isLoad,
              onPressed: _onPressed,
            )
          ],
        ),
      ),
    );
  }
}
