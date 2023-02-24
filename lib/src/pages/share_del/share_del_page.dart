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
    );
  }
}
