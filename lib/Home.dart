import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerMensagem = TextEditingController();

  var _texto = "";

  void _salvar() async {
    String _valorDigitado = _controllerMensagem.text;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("digitado", _valorDigitado);
  }

  void _recuperar() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      _texto = preferences.getString("digitado") ?? "Nenhuma mensagem salva";
    });
  }

  void _remover() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey("digitado")) {
      preferences.remove("digitado");
    }
  }

  @override
  Widget build(BuildContext context) {
    _recuperar();

    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Preferences"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              _texto,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: TextField(
              decoration:
                  InputDecoration(labelText: "Digite a sua mensagem, aqui"),
              style: TextStyle(fontSize: 20),
              controller: _controllerMensagem,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: _salvar,
                child: Text("Salvar"),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.blue,
                  textStyle: TextStyle(fontSize: 18),
                  elevation: 5,
                ),
              ),
              TextButton(
                onPressed: _remover,
                child: Text("Remover"),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.blue,
                  textStyle: TextStyle(fontSize: 18),
                  elevation: 5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
