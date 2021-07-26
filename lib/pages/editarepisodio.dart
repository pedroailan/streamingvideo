import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:streamingvideo/models/episodios.dart';
import 'package:streamingvideo/models/filmes.dart';
import 'package:streamingvideo/pages/home.dart';
import 'package:streamingvideo/pages/listarepisodios.dart';
import 'package:streamingvideo/pages/listarfilmes.dart';
import 'package:streamingvideo/services/mensagens.dart';
import 'package:streamingvideo/services/services.dart';
import 'package:streamingvideo/utils/botaoanimado.dart';
import 'package:streamingvideo/utils/textboxcadastrar.dart';

class EditarEpisodio extends StatefulWidget {
  final Episodios episodio;

  EditarEpisodio({Key key, this.episodio}) : super(key: key);

  @override
  _EditarEpisodioState createState() => _EditarEpisodioState();
}

class _EditarEpisodioState extends State<EditarEpisodio>{
  String idEpisodio;
  String titulo = "";
  String sinopse = "";
  String temporada = "";
  String numero = "";
  String mensagem = " ";
  bool mensagemTag = false;

  _getId() {
    idEpisodio =  widget.episodio.idEpisodio.toString();
  }
  _getTitulo(String text) => titulo = text;

  _getSinopse(String text) => sinopse = text;

  _getTemporada(String text) => temporada = text;

  _getNumero(String text) => numero = text;


  MaskTextInputFormatter maskData = new MaskTextInputFormatter(mask: "##-##-####");
  MaskTextInputFormatter maskAno = new MaskTextInputFormatter(mask: "####");

  bool isLoad = false;


  _onPressed () async {
    var result;
    if(idEpisodio == null || idEpisodio.isEmpty) idEpisodio = widget.episodio.idEpisodio;
    Episodios atual = await Service.listarEpisodioPorId(int.parse(widget.episodio.idEpisodio));
    if(titulo ==  null  || titulo.isEmpty) titulo = atual.Titulo;
    if(sinopse == null || sinopse.isEmpty) sinopse = atual.Sinopse;
    if(temporada == null || temporada.isEmpty) temporada = atual.Temporada;
    if(numero == null || numero.isEmpty) numero = atual.Numero;

    if(titulo.isNotEmpty && sinopse.isNotEmpty && temporada.isNotEmpty && numero.isNotEmpty){
      try{
        setState(() {
          isLoad = true;
        });
        result = await Service.atualizarEpisodio(idEpisodio, titulo, sinopse, numero, temporada, widget.episodio.idSerie).then((value) async {
          List<Episodios> eps = await Service.listarEpisodios(widget.episodio.idSerie);
          if(value == true) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ListarEpisodios(episodios: eps,)));
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
        title: Text("Editar Episódio", style: TextStyle(color: Colors.deepOrange),), backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          children: [
            TextBoxCadastrar(campo: "Título:", getText: _getTitulo, mask: null, value: widget.episodio.Titulo,),
            TextBoxCadastrar(campo: "Sinopse:", getText: _getSinopse, mask: null, value: widget.episodio.Sinopse),
            TextBoxCadastrar(campo: "Temporada:", getText: _getTemporada, mask: null, value: widget.episodio.Temporada, hintText: "Ex: 2", type: TextInputType.number,),
            TextBoxCadastrar(campo: "Numero", getText: _getNumero, mask: null, value: widget.episodio.Numero, hintText: "Ex: 3", type: TextInputType.number,),

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
