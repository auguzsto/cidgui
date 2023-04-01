import 'package:cidgui/src/constants/routes.dart';
import 'package:cidgui/src/pages/home/home_check_page.dart';
import 'package:cidgui/src/pages/home/home_page.dart';
import 'package:cidgui/src/pages/join_domain/join_domain_page.dart';
import 'package:cidgui/src/pages/leave_domain/leave_domain_page.dart';
import 'package:cidgui/src/pages/list_folders/list_folders_page.dart';
import 'package:cidgui/src/pages/share_add/sharedadd_page.dart';
import 'package:cidgui/src/pages/share_del/share_del_page.dart';
import 'package:cidgui/src/pages/share_update/share_update_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CID GUI ',
      debugShowCheckedModeBanner: false,
      home: const HomePage(), //Discomment to development.
      //home: const HomeCheckPage(), //Discomment to build.
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.blue),
          elevation: 0,
          shape: Border(bottom: BorderSide(color: Colors.blue)),
          backgroundColor: Colors.transparent,
          titleTextStyle: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),

      //Routes
      initialRoute: '/',
      routes: {
        RoutesPages.home: (context) => const HomePage(),
        RoutesPages.addFolderShared: (context) => const AddSharedFolder(),
        RoutesPages.joinDomain: (context) => const JoinDomainPage(),
        RoutesPages.delFolderShared: (context) => const ShareDelPage(),
        RoutesPages.leaveDomain: (context) => LeaveDomainPage(),
        RoutesPages.checkDomain: (context) => const HomeCheckPage(),
        RoutesPages.listFolders: (context) => const ListFoldersPages(),
        RoutesPages.updateFolder: (context) => ShareUpdatePage()
      },
    );
  }
}
