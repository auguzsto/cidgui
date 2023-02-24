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
bool isLoading = false;

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

            //Label
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

            //Button
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
                  setState(() {
                    isLoading = true;
                  });

                  await cid.shareDel(controller.text, context);

                  setState(() {
                    isLoading = false;
                  });
                },
                icon: isLoading == true
                    ? const SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                    )
                    : const Icon(Icons.folder_off),
                label:
                    isLoading == true ? const Text("") : const Text("Remove"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
