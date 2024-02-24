/*
 * SPDX-License-Identifier: MPL-2.0
 *   Copyright (c) 2024 Philipp Le <philipp@philipple.de>.
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
import 'categories_proxy.dart';


/// Preference key for the serialized login credential structure
const String _prefsLoginCredential = "login_credential";

/// Preference key for the server URL
const String _prefsServerUrl = "server_url";

/// Requested OpenID Connect scopes
const _scopes = ['profile'];

/// Application State Machine
sealed class AppLoginState {}

/// Application State: Uninitialized
class AppLoginUninitialized extends AppLoginState {
  /// Create a new Login State and load the preferences from the permanent
  /// configuration storage
  Future<AppLoginState> loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final serverUrl = prefs.getString(_prefsServerUrl);
    if (serverUrl == null) {
      // Uninitialized - no server URL configured
      return AppLoginNotAssociated();
    } else {
      final credString = prefs.getString(_prefsLoginCredential);
      if (credString == null) {
        // Try to get from browser; always return null if not running in web
        final browserCred = await getBrowserRedirectCredential(_scopes);
        if (browserCred == null) {
          // Is logged out
          return AppLoginLoggedOut.tryDiscover(serverUrl);
        } else {
          // Is logged in
          return AppLoginLoggedIn.make(serverUrl, browserCred);
        }
      } else {
        try {
          final obj = jsonDecode(credString);
          final cred = oidc.Credential.fromJson(obj);
          return AppLoginLoggedIn.make(serverUrl, cred);
        } on Exception {
          return AppLoginLoggedOut.tryDiscover(serverUrl);
        }
      }
    }
  }
}

/// Application State: Not associated to any server
class AppLoginNotAssociated extends AppLoginState {
  /// Discover OpenID Connect information from the server
  Future<AppLoginState> discover(String serverUrl) async {
    return AppLoginLoggedOut.tryDiscover(serverUrl);
  }
}

/// Application State: Is logged out
class AppLoginLoggedOut extends AppLoginState {
  /// Server URL
  String serverUrl;

  /// OpenID Connect information
  api.OidcInfo oidcInfo;

  @protected
  AppLoginLoggedOut({required this.serverUrl, required this.oidcInfo});

  /// Discover OpenID Connect information from the server
  static Future<AppLoginState> tryDiscover(String serverUrl) async {
    final client = api.ApiClient(basePath: serverUrl);
    final worker = api.LoginApi(client);
    final oidcInfo = await worker.oidcInfoGet();
    if (oidcInfo != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefsServerUrl, serverUrl);
      return AppLoginLoggedOut(serverUrl: serverUrl, oidcInfo: oidcInfo);
    } else {
      return AppLoginNotAssociated();
    }
  }

  /// Discover OpenID Connect information from the server
  Future<AppLoginState> discover(String serverUrl) async {
    return AppLoginLoggedOut.tryDiscover(serverUrl);
  }

  /// Perform a login
  Future<AppLoginState> login() async {
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

    return AppLoginLoggedIn.make(serverUrl, cred);
  }
}

/// Application State: Is logged in
class AppLoginLoggedIn extends AppLoginState {
  /// Server URL
  String serverUrl;

  /// Login credential, null is app is not logged in
  oidc.Credential credential;

  /// API client
  api.ApiClient apiClient;

  /// Categories proxy
  CategoriesProxy categoriesProxy;

  /// Entries controller
  EntriesViewController entriesViewController;

  @protected
  AppLoginLoggedIn({required this.serverUrl, required this.credential, required this.apiClient, required this.categoriesProxy, required this.entriesViewController});

  /// Create an API client with the Authorization Bearer set
  @protected
  static Future<api.ApiClient> makeApiClient(String serverUrl, oidc.Credential credential) async {
    final token = await credential.getTokenResponse();
    final client = api.ApiClient(
        basePath: serverUrl,
        authentication: api.OAuth(accessToken: token.accessToken!));
    return client;
  }

  /// Create the state and all controllers
  static Future<AppLoginLoggedIn> make(String serverUrl, oidc.Credential credential) async {
    final apiClient = await makeApiClient(serverUrl, credential);
    final categoriesProxy = CategoriesProxy(client: apiClient);
    await categoriesProxy.reloadAll();
    final entriesViewController = EntriesViewController(client: apiClient);
    return AppLoginLoggedIn(
        serverUrl: serverUrl,
        credential: credential,
        apiClient: apiClient,
        categoriesProxy: categoriesProxy,
        entriesViewController: entriesViewController
    );
  }

  /// Logout the application
  Future<AppLoginState> logout() async {
    endSession(credential, () async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_prefsLoginCredential);
    });
    return AppLoginLoggedOut.tryDiscover(serverUrl);
  }
}

/// Storage for the global app state
class GlobalAppState {
  /// Completer to wait until controllers are initialized
  ValueNotifier<AppLoginState> loginState = ValueNotifier<AppLoginState>(AppLoginUninitialized());

  GlobalAppState() {
    AppLoginUninitialized().loadState().then((value) {
      loginState.value = value;
    });
  }

  /// Discover OpenID Connect information from the server
  Future<void> discover(String serverUrl) async {
    AppLoginState tmpState = loginState.value;
    switch (tmpState) {
      case AppLoginUninitialized():
        throw "Invalid login state: uninitialized";
      case AppLoginNotAssociated():
        loginState.value = await tmpState.discover(serverUrl);
      case AppLoginLoggedOut():
        loginState.value = await tmpState.discover(serverUrl);
      case AppLoginLoggedIn():
        throw "Invalid login state: logged in";
    }
  }

  /// Perform a login
  Future<void> login() async {
    AppLoginState tmpState = loginState.value;
    switch (tmpState) {
      case AppLoginUninitialized():
        throw "Invalid login state: uninitialized";
      case AppLoginNotAssociated():
        throw "Invalid login state: not associated";
      case AppLoginLoggedOut():
        loginState.value = await tmpState.login();
      case AppLoginLoggedIn():
        throw "Invalid login state: logged in";
    }
  }

  /// Logout the application
  Future<void> logout() async {
    AppLoginState tmpState = loginState.value;
    switch (tmpState) {
      case AppLoginUninitialized():
        throw "Invalid login state: uninitialized";
      case AppLoginNotAssociated():
        throw "Invalid login state: not associated";
      case AppLoginLoggedOut():
        throw "Invalid login state: logged out";
      case AppLoginLoggedIn():
        loginState.value = await tmpState.logout();
    }
  }

  /// Logout the application
  String? get serverUrl {
    AppLoginState tmpState = loginState.value;
    return switch (tmpState) {
      AppLoginUninitialized() => null,
      AppLoginNotAssociated() => null,
      AppLoginLoggedOut() => tmpState.serverUrl,
      AppLoginLoggedIn() => tmpState.serverUrl,
    };
  }

  /// Add listener for state changes
  void addListener(void Function() listener) {
    loginState.addListener(listener);
  }

  /// Remove listener for state changes
  void removeListener(void Function() listener) {
    loginState.removeListener(listener);
  }

  /// Check if login state instance is valid
  bool isInitialized() {
    return loginState.value is! AppLoginUninitialized;
  }

  /// Check if app is associated to a server
  bool isAssociated() {
    AppLoginState tmpState = loginState.value;
    return switch (tmpState) {
      AppLoginUninitialized() => false,
      AppLoginNotAssociated() => false,
      AppLoginLoggedOut() => true,
      AppLoginLoggedIn() => true,
    };
  }

  /// Check if state is usable for logged in state
  bool isLoggedIn() {
    return loginState.value is AppLoginLoggedIn;
  }

  /// Get login info if logged in or null
  AppLoginLoggedIn? loginInfo() {
    AppLoginState tmpState = loginState.value;
    return switch (tmpState) {
      AppLoginUninitialized() => null,
      AppLoginNotAssociated() => null,
      AppLoginLoggedOut() => null,
      AppLoginLoggedIn() => tmpState,
    };
  }

  /// Get name of logged in user if logged in or null
  String? loginName() {
    AppLoginState tmpState = loginState.value;
    return switch (tmpState) {
      AppLoginUninitialized() => null,
      AppLoginNotAssociated() => null,
      AppLoginLoggedOut() => null,
      AppLoginLoggedIn() => tmpState.credential.idToken.claims.name,
    };
  }

  /// Get expiration time of login if logged in or null
  DateTime? loginExpiration() {
    AppLoginState tmpState = loginState.value;
    return switch (tmpState) {
      AppLoginUninitialized() => null,
      AppLoginNotAssociated() => null,
      AppLoginLoggedOut() => null,
      AppLoginLoggedIn() => tmpState.credential.idToken.claims.expiry,
    };
  }
}

