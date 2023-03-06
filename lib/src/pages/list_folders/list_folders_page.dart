import 'package:cidgui/src/controllers/cid_controller.dart';
import 'package:cidgui/src/controllers/folder_controller.dart';
import 'package:cidgui/src/models/folder_model.dart';
import 'package:cidgui/src/pages/share_update/share_update_page.dart';
import 'package:flutter/material.dart';

class ListFoldersPages extends StatefulWidget {
  const ListFoldersPages({super.key});

  @override
  State<ListFoldersPages> createState() => _ListFoldersPagesState();
}

final folderController = FolderController();
final cid = CidController();
bool isSearch = false;
final controller = TextEditingController();

class _ListFoldersPagesState extends State<ListFoldersPages> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("List folders"),
      ),
      body: FutureBuilder(
        future: isSearch == false
            ? folderController.all()
            : folderController.getByName(controller.text),
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
                title: MouseRegion(
                  cursor: MaterialStateMouseCursor.clickable,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ShareUpdatePage(
                        folder: folderModel,
                      ),
                    )),
                    child: Text(folderModel.name!),
                  ),
                ),
              );
            },
          );
        },
      ),

      //Labels search.
      bottomSheet: Container(
        decoration: const BoxDecoration(
          color: Colors.blue,
        ),
        padding: const EdgeInsets.all(18),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width / 1.1,
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    value.isEmpty ? isSearch = false : isSearch = true;
                  });
                },
                controller: controller,
                autofocus: false,
                showCursor: true,
                cursorColor: Colors.white,
                style: const TextStyle(fontSize: 22, color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search folder by name",
                  hintStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: MouseRegion(
                    cursor: MaterialStateMouseCursor.clickable,
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: size.width / 20,
                    ),
                  ),
                  isDense: true,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Delete folder.
class _DeleteFolder extends StatefulWidget {
  const _DeleteFolder({
    super.key,
    required this.folderModel,
  });

  final FolderModel folderModel;

  @override
  State<_DeleteFolder> createState() => _DeleteFolderState();
}

class _DeleteFolderState extends State<_DeleteFolder> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await cid.shareDel(widget.folderModel.name!, context);
      },
      child: const Icon(Icons.delete),
    );
  }
}
