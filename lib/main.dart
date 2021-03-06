import 'package:flutter/material.dart';
import 'oldScreens/pedidos.dart';
import 'package:leandrotech/screens/telaPedidos.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
      routes: <String, WidgetBuilder>{
        PedidosScreen.routeName: (BuildContext context) => MyHome()
      }));
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIOverlays([]);
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyHome()));
    });
  }

  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellowAccent,
      child: Center(
        child: Container(
          width: 150,
          height: 150,
          child: Image.asset(
            'images/newLogo.png',
          ),
        ),
      ),
    );
  }
}
