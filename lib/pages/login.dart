
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:streamingvideo/pages/primeiroacesso.dart';
import 'package:streamingvideo/services/mensagens.dart';
import 'package:streamingvideo/services/services.dart';
import 'package:streamingvideo/utils/botaoanimado.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String usuario = '';
  String senha = '';
  bool emailT = false;
  bool _showKey = false;
  String tag = '';
  bool isLoad = false;
  String mensagem = '';
  bool mensagemTag = false;
  // _onPressed() async {
  //   try {
  //     setState(() {
  //       isLoad = true;
  //     });
  //     final response =
  //     await http.post(
  //       'https://streamingvideoapi.herokuapp.com/usuario/autenticar',
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body:
  //       jsonEncode(<String, String>{
  //         'email' : usuario,
  //         'senha' : senha,
  //       }),
  //     );
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
  //       var jsonResponse = json.decode(response.body);
  //       print(jsonResponse);
  //       setState(() {
  //         tag = jsonResponse;
  //         isLoad = false;
  //       });
  //     } else {
  //       // If that response was not OK, throw an error.
  //       setState(() {
  //         isLoad = false;
  //       });
  //       throw Exception('Failed to load post');
  //     }
  //   } catch (e) {
  //     print (e);
  //     setState(() {
  //       isLoad = false;
  //       tag = tag;
  //     });
  //     return e.toString();
  //   }
  //
  // }
  _onPressed () async {
    var result;
    if(usuario.isNotEmpty && senha.isNotEmpty){
      try{
        setState(() {
          isLoad = true;
        });
        result = await Service.autenticar(usuario, senha).whenComplete(() {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
        });
      } catch (Exception) {
        setState(() {
          isLoad = false;
          mensagem = result.status == 500 ?  Mensagens.errorServidor : '';
          mensagemTag = true;
        });
        Exception.toString();
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
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
                  Colors.black,
                  Colors.blueGrey,
                  Colors.deepOrange,
                  Colors.black,
                ],
              )
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo-bd.png'),
                  // Text(
                  //   'LOGIN',
                  //   style: TextStyle(
                  //     color: Colors.blue[50],
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 20.0,
                  //   ),
                  // ),
                  Visibility(visible: mensagemTag, child: Text(mensagem, style: TextStyle(color: Colors.white),)),
                  SizedBox(height: 20),
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
                        suffixIcon: Container(
                          child: IconButton(
                            padding: EdgeInsets.only(top: 10.0),
                            icon: Icon(Icons.done,
                              color: this.emailT ? Colors.green[700] : Colors.grey,
                            ),
                            onPressed: () {},
                          ),
                        ),
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
                    textoBotao: "ENTRAR",
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 50,
                    child: InkWell(
                      child: Center(
                        child: Text(
                          "Primeiro Acesso", style: TextStyle(
                          fontSize: 18, color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PrimeiroAcesso()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}



