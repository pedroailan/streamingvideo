import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TextBoxCadastrar extends StatelessWidget {
  final String campo;
  final Function getText;
  final TextInputFormatter mask;
  final dynamic value;

  TextBoxCadastrar({Key key, this.campo, this.getText, this.mask, this.value}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(campo, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), ),
          Container(
            height: 70.0,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: TextFormField(
              initialValue: value,
              inputFormatters: [ mask != null ? mask : MaskTextInputFormatter(mask: "")],
              onChanged: (text) {
                getText(text);
              },
              style: TextStyle(fontSize: 20.0),
              //keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0, top: 10.0),
                labelStyle: TextStyle(fontSize: 15.0),
                border: UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
        ],
      ),
    );
  }
}