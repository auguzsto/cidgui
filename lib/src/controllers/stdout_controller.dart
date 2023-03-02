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
}
