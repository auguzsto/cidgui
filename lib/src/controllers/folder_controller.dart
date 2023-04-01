import 'package:cidgui/src/repository/folder_repository.dart';
import 'package:flutter/material.dart';

class FolderController extends ChangeNotifier {
  final folderRepository = FolderRepository();

  //Add folder
  Future<void> add(String name, String path) async {
    await folderRepository.add(name, path);
  }

  //Delte folder by name
  Future<void> deleteByName(String name) async {
    await folderRepository.deleteByName(name);
  }

  //Lists folders
  Future<List<Map<String, dynamic>>> all() async {
    return folderRepository.all();
  }

  //Lists folders
  Future<List<Map<String, dynamic>>> getByName(String name) async {
    return folderRepository.getByName(name);
  }
}
