import 'package:flutter/material.dart';

class ShareDelPage extends StatefulWidget {
  const ShareDelPage({super.key});

  @override
  State<ShareDelPage> createState() => _ShareDelPageState();
}

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
            TextFormField(
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
                  onPressed: () {},
                  icon: const Icon(Icons.folder_off),
                  label: const Text("Remove")),
            )
          ],
        ),
      ),
    );
  }
}
