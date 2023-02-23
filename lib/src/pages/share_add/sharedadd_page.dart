import 'package:cidgui/src/controllers/cid_controller.dart';
import 'package:flutter/material.dart';

class AddSharedFolder extends StatefulWidget {
  const AddSharedFolder({super.key});

  @override
  State<AddSharedFolder> createState() => _AddSharedFolderState();
}

List labels = ['Name shared', 'Path'];
List<TextEditingController> controllers = [
  TextEditingController(),
  TextEditingController(),
];
final cid = CidController();

class _AddSharedFolderState extends State<AddSharedFolder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Folder"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: const [
              Icon(
                Icons.folder,
                size: 150,
                color: Colors.blue,
              )
            ],
          ),

          //Labels
          Column(
            children: List.generate(
              labels.length,
              (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controllers[index],
                    decoration: InputDecoration(
                      labelText: labels[index],
                      prefixIcon: index == 0
                          ? const Icon(Icons.share)
                          : const Icon(Icons.folder),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          //Button
          Container(
            padding: const EdgeInsets.all(5.0),
            height: 65,
            child: ElevatedButton.icon(
              onPressed: () {
                List.generate(
                  1,
                  (index) =>
                      cid.shareAdd(controllers[0].text, controllers[1].text),
                );
              },
              icon: const Icon(Icons.add_task),
              label: const Text("Send"),
            ),
          )
        ],
      ),
    );
  }
}
