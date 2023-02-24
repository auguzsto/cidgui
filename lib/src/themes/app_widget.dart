import 'package:cidgui/src/constants/routes.dart';
import 'package:cidgui/src/pages/home/home_page.dart';
import 'package:cidgui/src/pages/join_domain/join_domain_page.dart';
import 'package:cidgui/src/pages/share_add/sharedadd_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CID GUI ',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      initialRoute: '/',
      routes: {
        RoutesPages.addFolderShared: (context) => const AddSharedFolder(),
        RoutesPages.joinDomain: (context) => const JoinDomainPage(),
      },
    );
  }
}
