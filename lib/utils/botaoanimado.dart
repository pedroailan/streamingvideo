import 'package:flutter/material.dart';

class BotaoAnimado extends StatelessWidget {
  final Function onPressed;
  final bool isLoad;
  final int tempo;
  final String textoBotao;

  BotaoAnimado({Key key,  this.onPressed, this.isLoad, this.tempo, this.textoBotao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Container(
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.deepOrange,
            borderRadius: BorderRadius.all(Radius.circular(30.0))
        ),
        child: AnimatedContainer(
            duration: Duration(seconds: tempo),
            child: isLoad ?
            SizedBox(width: 40, height: 40,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 2.0,
              ),
            )
                :
            FlatButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              minWidth: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Text(textoBotao, style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3),),
              onPressed: onPressed,
            )
        ),
      ),
    );
  }
}