import 'package:cidgui/src/controllers/cid_controller.dart';
import 'package:cidgui/src/controllers/folder_controller.dart';
import 'package:cidgui/src/services/database_services.dart';
import 'package:cidgui/src/themes/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await DatabaseServices().open().then(
        (db) => DatabaseServices().create(db),
      );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CidController>(
          create: (context) => CidController(),
        )
      ],
      child: const AppWidget(),
    ),
  );
}
