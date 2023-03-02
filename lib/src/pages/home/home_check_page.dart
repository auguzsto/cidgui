import 'package:cidgui/src/constants/routes.dart';
import 'package:cidgui/src/controllers/cid_controller.dart';
import 'package:cidgui/src/controllers/domain_controller.dart';
import 'package:cidgui/src/models/domain_model.dart';
import 'package:flutter/material.dart';

class HomeCheckPage extends StatefulWidget {
  const HomeCheckPage({super.key});

  @override
  State<HomeCheckPage> createState() => _HomeCheckPageState();
}

final cid = CidController();
final domainController = DomainController();

class _HomeCheckPageState extends State<HomeCheckPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checking domain"),
      ),
      body: FutureBuilder(
        future: domainController.all(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text("Checking if this computer is part of domain"),
                ],
              ),
            );
          }

          //Go to home page.
          if (snapshot.data!.isNotEmpty) {
            domainController.all().then((value) async {
              await Future.delayed(
                Duration.zero,
                () => Navigator.pushNamed(context, RoutesPages.home),
              );
            });
          }

          //Page info to enter domain.
          if (snapshot.data!.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Icon(
                    Icons.warning,
                    color: Colors.orange,
                    size: 150,
                  ),
                ),
                const Text(
                    "You must be part of a domain to use the features of this application."),

                //Button
                Container(
                  height: 50,
                  margin: const EdgeInsets.all(15),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesPages.joinDomain);
                    },
                    icon: const Icon(Icons.login),
                    label: const Text("Sign in to the domain."),
                  ),
                ),
              ],
            );
          }

          return const Center(
              child: CircularProgressIndicator(
            color: Colors.blue,
          ));
        },
      ),
    );
  }
}
