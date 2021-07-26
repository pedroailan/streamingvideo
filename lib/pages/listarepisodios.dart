import 'dart:math';
import 'package:flutter/material.dart';
import 'package:streamingvideo/models/episodios.dart';
import 'package:streamingvideo/models/series.dart';
import 'package:streamingvideo/pages/cadastrarepisodio.dart';
import 'package:streamingvideo/pages/editarepisodio.dart';
import 'package:streamingvideo/pages/editarserie.dart';
import 'package:streamingvideo/pages/home.dart';
import 'package:streamingvideo/services/services.dart';

import 'login.dart';

class ListarEpisodios extends StatefulWidget {

  final List<Episodios> episodios;
  final Series series;

  ListarEpisodios({Key key, this.episodios, this.series}) : super(key: key);

  @override
  _ListarEpisodiosState createState() => _ListarEpisodiosState();
}

class _ListarEpisodiosState extends State<ListarEpisodios> with SingleTickerProviderStateMixin {
  String generos;

  bool isLoad = false;
  _onRefresh() async {
      List<Episodios> episodios = await Service.listarEpisodios(widget.series.IdSerie);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ListarEpisodios(episodios: episodios)));
  }



  _showAlertDialog(BuildContext context, String id) async {
    AlertDialog dialog;
    Widget cancelaButton = FlatButton(
        child: Text("Cancelar"),
        onPressed: () async
        {
          Navigator.of(context).pop();
        }
    );
    Widget excluirButton = FlatButton(
      child: Text("Excluir"),
      onPressed:  () async {
        await Service.deletarEpisodio(id);
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
            title: Text("Episódios", style: TextStyle(color: Colors.deepOrange),), backgroundColor: Colors.black,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: IconButton(icon: Icon(Icons.add_circle_outline, color: Colors.white, size: 30,), onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CadastrarEpisodio(serie: widget.series)));
                }),
              ),
            ],
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
                  child: (widget.episodios == null || widget.episodios.isEmpty) ?
                  Center(child: Text("Sem resultados", style: TextStyle(color: Colors.white),),) :
                  ListView.builder(
                    itemCount: widget.episodios.length,
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
                                      Text("Titulo : ${widget.episodios[index].Titulo}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
                                      Text("Sinopse : ${widget.episodios[index].Sinopse}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),),
                                      Text("Temporada : ${widget.episodios[index].Temporada}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),),
                                      Text("Numero: ${widget.episodios[index].Numero}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          IconButton(icon: Icon(Icons.edit_outlined), onPressed: () {Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => EditarEpisodio(episodio: widget.episodios[index])));}),
                                          IconButton(icon: Icon(Icons.restore_from_trash),
                                              onPressed: () async {
                                                _showAlertDialog(context, widget.episodios[index].idEpisodio);
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