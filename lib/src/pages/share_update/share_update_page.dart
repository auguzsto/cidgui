import 'package:cidgui/src/components/button_bottom_navigator.dart';
import 'package:cidgui/src/constants/commands.dart';
import 'package:cidgui/src/constants/labels.dart';
import 'package:cidgui/src/constants/labels_icons.dart';
import 'package:cidgui/src/controllers/cid_controller.dart';
import 'package:cidgui/src/models/folder_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class ShareUpdatePage extends StatefulWidget {
  ShareUpdatePage({
    super.key,
    this.folder,
  });

  FolderModel? folder;

  @override
  State<ShareUpdatePage> createState() => _ShareUpdatePageState();
}

final cid = CidController();
List<TextEditingController> controller = [
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
];

List rules = [
  'Only read',
  'Read and write',
];

String? selectedValue = "Only read";
String? valuesRules;

List operationRulesUsersAndGroups = [
  '+',
  '-',
];

Object? selectedValuesRulesUsers;
String? commandOperation;
bool isLoading = false;

class _ShareUpdatePageState extends State<ShareUpdatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update shared"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.folder_open,
            color: Colors.blue,
            size: 150,
          ),

          //Labels
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(
              Labels.folder.length,
              (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controller[index],
                    enabled: index == 0
                        ? false
                        : index == 1
                            ? false
                            : true,
                    decoration: InputDecoration(
                      labelText: index == 0
                          ? widget.folder!.name
                          : index == 1
                              ? widget.folder!.path
                              : Labels.folder[index],
                      prefixIcon: index == 2
                          ?
                          //Dropdown label user.
                          DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                value: selectedValuesRulesUsers,
                                hint: Row(
                                  children: [
                                    const Icon(Icons.person),
                                    Text(operationRulesUsersAndGroups.first)
                                  ],
                                ),
                                items: operationRulesUsersAndGroups
                                    .map(
                                      (item) => DropdownMenuItem(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.person,
                                            ),
                                            Text(item),
                                          ],
                                        ),
                                        value: item[0],
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  setState(
                                    () {
                                      selectedValuesRulesUsers = value;
                                      if (value != "+") {
                                        commandOperation =
                                            Commands.ruleRemoveUser;
                                      } else {
                                        commandOperation = Commands.ruleAddUser;
                                      }
                                    },
                                  );
                                  print(commandOperation);
                                },
                              ),
                            )
                          : Icon(
                              ShareAddLabelsIcon.icons[index],
                            ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          //Dropdown.
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                buttonDecoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                isExpanded: true,
                hint: Text(rules.first),
                value: selectedValue,
                items: rules
                    .map(
                      (items) => DropdownMenuItem<String>(
                        child: Text(items),
                        value: items,
                      ),
                    )
                    .toList(),
                onChanged: (value) async {
                  if (value!.contains('Only read')) {
                    setState(() {
                      selectedValue = value.toString();
                      valuesRules = Commands.ruleOnlyRead;
                    });
                  }

                  if (value.contains('Read and write')) {
                    setState(() {
                      selectedValue = value.toString();
                      valuesRules = Commands.ruleReadAndWrite;
                    });
                  }
                },
              ),
            ),
          ),
        ],
      ),

      //Button
      bottomSheet: ButtonBottomNavigator(
        icon: isLoading == true
            ? const Center(
                child: SizedBox(
                  width: 15,
                  height: 15,
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              )
            : const Icon(
                Icons.update,
                color: Colors.white,
                size: 32,
              ),
        onTap: isLoading == false
            ? () async {
                setState(() {
                  isLoading = true;
                });

                await cid.shareUpdate(
                    name: widget.folder!.name!,
                    path: widget.folder!.path!,
                    addUser: controller[2].text,
                    operation: commandOperation,
                    rule: valuesRules,
                    context: context);

                setState(() {
                  isLoading = false;
                });
              }
            : () {},
        text: "Update",
      ),
    );
  }
}
