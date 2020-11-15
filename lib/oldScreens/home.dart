import 'package:flutter/material.dart';
import 'pedidos.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // var _appName = 'Leandrotech App';

  Drawer getNavDrawer(BuildContext context) {
    var headerChild = DrawerHeader(
      child: Image.asset(
        'images/newLogo.png',
        width: 10,
      ),
    );

    ListTile getNavItem(var icon, String s, String routeName) {
      return ListTile(
        leading: Icon(icon),
        title: Text(s),
        onTap: () {
          setState(() {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(routeName);
          });
        },
      );
    }

    // Lista para ser adicionado os items que ficarão no menu, icones e o texto.
    var myNavChildren = [
      headerChild,
      getNavItem(Icons.home, 'Home', '/'),
      getNavItem(Icons.receipt, 'Fazer pedidos', PedidosScreen.routeName),
      // getNavItem(
      //     Icons.account_box, "Conta de usuário", AccountScreen.routeName),
      // getNavItem(Icons.http, 'Get Http', HttpScreen.routeName),
      // getNavItem(Icons.accessibility, 'IMC', ImcScreen.routeName),
      // getNavItem(
      //     Icons.person_pin, "Contador de Pessoas", PeopleScreen.routeName),
      // getNavItem(
      //     Icons.monetization_on, 'Conversor de moedas', CoinsScreen.routeName),
      // getNavItem(Icons.power, "Controle de Energia", EnergyScreen.routeName),
      // aboutChild
    ];

    ListView listView = ListView(children: myNavChildren);

    return Drawer(
      child: listView,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bem vindo!',
                style: TextStyle(
                  fontSize: 48.0,
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: getNavDrawer(context),
    );
  }
}
