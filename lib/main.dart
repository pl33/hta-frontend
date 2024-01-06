// Openapi Generator last run: : 2023-11-21T00:24:20.705639
/*
 * SPDX-License-Identifier: MPL-2.0
 *   Copyright (c) 2023 Philipp Le <philipp@philipple.de>.
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hta_api/api.dart';
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

import 'connect_server.dart';
import 'categories_proxy.dart';
import 'categories_view.dart';
import 'entries_view.dart';

void main() {
  runApp(const HtaApp());
}

AboutListTile makeAboutTile() {
  return const AboutListTile(
    icon: Icon(Icons.info_outline),
    applicationName: "Health Tracker App",
    applicationVersion: "1.0.0",
    applicationLegalese: "\u{a9} 2023-2024 Philipp Le"
        "\nThis Covered Software is subject to the terms of the Mozilla Public"
        "\nLicense, v. 2.0. If a copy of the MPL was not distributed with this"
        "\nfile, You can obtain one at https://mozilla.org/MPL/2.0/.",
    aboutBoxChildren: [
      Text("App to track health data and vital parameters.")
    ],
  );
}

/// Storage for the global app state
class GlobalAppState {
  /// Login state
  @protected
  LoginState? _loginState;

  /// API client
  ApiClient? apiClient;

  /// Completer to wait until controllers are initialized
  ValueNotifier<bool> loginStateValue = ValueNotifier<bool>(false);

  /// Categories proxy
  CategoriesProxy? categoriesProxy;

  /// Entries controller
  EntriesViewController? entriesViewController;

  /// This function can be called once to set a new login state
  Future<void> initializeLoginState(LoginState state) async {
    if (_loginState != null) {
      throw "It is illegal to overwrite an existing login state";
    }

    _loginState = state;
    await _initializeControllers();
    _loginState!.addListener(() {
      _initializeControllers();
    });
  }

  /// Initialize global controllers depending on the login state
  @protected
  Future<void> _initializeControllers() async {
    if (_loginState != null) {
      if (_loginState!.isLoggedIn()) {
        apiClient = await _loginState!.makeApiClient();
        categoriesProxy = CategoriesProxy(client: apiClient);
        await categoriesProxy!.reloadAll();
        entriesViewController = EntriesViewController(client: apiClient!);
        loginStateValue.value = true;
      } else {
        apiClient = null;
        categoriesProxy = null;
        entriesViewController = null;
        loginStateValue.value = false;
      }
    }
  }

  /// Check if login state instance is valid
  bool hasLoginState() {
    return _loginState != null;
  }

  /// Check if state is usable for logged in state
  bool isLoggedIn() {
    return loginStateValue.value;
  }

  /// Make the default drawer with login-dependent information
  Drawer makeDefaultDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              "Health Tracker App",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.monitor_heart_rounded),
            title: const Text("Health Entries"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(EntriesPage.route);
            },
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text("Categories"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(CategoriesPage.route);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              _loginState?.logout();
              Navigator.of(context).pushReplacementNamed(ConnectServerPage.route);
            },
          ),
          const Divider(),
          makeAboutTile(),
        ],
      )
    );
  }
}

/// The app entry widget
@Openapi(
  additionalProperties:
  AdditionalProperties(pubName: 'hta_api', pubAuthor: 'Philipp Le'),
  inputSpecFile: 'backend/swagger.yaml',
  generatorName: Generator.dart,
  outputDirectory: 'api/hta_api',
)
class HtaApp extends StatefulWidget {
  const HtaApp({super.key});

  @override
  State<HtaApp> createState() => _HtaAppState();
}

/// State of the app widget
class _HtaAppState extends State<HtaApp> {
  final appState = GlobalAppState();

  /// Handles login state changes
  void _onLoginStateChangeCb() {
    setState(() { });
  }

  @override
  void initState() {
    super.initState();

    LoginState.getLoginState().then((state) {
      setState(() {
        appState.initializeLoginState(state).then((value) {
          appState.loginStateValue.addListener(_onLoginStateChangeCb);
          setState(() {});
        },
        );
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    appState.loginStateValue.removeListener(_onLoginStateChangeCb);
  }

  @override
  Widget build(BuildContext context) {
    if (!appState.hasLoginState()) {
      return MaterialApp(
        title: 'Health Tracker App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Center(
          child: Column(
            children: [
              CircularProgressIndicator(),
              Text("Initializing ..."),
            ],
          ),
        )
      );
    } else {
      return MaterialApp(
        title: 'Health Tracker App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: appState.isLoggedIn() ? EntriesPage(appState: appState) : ConnectServerPage(loginState: appState._loginState!),
        initialRoute: appState.isLoggedIn() ? EntriesPage.route : ConnectServerPage.route,
        routes: {
          ConnectServerPage.route: (context) => ConnectServerPage(loginState: appState._loginState!),
          EntriesPage.route: (context) => EntriesPage(appState: appState),
          CategoriesPage.route: (context) => CategoriesPage(appState: appState),
        },
      );
    }
  }
}
