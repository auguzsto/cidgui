import 'package:cidgui/src/constants/routes.dart';
import 'package:flutter/material.dart';

class ButtonBottonNavigator extends StatelessWidget {
  const ButtonBottonNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: MaterialStateMouseCursor.clickable,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, RoutesPages.joinDomain),
        child: Container(
          decoration: const BoxDecoration(color: Colors.blue),
          padding: const EdgeInsets.all(22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.login,
                color: Colors.white,
                size: 21,
              ),
              SizedBox(width: 10),
              Text(
                "Sign in to the domain",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
