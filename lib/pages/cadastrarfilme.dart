import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:streamingvideo/pages/home.dart';
import 'package:streamingvideo/services/mensagens.dart';
import 'package:streamingvideo/services/services.dart';
import 'package:streamingvideo/utils/botaoanimado.dart';

class CadastrarFilme extends StatefulWidget {
  @override
  _CadastrarFilmeState createState() => _CadastrarFilmeState();
}

class _CadastrarFilmeState extends State<CadastrarFilme> {

  String titulo;
  String sinopse;
  String ano;
  String datalancamento;
  String genero;
  String mensagem = " ";
  bool mensagemTag = false;

  _getTitulo(String text) => titulo = text;

  _getSinopse(String text) => sinopse = text;

  _getAno(String text) => ano = text;

  _getDataLancamento(String text) => datalancamento = text;

  _getGenero(String text) => genero = text;

  MaskTextInputFormatter maskData = new MaskTextInputFormatter(mask: "##/##/####");
  MaskTextInputFormatter maskAno = new MaskTextInputFormatter(mask: "####");

  bool isLoad = false;

  _onPressed () async {
    var result;
    if(titulo.isNotEmpty && sinopse.isNotEmpty && ano.isNotEmpty && datalancamento.isNotEmpty && genero.isNotEmpty){
      try{
        setState(() {
          isLoad = true;
        });
        result = await Service.cadastrarFilme(titulo, sinopse, ano, datalancamento, genero).whenComplete(() {
          if(result == true) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
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
        Exception.toString();
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
    return SafeArea(
      child: Scaffold( 
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: Text("Streaming Video", style: TextStyle(color: Colors.deepOrange),), backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: ListView(
            children: [
              TextBoxCadastrar(campo: "Título:", getText: _getTitulo, mask: null,),
              TextBoxCadastrar(campo: "Sinopse:", getText: _getSinopse, mask: null,),
              TextBoxCadastrar(campo: "Ano:", getText: _getAno, mask: maskAno),
              TextBoxCadastrar(campo: "Data de Lançamento:", getText: _getDataLancamento, mask: maskData,),
              TextBoxCadastrar(campo: "Gênero:", getText: _getGenero, mask: null,),
              Center(child: Visibility(visible: mensagemTag, child: Text(mensagem, style: TextStyle(color: Colors.white),))),
              SizedBox(height: 10,),
              BotaoAnimado(
                tempo: 2,
                textoBotao: "ENVIAR",
                isLoad: isLoad,
                onPressed: _onPressed,
              )
            ],
          ),
        ),
      ),
    );
  }
}


class TextBoxCadastrar extends StatelessWidget {
  final String campo;
  final Function getText;
  final TextInputFormatter mask;

  TextBoxCadastrar({Key key, this.campo, this.getText, this.mask}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(campo, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), ),
          Container(
            height: 70.0,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: TextFormField(
              inputFormatters: [ mask != null ? mask : MaskTextInputFormatter(mask: "")],
              onChanged: (text) {
                getText(text);
              },
              style: TextStyle(fontSize: 20.0),
              //keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0, top: 10.0),
                labelStyle: TextStyle(fontSize: 15.0),
                border: UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
