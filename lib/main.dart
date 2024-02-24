// Openapi Generator last run: : 2023-11-21T00:24:20.705639
/*
 * SPDX-License-Identifier: MPL-2.0
 *   Copyright (c) 2023 Philipp Le <philipp@philipple.de>.
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

import 'connect_server.dart';
import 'categories_view.dart';
import 'entries_view.dart';
import 'app_login_state.dart';

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
  void _onAppStateChangeCb() {
    setState(() { });
  }

  @override
  void initState() {
    super.initState();
    appState.addListener(_onAppStateChangeCb);
  }

  @override
  void dispose() {
    super.dispose();
    appState.removeListener(_onAppStateChangeCb);
  }

  @override
  Widget build(BuildContext context) {
    if (!appState.isInitialized()) {
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
        home: appState.isLoggedIn() ? EntriesPage(appState: appState) : ConnectServerPage(appState: appState),
        initialRoute: appState.isLoggedIn() ? EntriesPage.route : ConnectServerPage.route,
        routes: {
          ConnectServerPage.route: (context) => ConnectServerPage(appState: appState),
          EntriesPage.route: (context) => EntriesPage(appState: appState),
          CategoriesPage.route: (context) => CategoriesPage(appState: appState),
        },
      );
    }
  }
}

/// Make the default drawer with login-dependent information
Drawer makeDefaultDrawer(BuildContext context, GlobalAppState appState) {
  return Drawer(
    child: Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Health Tracker App",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          appState.loginName() ?? "",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        onDoubleTap: () {
                          Navigator.of(context).pop();

                          final date = appState.loginExpiration();
                          if (date != null) {
                            final serverUrl = appState.serverUrl;
                            final dateStr = DateFormat.yMMMd().format(date);
                            final timeStr = DateFormat.Hms().format(date);
                            final snackbar = SnackBar(content: Text(
                                "Logged in to \"$serverUrl\". Login expires on $dateStr at $timeStr"
                            ));
                            ScaffoldMessenger.of(context).showSnackBar(
                                snackbar);
                          }
                        },
                      )
                    ],
                  )
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
                  appState.logout();
                  Navigator.of(context).pushReplacementNamed(ConnectServerPage.route);
                },
              ),
              const Divider(),
              makeAboutTile(),
            ],
          ),
        ),
      ],
    )
  );
}
