import 'package:flutter/material.dart';

class SuffixIconLabel extends StatelessWidget {
  SuffixIconLabel({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
  });

  final String title;
  final String content;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: MaterialStateMouseCursor.clickable,
      child: GestureDetector(
        onTap: dialog(
          title: title,
          content: content,
          icon: icon,
          context: context,
        ),
        child: const Icon(
          Icons.help,
          color: Colors.blue,
          size: 26,
        ),
      ),
    );
  }
}

void Function() dialog({
  required String title,
  required String content,
  required IconData icon,
  required BuildContext context,
}) {
  return () {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              Expanded(
                child: Text(content),
              ),
              Icon(
                icon,
                color: Colors.blue,
                size: 250,
              ),
            ],
          ),
        );
      },
    );
  };
}
