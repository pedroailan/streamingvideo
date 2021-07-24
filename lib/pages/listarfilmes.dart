import 'package:flutter/material.dart';

import 'login.dart';

class ListarFilmes extends StatefulWidget {

  final dynamic filmes;

  ListarFilmes({Key key, this.filmes}) : super(key: key);

  @override
  _ListarFilmesState createState() => _ListarFilmesState();
}

class _ListarFilmesState extends State<ListarFilmes> {
  List<dynamic> movies;

  _onRefresh() {
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Filmes e Séries", style: TextStyle(color: Colors.deepOrange),), backgroundColor: Colors.black,
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login())),),
        ]
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
      body: ListView.builder(
        itemCount: 10,
        itemExtent: 150,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){},
            child: Card(
              color: Colors.black12,
              child: Container(
                decoration: BoxDecoration(color: Colors.deepOrange, borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("ID: " + widget.filmes.id.toString()),
                        Text("DESCRIÇÃO: " + widget.filmes.descricao),
                        Text("DURAÇÃO: " + widget.filmes.duracao),
                  ],
                )),
              ),
            ),
          );
        },
      )
    );
  }
}

class Filmes {
  int id = 0;
  String descricao = "";
  String duracao = "";
  int status = 0;

  Filmes({
    this.id,
    this.descricao,
    this.duracao,
    this.status
  });
}

List<String> dataList = [
  "Filmes",
  "Series",
  "Documentários",
  "Livros"
];