import 'package:flutter/material.dart';
import 'package:leandrotech/screens/tabs/pedidosIndividuais.dart';
import 'package:leandrotech/screens/tabs/second.dart';

void main() {
  runApp(MaterialApp(home: MyHome()));
}

class MyHome extends StatefulWidget {
  @override
  MyHomeState createState() => MyHomeState();
}

// SingleTickerProviderStateMixin is used for animation
class MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  // Create a tab controller
  TabController controller;

  @override
  void initState() {
    super.initState();

    // Initialize the Tab Controller
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: AppBar(
        // Title
        centerTitle: true,
        title: Image.asset(
          'images/newLogo.png',
          width: 50.0,
        ),
        backgroundColor: Colors.blue,
      ),
      // Set the TabBar view as the body of the Scaffold
      body: TabBarView(
        // Add tabs as widgets
        children: <Widget>[PedidosScreen(), SecondTab()],
        // set the controller
        controller: controller,
      ),
      // Set the bottom navigation bar
      bottomNavigationBar: Material(
        // set the color of the bottom navigation bar
        color: Colors.blue,
        // set the tab bar as the child of bottom navigation bar
        child: TabBar(
          tabs: <Tab>[
            Tab(
              // set icon to the tab
              icon: Icon(Icons.fastfood),
              child: Text('Pedidos individuais'),
            ),
            Tab(
              icon: Icon(Icons.restaurant_menu),
              child: Text('Pedidos mesas'),
            ),
          ],
          // setup the controller
          controller: controller,
        ),
      ),
    );
  }
}
