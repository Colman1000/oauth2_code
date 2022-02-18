import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

import '../../veegil_oauth2.dart';
import '../auth_link.dart';

class GoogleOAuthClient extends OAuthClient {
  GoogleOAuthClient(
    AuthLink authLink, {
    String? customScheme,
  }) : super(
          authLink,
          codeQueryParam: 'code',
          customScheme: customScheme,
        );

  @override
  Future<String?> getAuthCode() async {
    final result = await FlutterWebAuth.authenticate(
      url: authLink.uri,
      callbackUrlScheme: customScheme ?? '',
      preferEphemeral: true,
    );

    // Extract code from resulting url
    return Uri.parse(result).queryParameters[codeQueryParam];
  }

  @override
  @Deprecated("DO NOT USE - use `getAuthCode` instead")
  Future<String?> getAuthCodeWithWebView(
    BuildContext context, {
    bool useVirtualDisplay = false,
    PreferredSizeWidget? appBar,
  }) async {
    throw "DO NOT USE - use `getAuthCode` instead";
  }
}
