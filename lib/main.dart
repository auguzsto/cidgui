import 'package:cidgui/src/services/database_services.dart';
import 'package:cidgui/src/themes/app_widget.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await DatabaseServices().open().then((db) => DatabaseServices().create(db));

  runApp(
    const AppWidget(),
  );
}
