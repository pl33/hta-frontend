/*
 * SPDX-License-Identifier: MPL-2.0
 *   Copyright (c) 2023 Philipp Le <philipp@philipple.de>.
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:openid_client/openid_client.dart' as oidc;
import 'package:openid_client/openid_client_browser.dart' as oidc_browser;

const String _prefsLoginClient = "login_client";

Future<oidc.Credential?> getBrowserRedirectCredential(Iterable<String> scopes) async {
  //final prefs = await SharedPreferences.getInstance();
  //final clientStr = prefs.getString(_prefsLoginClient);
  if (!kIsWeb) {
    throw "Only supported in web applications";
  }
  final clientStr = html.window.localStorage[_prefsLoginClient];
  if (clientStr != null) {
    //await prefs.remove(_prefsLoginClient);
    html.window.localStorage.remove(_prefsLoginClient);

    final clientJson = jsonDecode(clientStr);
    final client = oidc.Client(
      oidc.Issuer(
          oidc.OpenIdProviderMetadata.fromJson(
              Map.from(clientJson["issuer"]["metadata"])),
          claimsMap: Map.from(clientJson["issuer"]["claims"])),
      clientJson["client_id"],
      clientSecret: clientJson["client_secret"],
    );

    final auth = oidc_browser.Authenticator(client, scopes: scopes);
    final cred = await auth.credential;

    return cred;
  } else {
    return null;
  }
}

Future<oidc.Credential> authenticate(oidc.Client client,
    {List<String> scopes = const []}) async {
  if (!kIsWeb) {
    throw "Only supported in web applications";
  }

  final Map<String, dynamic> clientJson = {
    "issuer": {
      "metadata": client.issuer.metadata.toJson(),
      "claims": client.issuer.claimsMap,
    },
    "client_id": client.clientId,
    "client_secret": client.clientSecret,
  };
  final clientStr = jsonEncode(clientJson);
  //final prefs = await SharedPreferences.getInstance();
  //await prefs.setString(_prefsLoginClient, clientStr);
  html.window.localStorage[_prefsLoginClient] = clientStr;

  var authenticator = oidc_browser.Authenticator(client, scopes: scopes);
  authenticator.authorize();
  // Should not reach here
  return Completer<oidc.Credential>().future;
}

Future<void> endSession(oidc.Credential credential, Future<void> Function() invalidate) async {
  if (!kIsWeb) {
    throw "Only supported in web applications";
  }

  final auth = oidc_browser.Authenticator(credential.client);
  await invalidate();
  auth.logout();
}
