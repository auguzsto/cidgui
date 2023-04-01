import 'package:cidgui/src/constants/commands.dart';
import 'package:cidgui/src/constants/groupmanager.dart';
import 'package:cidgui/src/constants/routes.dart';
import 'package:cidgui/src/controllers/domain_controller.dart';
import 'package:cidgui/src/controllers/folder_controller.dart';
import 'package:cidgui/src/controllers/stdout_controller.dart';
import 'package:cidgui/src/handlers/messages_handlers.dart';
import 'package:flutter/material.dart';
import 'package:process_run/shell.dart';

class CidController with ChangeNotifier {
  final shell = Shell();
  final handlers = MessagesHandlers();
  final stdout = StdoutController();
  final folderController = FolderController();
  final domainController = DomainController();
  String error = "";

  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  //Add shared folder cid.
  Future shareAdd(
      {required String name,
      required String path,
      String? addUser,
      String? addGroup,
      String? rule,
      required BuildContext context}) async {
    try {
      //Sharing
      await shell.run('''
        ${Commands.cidShareAdd} name='$name' path='$path' rule='${addUser!.isNotEmpty ? Commands.ruleAddUser : addGroup!.isNotEmpty ? Commands.ruleAddGroup : Commands.ruleAddUser}${addUser.isNotEmpty ? addUser : addGroup!.isNotEmpty ? addGroup : addUser.isEmpty ? Commands.addUserDefault : addGroup.isEmpty ? Commands.addGroupDefault : Commands.addUserDefault}${rule ?? Commands.ruleOnlyRead}'
        ''').then(
        (result) async {
          if (stdout.added(result)) {
            await folderController.add(name, path);

            //Group files administrator.
            await shell.run('''
              ${Commands.cidShareAdd} name='$name' path='$path' rule='${Commands.ruleAddGroup}${GroupManager.main}${Commands.ruleReadAndWrite}'
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
          }
        },
      );
    } catch (e) {
      print(e);
      return handlers.message(
          context: context,
          message: "Error. Check the entered data.",
          isError: true);
    }
    notifyListeners();
  }

  //Update shared
  Future shareUpdate(
      {required String name,
      required String path,
      String? operation,
      String? addUser,
      String? addGroup,
      String? rule,
      required BuildContext context}) async {
    try {
      await shell.run(
        '''
      ${Commands.cidShareAdd} name='$name' path='$path' rule='${operation! != Commands.ruleAddUser ? Commands.ruleRemoveUser : Commands.ruleAddUser}${addUser!.isNotEmpty ? addUser : addGroup!.isNotEmpty ? addGroup : addUser.isEmpty ? Commands.addUserDefault : addGroup.isEmpty ? Commands.addGroupDefault : Commands.addUserDefault}${operation != Commands.ruleAddUser ? "" : rule ?? Commands.ruleOnlyRead}'
      ''',
      ).then((result) {
        if (stdout.updated(result)) {
          return handlers.message(
              context: context, message: "Done! Shared updated");
        }
      });
    } catch (e) {
      if (context.mounted) {
        return handlers.message(
          context: context,
          message: "Check that the data entered in the fields is correct.",
          isError: true,
        );
      }
    }
    notifyListeners();
  }

  //Delete shared folder cid.
  Future shareDel(String name, BuildContext context) async {
    try {
      //Removing.
      isLoading.value = true;

      await shell.run('''
        ${Commands.cidShareDel} '$name' 
        ''').then((value) {
        folderController.deleteByName(name);
        isLoading.value = false;
        return handlers.message(
            context: context, message: "Done, your folder was removed.");
      });
    } catch (e) {
      if (e.toString().contains('exitCode 1')) {
        return handlers.message(
            context: context, message: "Name not found.", isError: true);
      }

      return handlers.message(
          context: context, message: "Error", isError: true);
    }
    notifyListeners();
  }

  //Join in AD.
  Future enterDomain(String domain, String adminAccount, String password,
      BuildContext context) async {
    try {
      await shell.run('''
        ${Commands.cidJoin} domain='$domain' user='$adminAccount' pass='$password'
        ''').then((value) async {
        if (stdout.enterDomain(value)) {
          await domainController.add(domain);
        } else {
          return handlers.message(
              context: context, message: "Check that the fields are correct.");
        }
      });
      if (context.mounted) {
        Navigator.pushNamed(context, RoutesPages.checkDomain);
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

  //Leave domain
  Future leaveDomain(
      String adminAccount, String password, BuildContext context) async {
    try {
      await shell.run('''
      ${Commands.cidLeave} user='$adminAccount' pass='$password'
      ''').then(
        (result) async {
          if (stdout.leaveDomain(result)) {
            return handlers.message(
                context: context,
                message: "Done! Your leave domain. Reboot your system");
          }
        },
      );
    } catch (e) {
      handlers.message(
        context: context,
        message: "You don't are part of a domain.",
        isError: true,
      );
      Navigator.pushNamed(context, RoutesPages.checkDomain);
    }
  }

  //Check domain
  Future checkDomain(BuildContext context) async {
    try {
      //Delay future.
      await Future.delayed(const Duration(seconds: 3), () async {
        await shell.run('''
        ${Commands.cidStatus}
        ''')
            //Conditions.
            .then((value) {
          if (stdout.status(value)) {
            return Navigator.pushNamed(context, RoutesPages.home);
          }
        });
      });
    } catch (e) {
      return handlers.message(
        context: context,
        message: "This computer is not part of the domain.",
        isWarning: true,
      );
    }
  }
}
