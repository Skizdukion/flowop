import 'dart:io';
import 'dart:typed_data';

import 'package:flowop/logic/repositories/patient_repositories.dart';
import 'package:flowop/views/widgets/app_bar.dart';
import 'package:flowop/views/widgets/custom_textfield/configs/textfield_config.dart';
import 'package:flowop/views/widgets/custom_textfield/shadow_textfield.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ServerConnector extends StatefulWidget {
  const ServerConnector({Key? key}) : super(key: key);

  @override
  _ServerConnectorState createState() => _ServerConnectorState();
}

class _ServerConnectorState extends State<ServerConnector> {
  TextEditingController portController = TextEditingController();
  TextEditingController hostController = TextEditingController();
  // bool isConnecting = false;
  BehaviorSubject<bool> isConnecting = BehaviorSubject.seeded(false);
  // BehaviorSubject<String> error = BehaviorSubject.seeded('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar.lightAppBar(
        titleString: "Server Connector",
        context: context,
        showBack: true,
      ),
      body: StreamBuilder<bool>(
          stream: isConnecting,
          builder: (context, snapshot) {
            if (isConnecting.value == false) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text('Server host'),
                    ),
                    ShadowTextField(
                        textFieldType: TextFieldType.text,
                        textFieldConfig:
                            TextFieldConfig(controller: hostController)),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      child: Text('Server host'),
                    ),
                    ShadowTextField(
                        textFieldType: TextFieldType.number,
                        textFieldConfig:
                            TextFieldConfig(controller: portController)),
                    Center(
                      child: ElevatedButton(
                          onPressed: () {
                            if (hostController.text.isNotEmpty &&
                                portController.text.isNotEmpty) {
                              isConnecting.add(true);
                              Socket.connect(hostController.text,
                                      int.parse(portController.text))
                                  .then((value) {
                                isConnecting.add(false);
                                Navigator.pop(context, true);
                                FirebasePatientRepository.serversocket = value;
                              }).onError((error, stackTrace) {
                                isConnecting.add(false);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      'Etablish connection failed: $error'),
                                ));
                              });
                            }
                          },
                          child: const Text('Connect')),
                    ),
                  ],
                ),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('Etablishing connection, please wait'),
                  ),
                  CircularProgressIndicator(),
                ],
              );
            }
          }),
    );
  }
}
