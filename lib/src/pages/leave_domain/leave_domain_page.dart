import 'package:cidgui/src/constants/labels_icons.dart';
import 'package:flutter/material.dart';

class LeaveDomainPage extends StatelessWidget {
  LeaveDomainPage({super.key});

  List labels = [
    'Admin Account',
    'Password',
  ];

  List<TextEditingController> controller = [
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leave domain"),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Icon(
                Icons.exit_to_app,
                color: Colors.blue,
                size: 150,
              ),
            ),

            //Labels
            Column(
              children: List.generate(
                labels.length,
                (index) => Container(
                  margin: const EdgeInsets.all(5),
                  child: TextFormField(
                    controller: controller[index],
                    decoration: InputDecoration(
                        labelText: labels[index],
                        prefixIcon: Icon(
                          LeaveDomainLabelsIcon.icons[index],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                  ),
                ),
              ),
            ),

            //Button
            Container(
              padding: const EdgeInsets.all(5.0),
              height: 65,
              child: ElevatedButton.icon(
                onPressed: () async {},
                icon: const Icon(Icons.exit_to_app),
                label: const Text("Leave"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
