import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
// import 'dart:convert';

const request = 'https://leandrotech.com.br/acarajedasocorro/check_preco';
const dados = {
  "_id": 91507135,
  "diaOperacao": "31/10/2020",
  "data": "2020-10-31 10:39:35",
  "pedidos": [
    {
      "qtProdutos": 1,
      "opcao": "Porção de acarajés",
      "descPedido": "Porção de acarajés 0 com pimenta",
      "valPedido": 25
    }
  ],
  "precoTotal": 25,
  "pago": false,
  "clientName": "Mesa da gente 01",
  "obs": "",
  "status": "Pendente",
  "operador": "Leandro"
};

class PedidosScreen extends StatefulWidget {
  static const String routeName = '/pedidos';
  @override
  _PedidosScreenState createState() => _PedidosScreenState();
}

class _PedidosScreenState extends State<PedidosScreen> {
  Future sendData() async {
    // set up POST request arguments
    String url = 'https://leandrotech.com.br/acarajedasocorro/get_produtos';
    // Map<String, String> headers = {"Content-type": "application/json"};
    // String json = jsonEncode(dados);
    // make POST request
    // http.Response response = await http.post(url, headers: headers, body: json);
    http.Response response = await http.get(
      url,
    );
    String body = response.body;
    print(body);
  }

  static const menuItems = <String>[
    'Somente o bolinho',
    'Two',
    'Three',
    'Four',
  ];

  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  String _btn2SelectedVal;

  int _qtProdutos = 0;
  int _qtPimenta = 0;

  void _up(int value, int option) {
    if (option == 1) {
      setState(() {
        _qtProdutos += value;
      });
    } else {
      if (_qtPimenta < _qtProdutos) {
        setState(() {
          _qtPimenta += 1;
        });
      }
    }
  }

  void _down(int value, int option) {
    if (option == 1) {
      setState(() {
        if (_qtProdutos > 0) {
          _qtProdutos -= value;
        }
      });
    } else {
      setState(() {
        if (_qtPimenta > 0 && _qtPimenta < _qtProdutos) {
          _qtPimenta -= value;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedidos"),
      ),
      backgroundColor: Colors.yellow[300],
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 10.0),
        child: Column(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Escolha a opção',
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                DropdownButton(
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.blue,
                  ),
                  value: _btn2SelectedVal,
                  hint: const Text('Selecione...'),
                  onChanged: (String newValue) {
                    setState(() {
                      _btn2SelectedVal = newValue;
                    });
                  },
                  items: _dropDownMenuItems,
                ),
                Text(
                  'Digite a quantidade',
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      color: Colors.blue,
                      onPressed: () {
                        _up(1, 1);
                      },
                      child: Icon(
                        Icons.arrow_drop_up,
                        color: Colors.white,
                        size: 40.0,
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                        child: Text(
                          '$_qtProdutos',
                          style: TextStyle(fontSize: 30.0),
                        ),
                      ),
                    ),
                    RaisedButton(
                      color: Colors.red,
                      onPressed: () {
                        _down(1, 1);
                      },
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                        size: 40.0,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Quantos com pimenta',
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      color: Colors.blue,
                      onPressed: () {
                        _up(1, 2);
                      },
                      child: Icon(
                        Icons.arrow_drop_up,
                        color: Colors.white,
                        size: 40.0,
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                        child: Text(
                          '$_qtPimenta',
                          style: TextStyle(fontSize: 30.0),
                        ),
                      ),
                    ),
                    RaisedButton(
                      color: Colors.red,
                      onPressed: () {
                        _down(1, 2);
                      },
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                        size: 40.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      RaisedButton(
                        color: Colors.orangeAccent,
                        onPressed: () {},
                        child: Text(
                          'Comandar',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text('Comanda'),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "Nome do cliente",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "Observação",
                            ),
                          ),
                        ),
                        RaisedButton(
                          color: Colors.green,
                          onPressed: () {},
                          child: Text(
                            'Fazer pedido',
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
