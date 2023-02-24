import 'dart:io';

import 'package:cidgui/src/constants/stdout.dart';

class StdoutController {
  //Stdout updated folder.
  bool added(List<ProcessResult> result) {
    return result[0].stdout.toString().contains(StdoutCid.added);
  }
  
  //Stdout updated folder.
  bool updated(List<ProcessResult> result) {
    return result[0].stdout.toString().contains(StdoutCid.updated);
  }
}