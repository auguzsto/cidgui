import 'package:cidgui/src/components/suffixicon_label.dart';
import 'package:cidgui/src/constants/helps_dialogs.dart';
import 'package:cidgui/src/constants/labels_icons.dart';
import 'package:cidgui/src/controllers/cid_controller.dart';
import 'package:cidgui/src/pages/share_add/sharedadd_page.dart';
import 'package:flutter/material.dart';

class LeaveDomainPage extends StatefulWidget {
  LeaveDomainPage({super.key});

  @override
  State<LeaveDomainPage> createState() => _LeaveDomainPageState();
}

class _LeaveDomainPageState extends State<LeaveDomainPage> {
  List labels = [
    'Admin Account',
    'Password',
  ];

  List<TextEditingController> controller = [
    TextEditingController(),
    TextEditingController(),
  ];

  final cid = CidController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leave domain"),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Icon(
                Icons.exit_to_app,
                color: Colors.blue,
                size: 150,
              ),
            ),

            //Labels
            Column(
              children: List.generate(
                labels.length,
                (index) => Container(
                  margin: const EdgeInsets.all(5),
                  child: TextFormField(
                    controller: controller[index],
                    obscureText: index == 1 ? true : false,
                    decoration: InputDecoration(
                        suffixIcon: SuffixIconLabel(
                          title: labels[index],
                          content: HelpsDialogs.contentLeaveDomainPage[index],
                          icon: LeaveDomainLabelsIcon.icons[index],
                        ),
                        labelText: labels[index],
                        prefixIcon: Icon(
                          LeaveDomainLabelsIcon.icons[index],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                  ),
                ),
              ),
            ),

            //Button
            Container(
              padding: const EdgeInsets.all(5.0),
              height: 65,
              child: ElevatedButton.icon(
                onPressed: () async {
                  if (controller[0].text.isNotEmpty ||
                      controller[1].text.isNotEmpty) {
                    setState(() {
                      isLoading = true;
                    });

                    await cid.leaveDomain(
                        controller[0].text, controller[1].text, context);

                    setState(() {
                      isLoading = false;
                    });
                  }

                  if (context.mounted) {
                    handlers.message(
                      context: context,
                      message: "Fill in all fields.",
                      isError: true,
                    );
                  }
                },
                icon: isLoading == true
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : const Icon(Icons.exit_to_app),
                label: isLoading == true ? const Text("") : const Text("Leave"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
