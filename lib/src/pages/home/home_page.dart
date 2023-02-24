import 'package:cidgui/src/constants/menus.dart';
import 'package:cidgui/src/constants/menus_icons.dart';
import 'package:cidgui/src/constants/routes.dart';
import 'package:cidgui/src/pages/home/components/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text("CID FLUTTER"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 5,
          ),
          Center(
            child: Container(
              height: size.height / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.admin_panel_settings,
                    color: Colors.blue,
                    size: 150,
                  ),
                  Text("Manager")
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(
                MyMenu.options.length,
                (index) => Container(
                  padding: const EdgeInsets.all(2),
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      index == 0
                          ? Navigator.pushNamed(context, RoutesPages.joinDomain)
                          : index == 1
                              ? Navigator.pushNamed(
                                  context, RoutesPages.addFolderShared)
                              : Navigator.pushNamed(
                                  context, RoutesPages.delFolderShared);
                    },
                    icon: MyMenuIcons.icons[index],
                    label: Row(
                      children: [
                        Text(MyMenu.options[index]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
