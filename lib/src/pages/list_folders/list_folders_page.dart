import 'package:cidgui/src/controllers/cid_controller.dart';
import 'package:cidgui/src/controllers/folder_controller.dart';
import 'package:cidgui/src/models/folder_model.dart';
import 'package:flutter/material.dart';

class ListFoldersPages extends StatefulWidget {
  const ListFoldersPages({super.key});

  @override
  State<ListFoldersPages> createState() => _ListFoldersPagesState();
}

final folderController = FolderController();
final cid = CidController();

class _ListFoldersPagesState extends State<ListFoldersPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List folders"),
      ),
      body: FutureBuilder(
        future: folderController.all(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          //List
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              //Constructor folderModel.
              final folderModel = FolderModel.fromMap(snapshot.data![index]);

              return ListTile(
                leading: const Icon(
                  Icons.folder,
                  color: Colors.blue,
                ),
                trailing: _DeleteFolder(folderModel: folderModel),
                title: Text(folderModel.name!),
              );
            },
          );
        },
      ),
    );
  }
}

//Delete folder.
class _DeleteFolder extends StatelessWidget {
  const _DeleteFolder({
    super.key,
    required this.folderModel,
  });

  final FolderModel folderModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await cid.shareDel(folderModel.name!, context);
        await folderController.deleteByName(folderModel.name!);
      },
      child: const Icon(Icons.delete),
    );
  }
}
