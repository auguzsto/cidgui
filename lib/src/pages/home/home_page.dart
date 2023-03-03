import 'package:cidgui/src/pages/home/components/bottom_navigator.dart';
import 'package:cidgui/src/pages/home/components/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text("Manager"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Icon(
            Icons.admin_panel_settings,
            color: Colors.blue,
            size: 150,
          ),
          Center(
            child: Text("Manager"),
          ),
        ],
      ),

      //Botton navigator.
      bottomNavigationBar: const BottomNavigator(),
    );
  }
}
