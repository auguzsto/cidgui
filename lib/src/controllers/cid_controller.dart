import 'dart:io';

import 'package:cidgui/src/constants/commands.dart';
import 'package:cidgui/src/controllers/stdout_controller.dart';
import 'package:cidgui/src/handlers/messages_handlers.dart';
import 'package:flutter/material.dart';
import 'package:process_run/shell.dart';

class CidController {
  final shell = Shell();
  final handlers = MessagesHandlers();
  final stdout = StdoutController();

  //Add shared folder cid.
  Future shareAdd(
      {required String name,
      required String path,
      String? addUser,
      String? rule,
      required BuildContext context}) async {
    try {
      //Sharing
      final result = await shell.run('''
        ${Commands.cidShareAdd} name='$name' path='$path' rule='${Commands.ruleAddUser}${addUser!.isEmpty ? Commands.addUserDefault : addUser}${rule ?? Commands.ruleOnlyRead}'
        ''');

      //CHMOD.
      await shell.run('''
        ${Commands.chmodDefault} '$path'
        ''');

      //Group Owner.
      await shell.run('''
        ${Commands.groupOwner} '$path'
        ''');

      //If folder was added.
      if (stdout.added(result) && context.mounted) {
        return handlers.message(
            context: context, message: "Done, your folder as shared.");
      }

      //If folder was updated.
      if (stdout.updated(result) && context.mounted) {
        return handlers.message(
            context: context, message: "Done, your folder as updated.");
      }
    } catch (e) {
      return handlers.message(
          context: context,
          message: "Error. Check the entered data.",
          isError: true);
    }
  }

  //Delete shared folder cid.
  Future shareDel(String name, BuildContext context) async {
    try {
      //Removing.
      await shell.run('''
        ${Commands.cidShareDel} '$name' 
        ''');
      if (context.mounted) {
        return handlers.message(
            context: context, message: "Done, your folder was removed.");
      }
    } catch (e) {
      if (e.toString().contains('exitCode 1')) {
        return handlers.message(
            context: context, message: "Name not found.", isError: true);
      }

      return handlers.message(
          context: context, message: "Error", isError: true);
    }
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
