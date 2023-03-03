import 'package:cidgui/src/constants/menus.dart';
import 'package:cidgui/src/constants/menus_icons.dart';
import 'package:cidgui/src/constants/routes.dart';
import 'package:flutter/material.dart';

class BottomNavigator extends StatelessWidget {
  const BottomNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      padding: const EdgeInsets.all(22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          MyMenu.options.length,
          (index) {
            return MouseRegion(
              cursor: MaterialStateMouseCursor.clickable,
              child: GestureDetector(
                onTap: () {
                  index == 0
                      ? Navigator.pushNamed(context, RoutesPages.leaveDomain)
                      : index == 1
                          ? Navigator.pushNamed(
                              context, RoutesPages.addFolderShared)
                          : index == 2
                              ? Navigator.pushNamed(
                                  context, RoutesPages.listFolders)
                              : null;
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        MyMenuIcons.icons[index],
                        color: Colors.white,
                        size: 42,
                      ),
                      Text(
                        MyMenu.options[index],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
