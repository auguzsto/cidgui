import 'package:cidgui/src/constants/menus.dart';
import 'package:cidgui/src/constants/menus_icons.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        itemCount: DrawerMenu.options.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: DrawerMenuIcons.icons[index],
            title: Text(DrawerMenu.options[index]),
          );
        },
      ),
    );
  }
}
