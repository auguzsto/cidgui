import 'package:cidgui/src/constants/commands.dart';
import 'package:process_run/shell.dart';

class CidController {
  final shell = Shell();

  //Add shared folder cid.
  Future shareAdd(String name, String path) async {
    try {
      await shell.run('''
        ${Commands.cidShareAdd} name='$name' path='$path'
        ''');
      
    } catch (e) {
      throw Exception(e);
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

  Future enterDomain(String domain, String adminAccount, String password) async {
    try {
      await shell.run(
        '''
        ${Commands.cidJoin} '$domain' '$adminAccount' '$password'
        '''
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
