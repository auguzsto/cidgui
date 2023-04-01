import 'package:cidgui/src/constants/routes.dart';
import 'package:cidgui/src/controllers/cid_controller.dart';
import 'package:cidgui/src/controllers/folder_controller.dart';
import 'package:cidgui/src/models/folder_model.dart';
import 'package:cidgui/src/pages/share_update/share_update_page.dart';
import 'package:cidgui/src/services/util_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListFoldersPages extends StatelessWidget {
  const ListFoldersPages({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CidController cid = Provider.of<CidController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("List Folders"),
      ),

      //Body
      body: AnimatedBuilder(
        animation: isSearch,
        builder: (context, child) {
          //Future
          return FutureBuilder(
            future: isSearch.value == false
                ? folderController.all()
                : folderController.getByName(controller.text),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              //List of the folders shared.
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  //Constructor folderModel.
                  final folderModel =
                      FolderModel.fromMap(snapshot.data![index]);

                  return ListTile(
                    leading: const Icon(
                      Icons.folder,
                      color: Colors.blue,
                    ),
                    trailing: AnimatedBuilder(
                      animation: cid.isLoading,
                      builder: (context, child) {
                        if (cid.isLoading.value) {
                          return const SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator());
                        }

                        return IconButton(
                          splashRadius: 18,
                          onPressed: () async {
                            await cid.shareDel(folderModel.name!, context);
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                        );
                      },
                    ),
                    title: MouseRegion(
                      cursor: MaterialStateMouseCursor.clickable,
                      child: GestureDetector(
                        onTap: () => UtilService.routePage(
                          context,
                          ShareUpdatePage(
                            folder: folderModel,
                          ),
                        ),
                        child: Text(folderModel.name!),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),

      //Labels search.
      bottomNavigationBar: Container(
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
                  value.isEmpty
                      ? isSearch.value = false
                      : isSearch.value = true;
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

      //Floating button action.
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed(RoutesPages.addFolderShared);
        },
        label: const Text("Add folder"),
        icon: const Icon(Icons.folder),
      ),
    );
  }
}

final folderController = FolderController();
//final cid = CidController();
final controller = TextEditingController();
final utilService = UtilService();
ValueNotifier<bool> isSearch = ValueNotifier<bool>(false);

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
