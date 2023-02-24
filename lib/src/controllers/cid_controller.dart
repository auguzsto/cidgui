import 'package:cidgui/src/constants/commands.dart';
import 'package:cidgui/src/handlers/messages_handlers.dart';
import 'package:flutter/material.dart';
import 'package:process_run/shell.dart';

class CidController {
  final shell = Shell();
  final handlers = MessagesHandlers();

  //Add shared folder cid.
  Future shareAdd(String name, String path, BuildContext context) async {
    try {
      //Sharing
      await shell.run('''
        ${Commands.cidShareAdd} name='$name' path='$path'
        ''');

      //CHMOD.
      await shell.run('''
        ${Commands.chmodDefault} '$path'
        ''');

      //Group Owner.
      await shell.run('''
        ${Commands.groupOwner} '$path'
        ''');
      if (context.mounted) {
        return handlers.message(
            context: context, message: "Done, your folder has been shared.");
      }
    } catch (e) {
      return handlers.message(
          context: context,
          message: "Shared name or path already exists.",
          isError: true);
    }
  }

  //Delete shared folder cid.
  Future shareDel(String name, BuildContext context) async {
    try {
      await shell.run('''
        ${Commands.cidShareDel} name='$name' 
        ''');
    } catch (e) {}
  }

  //Join in AD.
  Future enterDomain(String domain, String adminAccount, String password,
      BuildContext context) async {
    try {
      await shell.run('''
        ${Commands.cidJoin} domain='$domain' user='$adminAccount' pass='$password'
        ''');
      if (context.mounted) {
        return handlers.message(
            context: context,
            message: "Done, you enter in domain. Reboot system.");
      }
    } catch (e) {
      if (e.toString().contains('exitCode 1')) {
        return handlers.message(
          context: context,
          message: "You are already part of a domain.",
          isError: true,
        );
      }
      return handlers.message(
        context: context,
        message: "Check that the fields are correct.",
        isError: true,
      );
    }
  }
}
