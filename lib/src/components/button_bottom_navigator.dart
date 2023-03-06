import 'package:flutter/material.dart';

class ButtonBottomNavigator extends StatefulWidget {
  ButtonBottomNavigator({
    super.key,
    required this.onTap,
    required this.icon,
    required this.text,
  });

  void Function()? onTap;
  Widget? icon;
  final String text;

  @override
  State<ButtonBottomNavigator> createState() => _ButtonBottomNavigatorState();
}

class _ButtonBottomNavigatorState extends State<ButtonBottomNavigator> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: MaterialStateMouseCursor.clickable,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: const BoxDecoration(color: Colors.blue),
          padding: const EdgeInsets.all(22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.icon!,
              const SizedBox(width: 10),
              Text(
                widget.text,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
