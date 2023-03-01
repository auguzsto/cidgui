import 'package:cidgui/src/repository/folder_repository.dart';

class FolderController {
  final folderRepository = FolderRepository();

  Future<void> add(String name, String path) async {
    await folderRepository.add(name, path);
  }

  Future<void> deleteByName(String name) async {
    await folderRepository.deleteByName(name);
  }

  Future<List<Map<String, dynamic>>> all() async {
    return folderRepository.all();
  }
}
