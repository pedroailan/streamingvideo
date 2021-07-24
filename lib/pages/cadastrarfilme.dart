import 'package:flutter/material.dart';

class CadastrarFilme extends StatefulWidget {
  @override
  _CadastrarFilmeState createState() => _CadastrarFilmeState();
}

class _CadastrarFilmeState extends State<CadastrarFilme> {

  String titulo;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold( 
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: Text("Streaming Video", style: TextStyle(color: Colors.deepOrange),), backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Container(
                height: 70.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: TextField(
                  onChanged: (text) {
                    titulo = text;
                  },
                  style: TextStyle(fontSize: 20.0),
                  //keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10.0, top: 10.0),
                    labelStyle: TextStyle(fontSize: 15.0),
                    labelText: '    Usuário:',
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
