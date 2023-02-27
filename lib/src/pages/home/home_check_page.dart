import 'package:cidgui/src/controllers/cid_controller.dart';
import 'package:flutter/material.dart';

class HomeCheckPage extends StatefulWidget {
  const HomeCheckPage({super.key});

  @override
  State<HomeCheckPage> createState() => _HomeCheckPageState();
}

final cid = CidController();

class _HomeCheckPageState extends State<HomeCheckPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checking domain"),
      ),
      body: FutureBuilder(
        future: cid.checkDomain(context),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text("Checking if this computer is part of some domain."),
                ],
              ),
            );
          }

          return const Center();
        },
      ),
    );
  }
}
