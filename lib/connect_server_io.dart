/*
 * SPDX-License-Identifier: MPL-2.0
 *   Copyright (c) 2023 Philipp Le <philipp@philipple.de>.
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'dart:async';
import 'dart:io' as io;
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:openid_client/openid_client.dart' as oidc;
import 'package:openid_client/openid_client_io.dart' as oidc_io;
import 'package:url_launcher/url_launcher.dart';

Future<oidc.Credential?> getBrowserRedirectCredential(Iterable<String> scopes) async {
  if (kIsWeb) {
    throw "Only supported in non-web applications";
  }
  return null;
}

Future<void> _openWeb(Uri uri) async {
  if (await canLaunchUrl(uri) || io.Platform.isAndroid) {
    LaunchMode mode;
    if (io.Platform.isAndroid || io.Platform.isIOS) {
      mode = LaunchMode.inAppWebView;
    } else if (io.Platform.isWindows || io.Platform.isLinux || io.Platform.isMacOS) {
      mode = LaunchMode.externalApplication;
    } else {
      mode = LaunchMode.platformDefault;
    }
    await launchUrl(uri, mode: mode);
  } else {
    throw "Could not launch $uri";
  }
}

Future<void> _closeWeb() async {
  try {
    await closeInAppWebView();
  } on UnimplementedError {
    // Ignore
  }
}

Future<oidc.Credential> authenticate(oidc.Client client,
    {List<String> scopes = const []}) async {
  if (kIsWeb) {
    throw "Only supported in non-web applications";
  }

  final auth = oidc_io.Authenticator(
      client,
      scopes: scopes,
      port: 4000,
      urlLancher: (String url) async {
        final uri = Uri.parse(url);
        await _openWeb(uri);
      }
  );

  // starts the authentication, open in browser
  var cred = await auth.authorize();

  // close the webview when finished
  await _closeWeb();

  return cred;
}

String _randomString(int length) {
  var r = Random.secure();
  var chars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
  return Iterable.generate(length, (_) => chars[r.nextInt(chars.length)])
      .join();
}

Future<io.HttpServer> _startServer(
    Completer completer, String state, int port, String? htmlPage, String? redirectMessage) {
  return (io.HttpServer.bind(io.InternetAddress.anyIPv4, port)
    ..then((requestServer) async {
      await for (var request in requestServer) {
        request.response.statusCode = 200;
        if (redirectMessage != null) {
          request.response.headers.contentType = io.ContentType.html;
          request.response.writeln(htmlPage ??
              '<html>'
                  '<h1>$redirectMessage</h1>'
                  '<script>window.close();</script>'
                  '</html>');
        }
        await request.response.close();
        var result = request.requestedUri.queryParameters;

        if (!result.containsKey('state')) continue;
        if (result['state'] != state) continue;
        completer.complete();
      }
    }));
}

Future<void> endSession(oidc.Credential credential, Future<void> Function() invalidate) async {
  if (kIsWeb) {
    throw "Only supported in non-web applications";
  }

  final state = _randomString(20);
  const port = 3001;
  final logoutUri = credential.generateLogoutUrl(
      redirectUri: Uri.parse('http://localhost:$port/'),
      state: state
  );
  if (logoutUri == null) {
    throw "Logout is not supported";
  }

  await invalidate();

  final completer = Completer();
  await _startServer(completer, state, port, null, "You can now close this window");
  await _openWeb(logoutUri);
  await completer.future;

  _closeWeb();
}
