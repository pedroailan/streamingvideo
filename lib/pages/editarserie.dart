
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:streamingvideo/models/filmes.dart';
import 'package:streamingvideo/models/series.dart';
import 'package:streamingvideo/pages/home.dart';
import 'package:streamingvideo/pages/listarfilmes.dart';
import 'package:streamingvideo/pages/listarseries.dart';
import 'package:streamingvideo/services/mensagens.dart';
import 'package:streamingvideo/services/services.dart';
import 'package:streamingvideo/utils/botaoanimado.dart';
import 'package:streamingvideo/utils/textboxcadastrar.dart';

class EditarSerie extends StatefulWidget {
  final Series series;

  EditarSerie({Key key, this.series}) : super(key: key);

  @override
  _EditarSerieState createState() => _EditarSerieState();
}

class _EditarSerieState extends State<EditarSerie>{
  String idSerie;
  String titulo;
  String sinopse;
  String ano;
  String numeroTemporada;
  String anoFim;
  String genero;
  List<dynamic> listaEpisodio;
  String mensagem = " ";
  bool mensagemTag = false;

  _getTitulo(String text) => titulo = text;

  _getSinopse(String text) => sinopse = text;

  _getAno(String text) => ano = text;

  _getNumeroTemporada(String text) => numeroTemporada = text;

  _getAnoFim(String text) => anoFim = text;

  _getGenero(String text) => genero = text;

  MaskTextInputFormatter maskData = new MaskTextInputFormatter(mask: "##-##-####");
  MaskTextInputFormatter maskAno = new MaskTextInputFormatter(mask: "####");

  bool isLoad = false;


  _onPressed () async {
    var result;
    setState(() {
      isLoad = true;
    });
    if(idSerie == null || idSerie.isEmpty) idSerie = widget.series.IdSerie;
    Series atual = await Service.listarSeriePorId(int.parse(widget.series.IdSerie));
    if(titulo ==  null  || titulo.isEmpty) titulo = atual.Titulo;
    if(sinopse == null || sinopse.isEmpty) sinopse = atual.Sinopse;
    if(ano == null || ano.isEmpty) ano = atual.Ano;
    if(numeroTemporada == null || numeroTemporada.isEmpty) numeroTemporada = atual.NumeroTemporada;
    if(anoFim == null || numeroTemporada.isEmpty) anoFim = atual.AnoFim;
    if(genero == null || genero.isEmpty) genero = atual.Generos.map((e) => e.Gen).join(",");
    List<Series> listaS = await Service.listarSeries();
    if(titulo.isNotEmpty && sinopse.isNotEmpty && ano.isNotEmpty && numeroTemporada.isNotEmpty){
      try{
        result = await Service.atualizarSerie(idSerie, titulo, sinopse, ano, numeroTemporada, anoFim, genero).then((value) {
          if(value == true) Navigator.pop(context, MaterialPageRoute(builder: (context) => ListarSeries(series: listaS)));
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
        title: Text("Editar Série", style: TextStyle(color: Colors.deepOrange),), backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          children: [
            TextBoxCadastrar(campo: "Título:", getText: _getTitulo, mask: null, value: widget.series.Titulo,),
            TextBoxCadastrar(campo: "Sinopse:", getText: _getSinopse, mask: null, value: widget.series.Sinopse),
            TextBoxCadastrar(campo: "Ano:", getText: _getAno, mask: maskAno, value: widget.series.Ano, hintText: "Ex: 2021", type: TextInputType.number,),
            TextBoxCadastrar(campo: "Numero de Temporada(s):", getText: _getNumeroTemporada, mask: maskData, value: widget.series.NumeroTemporada, type: TextInputType.number,),
            TextBoxCadastrar(campo: "Ano Fim:", getText: _getAnoFim, mask: maskData, value: widget.series.AnoFim, hintText: "Ex: 12-12-2022", type: TextInputType.number,),
            TextBoxCadastrar(campo: "Gênero:", getText: _getGenero, mask: null, value: widget.series.Generos.map((e) => e.Gen).join(",").toString(), hintText: "Ex: Terror, ação...",),
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
