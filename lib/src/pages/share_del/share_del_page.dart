import 'package:cidgui/src/controllers/cid_controller.dart';
import 'package:cidgui/src/handlers/messages_handlers.dart';
import 'package:flutter/material.dart';

class ShareDelPage extends StatefulWidget {
  const ShareDelPage({super.key});

  @override
  State<ShareDelPage> createState() => _ShareDelPageState();
}

final controller = TextEditingController();
final handlers = MessagesHandlers();
final cid = CidController();

class _ShareDelPageState extends State<ShareDelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Remove folder"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Icon(
                Icons.folder_off,
                color: Colors.blue,
                size: 150,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: controller,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.share),
                labelText: "Shared name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () async {
                  if (controller.text.isEmpty) {
                    handlers.message(
                        context: context,
                        message: "Fill in the field.",
                        isError: true);
                  }
                  await cid.shareDel(controller.text, context);
                },
                icon: const Icon(Icons.folder_off),
                label: const Text("Remove"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
