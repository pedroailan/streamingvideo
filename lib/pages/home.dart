import 'package:flutter/material.dart';
import 'package:streamingvideo/pages/cadastrarfilme.dart';
import 'package:streamingvideo/pages/listarfilmes.dart';
import 'package:streamingvideo/pages/login.dart';
import 'package:streamingvideo/services/services.dart';
import 'package:streamingvideo/utils/botaoanimado.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoad = false;

  _onPressed () async {
    var result;
      try{
        setState(() {
          isLoad = true;
        });
        result = await Service.autenticar("x", "y").whenComplete(() {
          //print(result.descricao);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ListarFilmes(filmes: result,)));
        });
      } catch (Exception) {
        setState(() {
          isLoad = false;
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
                  borderOnForeground: true,
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
                          Icon(Icons.list),
                          Text(" Listar Filmes", style: TextStyle(color: Colors.deepOrange),),
                        ],
                      )
                  ),
                ),
                onTap: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ListarFilmes(filmes: new Filmes(descricao: "Logado", id: 1, duracao: "1", status: 200),)));
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


