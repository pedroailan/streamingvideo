
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:streamingvideo/models/filmes.dart';
import 'package:streamingvideo/pages/editarFilme.dart';
import 'package:streamingvideo/pages/home.dart';
import 'package:streamingvideo/services/services.dart';

import 'login.dart';

class ListarFilmes extends StatefulWidget {

  final List<Filmes> filmes;

  ListarFilmes({Key key, this.filmes}) : super(key: key);

  @override
  _ListarFilmesState createState() => _ListarFilmesState();
}

class _ListarFilmesState extends State<ListarFilmes> with SingleTickerProviderStateMixin {
  String generos;

  bool isLoad = false;
  _onRefresh() async {
    setState(() async {
      isLoad = false;
      List<Filmes> filmes = await Service.listarFilmes();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ListarFilmes(filmes: filmes)));
    });
  }



  _showAlertDialog(BuildContext context, String id) async {
    AlertDialog dialog;
    Widget cancelaButton = FlatButton(
      child: Text("Cancelar"),
      onPressed: () async
      {
      List<Filmes> filmes = await Service.listarFilmes();
      Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ListarFilmes(filmes: filmes,)));
      }
    );
    Widget excluirButton = FlatButton(
      child: Text("Excluir"),
      onPressed:  () async {
        await Service.deletarFilme(id);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
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
          title: Text("Filmes e Séries", style: TextStyle(color: Colors.deepOrange),), backgroundColor: Colors.black,
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
                child: (widget.filmes == null || widget.filmes.isEmpty) ?
                Center(child: Text("Sem resultados", style: TextStyle(color: Colors.white),),) :
                ListView.builder(
                  itemCount: widget.filmes.length,
                  itemExtent: min(200, 270),
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
                                  Text("Titulo : ${widget.filmes[index].Titulo}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
                                  Text("Sinopse : ${widget.filmes[index].Sinopse}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),),
                                  Text("Data de Lancamento : ${widget.filmes[index].DataLancamento}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),),
                                  Text("Ano : ${widget.filmes[index].Ano}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),),
                                  Text("Genero : ${widget.filmes[index].Generos.map((e) => e.Gen).join(",")}",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(icon: Icon(Icons.edit_outlined), onPressed: () {Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => EditarFilme(filme: widget.filmes[index])));}),
                                      AnimatedContainer(
                                        duration: Duration(seconds: 2),
                                        child: isLoad ? SizedBox(width: 20, height: 20,
                                          child: CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                            strokeWidth: 2.0,
                                          ),
                                        )
                                            :
                                        IconButton(icon: Icon(Icons.restore_from_trash),
                                            onPressed: () async {
                                            _showAlertDialog(context, widget.filmes[index].idFilme);
                                        }),
                                      ),
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