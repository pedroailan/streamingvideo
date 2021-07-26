import 'dart:math';
import 'package:flutter/material.dart';
import 'package:streamingvideo/models/episodios.dart';
import 'package:streamingvideo/models/filmes.dart';
import 'package:streamingvideo/models/series.dart';
import 'package:streamingvideo/pages/editarFilme.dart';
import 'package:streamingvideo/pages/editarserie.dart';
import 'package:streamingvideo/pages/home.dart';
import 'package:streamingvideo/pages/listarepisodios.dart';
import 'package:streamingvideo/services/services.dart';

import 'login.dart';

class ListarSeries extends StatefulWidget {

  final List<Series> series;

  ListarSeries({Key key, this.series}) : super(key: key);

  @override
  _ListarSeriesState createState() => _ListarSeriesState();
}

class _ListarSeriesState extends State<ListarSeries> with SingleTickerProviderStateMixin {
  String generos;

  bool isLoad = false;
  _onRefresh() async {
    List<Series> series = await Service.listarSeries();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ListarSeries(series: series,)));
  }


  bool isLoadAlert = false;
  _showAlertDialog(BuildContext context, String id) async {
    BuildContext dialog = context;
    Widget cancelaButton  =  FlatButton(
        child: (isLoadAlert == true) ? CircularProgressIndicator(backgroundColor: Colors.deepOrange,) : Text("Cancelar"),
        onPressed: ()  {
          Navigator.of(context).pop();
        }
    );
    Widget excluirButton = FlatButton(
      child: Text("Excluir"),
      onPressed:  () async {
        await Service.deletarSerie(id);
        Navigator.of(context).pop(MaterialPageRoute(builder: (context) => Home()));
      },
    );
    // configura o  AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Aviso"),
      content: Text("Deseja excluir este item?"),
      actions: [
        cancelaButton,
        excluirButton,
      ],
    );
    // exibe o dialogo
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text("Séries", style: TextStyle(color: Colors.deepOrange),), backgroundColor: Colors.black,
          ),
          /*drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // DrawerHeader(
              //   decoration: BoxDecoration(),
              //       child: IconButton(icon: Icon(Icons.account_circle_outlined), iconSize: 50,),
              //     ),
              Expanded(
                child: ListView.builder(
                  itemCount: dataList.length,
                  itemExtent: 80,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){},
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(color: Colors.deepOrange),
                          child: Center(
                              child: ListTile(
                                title: Text(dataList[index]),
                                leading: IconButton(icon: Icon(Icons.arrow_forward_ios_sharp), onPressed: (){},),
                              )
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),*/
          body: RefreshIndicator(
            onRefresh: () => _onRefresh(),
            child: Column(
              children: [
                Expanded(
                  child: (widget.series == null || widget.series.isEmpty) ?
                  Center(child: Text("Sem resultados", style: TextStyle(color: Colors.white),),) :
                  ListView.builder(
                    itemCount: widget.series.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 3,
                          color: Colors.black12,
                          child: Container(
                            decoration: BoxDecoration(color: Colors.deepOrange, borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                      Text("Titulo : ${widget.series[index].Titulo}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
                                      Text("Sinopse : ${widget.series[index].Sinopse}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),),
                                      Text("Ano : ${widget.series[index].Ano}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),),
                                      Text("Numero de Temporadas : ${widget.series[index].NumeroTemporada}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),),
                                      Text("Ano : ${widget.series[index].AnoFim}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),),
                                      Text("Genero : ${widget.series[index].Generos.map((e) => e.Gen).join(",")}",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          IconButton(icon: Icon(Icons.list), onPressed: () async {
                                            List<Episodios> episodios = await Service.listarEpisodios(widget.series[index].IdSerie);
                                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ListarEpisodios(series: widget.series[index], episodios: episodios,)));
                                          }),
                                          IconButton(icon: Icon(Icons.edit_outlined), onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditarSerie(series: widget.series[index])));}),
                                          IconButton(icon: Icon(Icons.restore_from_trash),
                                              onPressed: () async {
                                                _showAlertDialog(context, widget.series[index].IdSerie);
                                              }),
                                        ],
                                      )
                                    ]
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}

class Alert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


List<String> dataList = [
  "Filmes",
  "Series",
  "Documentários",
  "Livros"
];