import 'package:cidgui/src/controllers/cid_controller.dart';
import 'package:cidgui/src/handlers/messages_handlers.dart';
import 'package:flutter/material.dart';

class JoinDomainPage extends StatefulWidget {
  const JoinDomainPage({super.key});

  @override
  State<JoinDomainPage> createState() => _JoinDomainPageState();
}

List labels = [
  'Domain name (FQDN)',
  'Admin Account',
  'Password',
];

List<TextEditingController> controller = [
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
];

final cid = CidController();
final handlers = MessagesHandlers();
bool isLoading = false;

class _JoinDomainPageState extends State<JoinDomainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter in Active Directory"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(
            child: Icon(
              Icons.domain,
              size: 150,
              color: Colors.blue,
            ),
          ),

          //Labels
          Column(
            children: List.generate(
              labels.length,
              (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controller[index],
                    obscureText: index == 2 ? true : false,
                    decoration: InputDecoration(
                      labelText: labels[index],
                      prefixIcon: index == 0
                          ? const Icon(Icons.domain)
                          : index == 1
                              ? const Icon(Icons.person)
                              : const Icon(Icons.key),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          //Button
          Container(
            padding: const EdgeInsets.all(5.0),
            height: 65,
            child: ElevatedButton.icon(
              onPressed: () async {
                if (controller[0].text.isEmpty ||
                    controller[1].text.isEmpty ||
                    controller[2].text.isEmpty) {
                  handlers.message(
                      context: context, message: "Fill in all fields.", isError: true);
                  return;
                }
                setState(() {
                  isLoading = true;
                });

                await cid.enterDomain(controller[0].text, controller[1].text,
                    controller[2].text, context);

                setState(() {
                  isLoading = false;
                });
              },
              icon: isLoading == true
                  ? const SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.domain_add),
              label: isLoading == true ? const Text("") : const Text("Enter"),
            ),
          )
        ],
      ),
    );
  }
}
