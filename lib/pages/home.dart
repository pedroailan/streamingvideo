import 'package:flutter/material.dart';
import 'package:streamingvideo/models/filmes.dart';
import 'package:streamingvideo/pages/cadastrarfilme.dart';
import 'package:streamingvideo/pages/cadastrarserie.dart';
import 'package:streamingvideo/pages/listarfilmes.dart';
import 'package:streamingvideo/pages/listarseries.dart';
import 'package:streamingvideo/pages/login.dart';
import 'package:streamingvideo/services/services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoad = false;
  bool isLoadSerie = false;

  _onPressed() async {
    List<Filmes> result;
      try{
        setState(() {
          isLoad = true;
        });
        result = await Service.listarFilmes().then((value) async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => ListarFilmes(filmes: value,)));
          setState(() {
            isLoad = false;
          });
        });
      } catch (Exception) {
        setState(() {
          isLoad = false;
        });
        Exception.toString();
      }
    }

  _onPressed2() async {
    List<Filmes> result;
    try{
      setState(() {
        isLoadSerie = true;
      });
      result = await Service.listarSeries().then((value) async {
        await Navigator.push(context, MaterialPageRoute(builder: (context) => ListarSeries(series: value,)));
        setState(() {
          isLoadSerie = false;
        });
      });
    } catch (Exception) {
      setState(() {
        isLoadSerie = false;
      });
      Exception.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        elevation: 5,
        flexibleSpace: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [
                    0.1,
                    0.4,
                    0.6,
                    0.9,
                  ],
                  colors: [
                    Colors.deepOrange,
                    Colors.deepOrangeAccent,
                    Colors.grey,
                    Colors.black12,
                  ],
                )
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 40, top: 20, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("   Streaming\n   Video", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  IconButton(icon: Icon(Icons.logout, color: Colors.white,), onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login())),),
                ],
              ),
            )
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          side: BorderSide(color: Colors.transparent)
        ),
        toolbarHeight: 150,
        backgroundColor: Colors.black,
        foregroundColor: Colors.black,
        shadowColor: Colors.black,
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [
                  0.1,
                  0.4,
                  0.6,
                  0.9,
                ],
                colors: [
                  Colors.deepOrange,
                  Colors.deepOrange,
                  Colors.deepOrangeAccent,
                  Colors.black12,
                ],
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Card(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        //side: BorderSide(color: Colors.transparent, width: 0.5),
                      ),
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.movie_creation_outlined, color: Colors.white,),
                              Text(" Cadastrar Filme", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            ],
                          )
                      ),
                    ),
                    onTap: () async {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CadastrarFilme()));
                    },
                  ),
                  InkWell(
                    child: Card(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        //side: BorderSide(color: Colors.white, width: 0.5),
                      ),
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.movie, color: Colors.white,),
                              Text(" Cadastrar Série", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            ],
                          )
                      ),
                    ),
                    onTap: () async {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CadastrarSerie()));
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BotaoAnimadoMenu(
                    onPressed: _onPressed,
                    tempo: 2,
                    textoBotao: " Listar Filme",
                    isLoad: isLoad,
                    icone: Icons.list_alt,
                  ),
                  BotaoAnimadoMenu(
                    onPressed: _onPressed2,
                    tempo: 2,
                    textoBotao: " Listar Série",
                    isLoad: isLoadSerie,
                    icone: Icons.format_list_bulleted,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BotaoAnimadoMenu extends StatelessWidget {
  final Function onPressed;
  final bool isLoad;
  final int tempo;
  final String textoBotao;
  final IconData icone;

  BotaoAnimadoMenu({Key key,  this.onPressed, this.isLoad, this.tempo, this.textoBotao, this.icone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        //side: BorderSide(color: Colors.white, width: 0.5),
      ),
      child: AnimatedContainer(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.2,
          duration: Duration(seconds: tempo),
          child: isLoad ?
          Transform.scale(
            scale: 0.4,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
              strokeWidth: 3.0,
            ),
          )
              :
          FlatButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            minWidth: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icone, color: Colors.white,),
                Text(textoBotao, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              ],
            ),
            onPressed: onPressed,
          )
      ),
    );
  }
}