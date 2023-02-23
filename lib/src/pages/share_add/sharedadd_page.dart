import 'package:cidgui/src/controllers/cid_controller.dart';
import 'package:cidgui/src/handlers/messages_handlers.dart';
import 'package:flutter/material.dart';

class AddSharedFolder extends StatefulWidget {
  const AddSharedFolder({super.key});

  @override
  State<AddSharedFolder> createState() => _AddSharedFolderState();
}

List labels = [
  'Name shared',
  'Path',
];
List<TextEditingController> controllers = [
  TextEditingController(),
  TextEditingController(),
];
final cid = CidController();
final handlers = MessagesHandlers();

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
              ),
            ],
          ),

          //Labels
          Column(
            children: List.generate(
              labels.length,
              (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
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
                  (index) {
                    //Message error labels emptys.
                    if (controllers[0].text.isEmpty ||
                        controllers[1].text.isEmpty) {
                      //Snackbar error.
                      return handlers.message(context: context, message: "Fill in all fields.", isError: true);
                    }
                  },
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
