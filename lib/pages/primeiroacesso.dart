import 'package:flutter/material.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:streamingvideo/pages/login.dart';
import 'package:streamingvideo/services/mensagens.dart';
import 'package:streamingvideo/services/services.dart';
import 'package:streamingvideo/utils/botaoanimado.dart';
import 'home.dart';

class PrimeiroAcesso extends StatefulWidget {
  @override
  _PrimeiroAcessoState createState() => _PrimeiroAcessoState();
}

class _PrimeiroAcessoState extends State<PrimeiroAcesso> {

  String usuario = '';
  String senha = '';
  String nome = '';
  bool emailT = false;
  bool _showKey = false;
  String tag = '';
  bool isLoad = false;
  String mensagem = '';
  bool mensagemTag = false;

  _onPressed () async {
    var result;
    if(usuario.isNotEmpty && senha.isNotEmpty && nome.isNotEmpty){
      try{
        setState(() {
          isLoad = true;
        });
        result = await Service.cadastrarUsuario(usuario, nome, senha).whenComplete(() {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
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
        mensagem = Mensagens.errorCredenciais;
        mensagemTag = true;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 200,
            title: Center(child: Text("Primeiro Acesso", style: TextStyle(color: Colors.deepOrange),)), backgroundColor: Colors.black,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(visible: mensagemTag, child: Text(mensagem, style: TextStyle(color: Colors.white),)),
                  Container(
                    height: 70.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: TextField(
                      onChanged: (text) {
                        usuario = text;
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
                  SizedBox(height: 10),
                  Container(
                    height: 70.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: TextField(
                      onChanged: (text) {
                        nome = text;
                      },
                      style: TextStyle(fontSize: 20.0),
                      //keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10.0, top: 10.0),
                        labelStyle: TextStyle(fontSize: 15.0),
                        labelText: '    Nome:',
                        border: UnderlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 70.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: TextField(
                      style: TextStyle(fontSize: 20.0),
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        senha = text;
                      },
                      obscureText: !this._showKey,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10.0, top: 10.0),
                        labelStyle: TextStyle(fontSize: 15.0),
                        border: UnderlineInputBorder(borderSide: BorderSide.none),
                        labelText: '    Senha:',
                        suffixIcon: IconButton(
                          padding: EdgeInsets.only(top: 20.0),
                          icon: Icon(Icons.remove_red_eye,
                            color: this._showKey ? Colors.green[700] : Colors.grey,
                          ),
                          onPressed: () { setState(() => this._showKey =! this._showKey);
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  BotaoAnimado(
                    tempo: 1,
                    onPressed: _onPressed,
                    isLoad: isLoad,
                    textoBotao: "CONCLUIR",
                  ),
                  SizedBox(height: 20,),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(color: Colors.deepOrange, borderRadius: BorderRadius.circular(30)),
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 50,
                      child: InkWell(
                        child: Center(
                          child: Text(
                            "VOLTAR", style: TextStyle(
                            fontSize: 18, color: Colors.white,
                            fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}



