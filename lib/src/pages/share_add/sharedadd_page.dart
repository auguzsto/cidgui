import 'package:cidgui/src/components/suffixicon_label.dart';
import 'package:cidgui/src/constants/commands.dart';
import 'package:cidgui/src/constants/helps_dialogs.dart';
import 'package:cidgui/src/constants/labels_icons.dart';
import 'package:cidgui/src/controllers/cid_controller.dart';
import 'package:cidgui/src/handlers/messages_handlers.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class AddSharedFolder extends StatefulWidget {
  const AddSharedFolder({super.key});

  @override
  State<AddSharedFolder> createState() => _AddSharedFolderState();
}

List labels = [
  'Shared name',
  'Path',
  'User (Optional)',
  'Group (Optional)',
];

List<String> rules = [
  'Only read',
  'Read and write',
];

String? valuesRules;

String? selectedValue;

List<TextEditingController> controllers = [
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
];
final cid = CidController();
final handlers = MessagesHandlers();
bool isLoading = false;

class _AddSharedFolderState extends State<AddSharedFolder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shared folder"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: const [
                Icon(
                  Icons.folder,
                  size: 150,
                  color: Colors.blue,
                ),
              ],
            ),

            //Labels
            Column(
              children: List.generate(
                labels.length,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: controllers[index],
                      decoration: InputDecoration(
                        suffixIcon: SuffixIconLabel(
                          title: labels[index],
                          content: HelpsDialogs.contentShareAddPage[index],
                          icon: ShareAddLabelsIcon.icons[index],
                        ),
                        labelText: labels[index],
                        prefixIcon: Icon(ShareAddLabelsIcon.icons[index]),
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

            //Button
            Container(
              padding: const EdgeInsets.all(5.0),
              height: 65,
              child: ElevatedButton.icon(
                onPressed: () async {
                  List.generate(
                    1,
                    (index) async {
                      //Message error labels emptys.
                      if (controllers[0].text.isEmpty ||
                          controllers[1].text.isEmpty) {
                        //Snackbar error.
                        return handlers.message(
                            context: context,
                            message: "Fill in all fields.",
                            isError: true);
                      }
                      setState(() {
                        isLoading = true;
                      });

                      await cid.shareAdd(
                          name: controllers[0].text,
                          path: controllers[1].text,
                          addUser: controllers[2].text,
                          addGroup: controllers[3].text,
                          rule: valuesRules,
                          context: context);

                      setState(() {
                        isLoading = false;
                      });
                    },
                  );
                },
                icon: isLoading == true
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.add_task),
                label:
                    isLoading == true ? const Text("") : const Text("Shared"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
