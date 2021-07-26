
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:streamingvideo/models/filmes.dart';
import 'package:streamingvideo/pages/home.dart';
import 'package:streamingvideo/pages/listarfilmes.dart';
import 'package:streamingvideo/services/mensagens.dart';
import 'package:streamingvideo/services/services.dart';
import 'package:streamingvideo/utils/botaoanimado.dart';
import 'package:streamingvideo/utils/textboxcadastrar.dart';

class EditarFilme extends StatefulWidget {
  final Filmes filme;

  EditarFilme({Key key, this.filme}) : super(key: key);

  @override
  _EditarFilmeState createState() => _EditarFilmeState();
}

class _EditarFilmeState extends State<EditarFilme>{
  String idFilme;
  String titulo = "";
  String sinopse = "";
  String ano = "";
  String datalancamento = "";
  String genero = "";
  String mensagem = " ";
  bool mensagemTag = false;

  _getId() {
    idFilme =  widget.filme.idFilme.toString();
  }
  _getTitulo(String text) => titulo = text;

  _getSinopse(String text) => sinopse = text;

  _getAno(String text) => ano = text;

  _getDataLancamento(String text) => datalancamento = text;

  _getGenero(String text) => genero = text;

  MaskTextInputFormatter maskData = new MaskTextInputFormatter(mask: "##-##-####");
  MaskTextInputFormatter maskAno = new MaskTextInputFormatter(mask: "####");

  bool isLoad = false;


  _onPressed () async {
    var result;
    if(idFilme == null || idFilme.isEmpty) idFilme = widget.filme.idFilme;
    Filmes atual = await Service.listarFilmePorId(int.parse(widget.filme.idFilme));
    print(widget.filme.idFilme);
    if(titulo ==  null  || titulo.isEmpty) titulo = atual.Titulo;
    if(sinopse == null || sinopse.isEmpty) sinopse = atual.Sinopse;
    if(ano == null || ano.isEmpty) ano = atual.Ano;
    if(datalancamento == null || datalancamento.isEmpty) datalancamento = atual.DataLancamento;
    if(genero == null || genero.isEmpty) genero = atual.Generos.map((e) => e.Gen).join(",");

    print(idFilme);
    if(titulo.isNotEmpty && sinopse.isNotEmpty && ano.isNotEmpty && datalancamento.isNotEmpty){
      try{
        setState(() {
          isLoad = true;
        });
        result = await Service.atualizarFilme(idFilme, titulo, sinopse, ano, datalancamento, genero).then((value) {
          print(value);
          if(value == true) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
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
          title: Text("Filmes e Séries", style: TextStyle(color: Colors.deepOrange),), backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          children: [
            TextBoxCadastrar(campo: "Título:", getText: _getTitulo, mask: null, value: widget.filme.Titulo,),
            TextBoxCadastrar(campo: "Sinopse:", getText: _getSinopse, mask: null, value: widget.filme.Sinopse),
            TextBoxCadastrar(campo: "Ano:", getText: _getAno, mask: maskAno, value: widget.filme.Ano,),
            TextBoxCadastrar(campo: "Data de Lançamento:", getText: _getDataLancamento, mask: maskData, value: widget.filme.DataLancamento,),
            TextBoxCadastrar(campo: "Gênero:", getText: _getGenero, mask: null, value: widget.filme.Generos.map((e) => e.Gen).join(",").toString(),),
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
