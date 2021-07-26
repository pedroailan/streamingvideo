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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: Text("Streaming Video", style: TextStyle(color: Colors.deepOrange),), backgroundColor: Colors.black,
            actions: [
              IconButton(icon: Icon(Icons.logout), onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login())),),
            ]
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                child: Card(
                  elevation: 10,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.white, width: 0.5),
                  ),
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.movie_creation_outlined),
                            Text(" Cadastrar Filme", style: TextStyle(color: Colors.deepOrange),),
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
                  elevation: 10,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.white, width: 0.5),
                  ),
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.movie),
                          Text(" Cadastrar Série", style: TextStyle(color: Colors.deepOrange),),
                        ],
                      )
                  ),
                ),
                onTap: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CadastrarSerie()));
                },
              ),
              BotaoAnimadoMenu(
                onPressed: _onPressed,
                tempo: 2,
                textoBotao: " Listar Filme",
                isLoad: isLoad,
              ),
              BotaoAnimadoMenu(
                onPressed: _onPressed2,
                tempo: 2,
                textoBotao: " Listar Série",
                isLoad: isLoadSerie,
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

  BotaoAnimadoMenu({Key key,  this.onPressed, this.isLoad, this.tempo, this.textoBotao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 0, right: 0),
      child: Card(
        elevation: 1,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.white, width: 0.5),
        ),
        child: AnimatedContainer(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.1,
            duration: Duration(seconds: tempo),
            child: isLoad ?
            Padding(
              padding: EdgeInsets.only(left: 65, right: 65, top: 10, bottom: 10),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                strokeWidth: 2.0,
              ),
            )
                :
            FlatButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              minWidth: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.movie_creation_outlined),
                  Text(textoBotao, style: TextStyle(color: Colors.deepOrange),),
                ],
              ),
              onPressed: onPressed,
            )
        ),
      ),
    );
  }
}