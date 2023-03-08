import 'package:flutter/material.dart';

class UtilService {
  static MouseRegion clickMouse({
    Future? navigator,
    Widget? child,
    BuildContext? context,
  }) {
    return MouseRegion(
      cursor: MaterialStateMouseCursor.clickable,
      child: GestureDetector(
        onTap: () async => await navigator,
        child: child,
      ),
    );
  }

  static Future<dynamic> routePage(BuildContext context, page) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }
}
