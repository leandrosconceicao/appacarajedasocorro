import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

// const request = 'https://leandrotech.com.br/acarajedasocorro/check_preco';
// const dados = {
//   "_id": 91507135,
//   "diaOperacao": "31/10/2020",
//   "data": "2020-10-31 10:39:35",
//   "pedidos": [
//     {
//       "qtProdutos": 1,
//       "opcao": "Porção de acarajés",
//       "descPedido": "Porção de acarajés 0 com pimenta",
//       "valPedido": 25
//     }
//   ],
//   "precoTotal": 25,
//   "pago": false,
//   "clientName": "Mesa da gente 01",
//   "obs": "",
//   "status": "Pendente",
//   "operador": "Leandro"
// };

class PedidosScreen extends StatefulWidget {
  static const String routeName = '/pedidos';
  @override
  _PedidosScreenState createState() => _PedidosScreenState();
}

class _PedidosScreenState extends State<PedidosScreen> {
  String _minhaSelecao;
  List data = List();
  List opts = List();
  int _qtProdutos = 0;
  int _qtPimenta = 0;
  int _valUnit = 0;
  int _valTotal = 0;

  void comandar() {
    if (_qtProdutos == 0 || _minhaSelecao == null) {
      print('Escolha uma opção e a quantidade');
    } else {
      opts.add({
        'qtProdutos': _qtProdutos,
        'opcao': _minhaSelecao,
        'descPedido': _minhaSelecao,
        'valPedido': _valTotal
      });
      setState(() {
        _minhaSelecao = null;
        _qtProdutos = 0;
        _qtPimenta = 0;
        _valUnit = 0;
      });
    }
  }

  Future<void> efetuarPedido(Map value) async {
    var data = DateTime.now();
    http.Response res = await http.post(
        'https://leandrotech.com.br/acarajedasocorro/efetuar_pedido',
        headers: {"Content-type": "application/json"},
        body: jsonEncode(value));
    var resbody = jsonDecode(res.body);
    print(resbody);
  }

  Future<void> checkPreco(String value) async {
    http.Response res = await http.post(
        'https://leandrotech.com.br/acarajedasocorro/check_preco',
        headers: {"Content-type": "application/json"},
        body: jsonEncode(value));
    var resbody = jsonDecode(res.body);
    setState(() {
      _valUnit = resbody['preco'];
    });
  }

  Future<void> getDados() async {
    http.Response res = await http.get(
        Uri.encodeFull(
            'https://leandrotech.com.br/acarajedasocorro/get_produtos'),
        headers: {"Content-Type": "application/json"});
    var resBody = json.decode(utf8.decode(res.bodyBytes));

    setState(() {
      data = resBody;
    });
  }

  void _up(int value, int option) {
    if (_minhaSelecao != null) {
      if (option == 1) {
        setState(() {
          _qtProdutos += value;
          _valTotal = _qtProdutos * _valUnit;
        });
      } else {
        if (_qtPimenta < _qtProdutos) {
          setState(() {
            _qtPimenta += 1;
          });
        }
      }
    }
  }

  void _down(int value, int option) {
    if (option == 1) {
      setState(() {
        if (_qtProdutos > 0) {
          _qtProdutos -= value;
          _valTotal = _qtProdutos * _valUnit;
        }
        if (_qtPimenta > 0 && _qtProdutos <= _qtPimenta) {
          _qtPimenta = _qtProdutos;
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
  void initState() {
    super.initState();
    this.getDados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 10.0),
        child: Column(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(2.0, 1.0, 2.0, 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.restaurant,
                        color: Colors.blueAccent,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                      ),
                      Text(
                        'Faça seu pedido',
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Escolha a opção',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                DropdownButton(
                  icon: Icon(Icons.view_headline),
                  dropdownColor: Colors.blue[300],
                  hint: Text(
                    'Selecione...',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 18.0),
                  ),
                  items: data.map((item) {
                    return new DropdownMenuItem(
                      child: new Text(
                        item['_id'],
                      ),
                      value: item['_id'].toString(),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    setState(() {
                      _minhaSelecao = newVal;
                      checkPreco(newVal);
                    });
                  },
                  value: _minhaSelecao,
                ),
                Text(
                  'Digite a quantidade',
                  style: TextStyle(
                    fontSize: 18.0,
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
                    fontSize: 18.0,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Valor unitário: R\$ $_valUnit,00'),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                    ),
                    Text('Valor total: R\$ $_valTotal,00'),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      RaisedButton(
                        color: Colors.orangeAccent,
                        onPressed: () {
                          comandar();
                        },
                        child: Text(
                          'Comandar',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
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
                              fontSize: 18.0,
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
