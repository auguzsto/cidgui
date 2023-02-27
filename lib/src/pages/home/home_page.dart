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
        title: const Text("Manager"),
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

          //Menu
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                MyMenu.options.length,
                (index) => MouseRegion(
                  cursor: MaterialStateMouseCursor.clickable,
                  child: GestureDetector(
                    onTap: () async {
                      //Navigator pages.
                      index == 0
                          ? Navigator.pushNamed(
                              context, RoutesPages.leaveDomain)
                          : index == 1
                              ? Navigator.pushNamed(
                                  context, RoutesPages.addFolderShared)
                              : index == 2
                                  ? Navigator.pushNamed(
                                      context, RoutesPages.delFolderShared)
                                  : null;
                    },

                    //Containers
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      height: 110,
                      width: 160,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            MyMenuIcons.icons[index],
                            color: Colors.blue,
                            size: 60,
                          ),
                          Text(
                            MyMenu.options[index],
                          ),
                        ],
                      ),
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
