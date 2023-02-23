import 'dart:ffi';
import 'dart:io';

import 'package:cidgui/src/constants/commands.dart';
import 'package:cidgui/src/handlers/messages_handlers.dart';
import 'package:cidgui/src/pages/share_add/sharedadd_page.dart';
import 'package:flutter/material.dart';
import 'package:process_run/shell.dart';

class CidController {
  final shell = Shell();
  final handlers = MessagesHandlers();

  //Add shared folder cid.
  Future shareAdd(String name, String path, BuildContext context) async {
    try {
      await shell.run('''
        ${Commands.cidShareAdd} name='$name' path='$path'
        ''');
      return handlers.message(context: context, message: "Done, your folder has been shared.");
    } catch (e) {
      return handlers.message(
          context: context, message: "Shared name or path already exists.", isError: true);
    }
  }

  //Delete shared folder cid.
  Future shareDel(String name) async {
    try {
      await shell.run('''
        ${Commands.cidShareDel} name='$name' 
        ''');
    } catch (e) {
      throw Exception(e);
    }
  }

  //Join in AD.
  Future enterDomain(
      String domain, String adminAccount, String password) async {
    try {
      await shell.run('''
        ${Commands.cidJoin} '$domain' '$adminAccount' '$password'
        ''');
    } catch (e) {
      throw Exception(e);
    }
  }
}
