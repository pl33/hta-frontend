/*
 * SPDX-License-Identifier: MPL-2.0
 *   Copyright (c) 2023 Philipp Le <philipp@philipple.de>.
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hta_frontend_flutter/entries_view.dart';

import 'main.dart';
import 'app_login_state.dart';

/// Page for connecting to a server and logging in
class ConnectServerPage extends StatefulWidget {
  final GlobalAppState appState;

  static const String route = "/login";

  const ConnectServerPage({required this.appState, super.key});

  @override
  State<ConnectServerPage> createState() => _ConnectServerPageState();
}

/// State of the ConnectServerPage widget
class _ConnectServerPageState extends State<ConnectServerPage> {
  final _connectFormKey = GlobalKey<FormState>();

  String serverUrl = "";
  TextEditingController serverUrlController = TextEditingController();

  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadServerUrl();
  }

  /// Retrieve the last server URL
  Future<void> _loadServerUrl() async {
    final url = widget.appState.serverUrl;
    setState(() {
      serverUrl = url ?? "";
      serverUrlController.text = serverUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connect to Server"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            makeAboutTile(),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Form(
              key: _connectFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: "Server URL",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.url,
                    controller: serverUrlController,
                    onChanged: (value) => serverUrl = value,
                    validator: (value) {
                      const errorMessage = "Please enter a valid server URL";
                      if (value == null || value.isEmpty) return errorMessage;
                      try {
                        final uri = Uri.parse(value);
                        if (uri.scheme.isEmpty) {
                          return "Please provide a scheme";
                        }
                        return null;
                      } on Exception {
                        return errorMessage;
                      }
                    },
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (!_connectFormKey.currentState!.validate()) return;

                      widget.appState
                          .discover(serverUrl)
                          .then((configuration) => setState(() {
                                errorMessage = null;
                              }))
                          .onError((error, stackTrace) => setState(() {
                                errorMessage = (error as Exception).toString();
                              }));
                    },
                    icon: const Icon(Icons.wifi),
                    label: const Text("Connect"),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: widget.appState.isAssociated(),
              child: const Text(
                "Health Tracker Server successfully detected.",
              ),
            ),
            Visibility(
              visible: widget.appState.isAssociated(),
              child: ElevatedButton.icon(
                onPressed: () {
                  widget.appState
                      .login()
                      .then(
                        (value) => setState(() {
                          errorMessage = null;
                          Navigator.of(context).pushReplacementNamed(EntriesPage.route);
                        }),
                      )
                      .onError((error, stackTrace) => setState(() {
                            errorMessage = (error as Exception).toString();
                          }));
                },
                icon: const Icon(Icons.login),
                label: const Text("Login"),
              ),
            ),
            Visibility(
              visible: errorMessage != null,
              child: Text(
                errorMessage ?? "",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
