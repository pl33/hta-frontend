/*
 * SPDX-License-Identifier: MPL-2.0
 *   Copyright (c) 2023 Philipp Le <philipp@philipple.de>.
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'dart:async';
import 'dart:convert';
import 'package:hta_api/api.dart' as api;
import 'package:flutter/material.dart';
import 'package:hta_frontend_flutter/entries_view.dart';
import 'package:openid_client/openid_client.dart' as oidc;
import 'connect_server_io.dart'
    if (dart.library.html) 'connect_server_browser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

/// Keeping track of the login status of the application
class LoginState with ChangeNotifier {
  /// Preference key for the serialized login credential structure
  static const String _prefsLoginCredential = "login_credential";

  /// Preference key for the server URL
  static const String _prefsServerUrl = "server_url";

  /// Requested OpenID Connect scopes
  static const _scopes = ['profile'];

  /// Server URL, null if no server is configured
  String? serverUrl;

  /// Login credential, null is app is not logged in
  oidc.Credential? credential;

  LoginState(this.serverUrl, this.credential);

  /// Create a new LoginState and load the preferences from the permanent
  /// configuration storage
  static Future<LoginState> getLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    final credString = prefs.getString(_prefsLoginCredential);
    final url = prefs.getString(_prefsServerUrl);
    if (credString == null) {
      return LoginState(url, await getBrowserRedirectCredential(_scopes));
    } else {
      try {
        final obj = jsonDecode(credString);
        final cred = oidc.Credential.fromJson(obj);
        return LoginState(url, cred);
      } on Exception {
        return LoginState(url, null);
      }
    }
  }

  /// Discover OpenID Connect information from the server
  Future<api.OidcInfo?> discover(String serverUrl) async {
    final client = api.ApiClient(basePath: serverUrl);
    final worker = api.LoginApi(client);
    final oidcInfo = await worker.oidcInfoGet();
    if (oidcInfo != null) {
      this.serverUrl = serverUrl;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefsServerUrl, serverUrl);

      return oidcInfo;
    } else {
      return null;
    }
  }

  /// Perform a login
  Future<void> login(api.OidcInfo oidcInfo) async {
    final discoveryUrl = Uri.parse(oidcInfo.discoveryUrl
        .replaceAll(".well-known/openid-configuration", ""));
    final oidcIssuer = await oidc.Issuer.discover(discoveryUrl);

    if (oidcInfo.clientId == null) {
      throw "No client ID provided by server.";
    }

    final client = oidc.Client(oidcIssuer, oidcInfo.clientId!,
        clientSecret: oidcInfo.clientSecret);
    final cred = await authenticate(client, scopes: _scopes);

    final prefs = await SharedPreferences.getInstance();
    final credJson = cred.toJson();
    final credString = jsonEncode(credJson);
    await prefs.setString(_prefsLoginCredential, credString);

    credential = cred;

    notifyListeners();
  }

  /// Check if app is logged in
  bool isLoggedIn() {
    return (credential != null) && (serverUrl != null);
  }

  /// Logout the application
  Future<void> logout() async {
    if (credential != null) {
      endSession(credential!, invalidate);
    }
  }

  /// Invalidate the credentials without logging out
  Future<void> invalidate() async {
    credential = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefsLoginCredential);

    notifyListeners();
  }

  /// Create an API client with the Authorization Bearer set
  Future<api.ApiClient> makeApiClient() async {
    if ((credential != null) && (serverUrl != null)) {
      final token = await credential!.getTokenResponse();
      final client = api.ApiClient(
          basePath: serverUrl!,
          authentication: api.OAuth(accessToken: token.accessToken!));
      return client;
    } else {
      throw "Must be logged in";
    }
  }
}

/// Page for connecting to a server and logging in
class ConnectServerPage extends StatefulWidget {
  final LoginState loginState;

  static const String route = "/login";

  const ConnectServerPage({required this.loginState, super.key});

  @override
  State<ConnectServerPage> createState() => _ConnectServerPageState();
}

/// State of the ConnectServerPage widget
class _ConnectServerPageState extends State<ConnectServerPage> {
  final _connectFormKey = GlobalKey<FormState>();

  String serverUrl = "";
  TextEditingController serverUrlController = TextEditingController();

  api.OidcInfo? oidcInfo;

  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadServerUrl();
  }

  /// Retrieve the last server URL
  Future<void> _loadServerUrl() async {
    final url = widget.loginState.serverUrl;
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
                        if (uri.scheme.isEmpty)
                          return "Please provide a scheme";
                        return null;
                      } on Exception {
                        return errorMessage;
                      }
                    },
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (!_connectFormKey.currentState!.validate()) return;

                      widget.loginState
                          .discover(serverUrl)
                          .then((configuration) => setState(() {
                                oidcInfo = configuration;
                                errorMessage = null;
                              }))
                          .onError((error, stackTrace) => setState(() {
                                errorMessage = (error as Exception).toString();
                                oidcInfo = null;
                              }));
                    },
                    icon: const Icon(Icons.wifi),
                    label: const Text("Connect"),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: oidcInfo != null,
              child: const Text(
                "Health Tracker Server successfully detected.",
              ),
            ),
            Visibility(
              visible: oidcInfo != null,
              child: ElevatedButton.icon(
                onPressed: () {
                  widget.loginState
                      .login(oidcInfo!)
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
