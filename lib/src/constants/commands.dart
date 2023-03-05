abstract class Commands {
  static const String cidShareAdd = 'sudo cid share add mode=common';
  static const String cidImportAccount = 'sudo cid account add';
  static const String cidShareDel = 'sudo cid share del';
  static const String cidJoin = 'sudo cid join';
  static const String cidLeave = 'sudo cid leave';
  static const String chmodDefault = 'sudo chmod -R 771';
  static const String groupOwner = "sudo chgrp 'domain admins'";
  static const String addUserDefault = 'everyone';
  static const String addGroupDefault = 'everyone';
  static const String ruleAddUser = '+u:';
  static const String ruleAddGroup = '+g:';
  static const String ruleOnlyRead = ':r';
  static const String ruleReadAndWrite = ':f';
  static const String cidStatus = 'sudo cid status';
}
