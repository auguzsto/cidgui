import 'dart:io';

import 'package:cidgui/src/constants/stdout.dart';

class StdoutController {
  //Stdout add folder.
  bool added(List<ProcessResult> result) {
    return result[0].stdout.toString().contains(StdoutCid.added);
  }

  //Stdout updated folder.
  bool updated(List<ProcessResult> result) {
    return result[0].stdout.toString().contains(StdoutCid.updated);
  }

  //Stdout updated folder.
  bool status(List<ProcessResult> result) {
    return result[0].stdout.toString().contains(StdoutCid.computers);
  }

  //Stdout add domain.
  bool enterDomain(List<ProcessResult> result) {
    return result[0].stdout.toString().contains(StdoutCid.enterDomain);
  }

  //Stdout leave domain.
  bool leaveDomain(List<ProcessResult> result) {
    return result[0].stdout.toString().contains(StdoutCid.leaveDomain);
  }

  //Stdout belong to a domain.
  bool requiredDomain(List<ProcessResult> result) {
    return result[0]
        .toString()
        .contains("This command requires the station to belong to a domain!");
  }

  //Stdout user invalid.
  bool userInvalid(List<ProcessResult> result) {
    return result[0].toString().contains("invalid account");
  }
}
