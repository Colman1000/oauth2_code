import 'package:flutter/material.dart';

import '../auth_link.dart';
import '../widgets/in_app_web_view_handler.dart';
import 'oauth_client.dart';

class LinkedInOAuthClient extends OAuthClient {
  LinkedInOAuthClient(
    AuthLink authLink, {
    String? customScheme,
  }) : super(
          authLink,
          codeQueryParam: 'code',
          customScheme: customScheme,
        );

  @override
  @Deprecated("DO NOT USE - use `getAuthCode` instead")
  Future<String?> getAuthCode() async {
    throw "DO NOT USE - use `getAuthCode` instead";
  }

  @override
  Future<String?> getAuthCodeWithWebView(
    BuildContext context, {
    bool useVirtualDisplay = false,
    PreferredSizeWidget? appBar,
  }) async {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InAppWebViewHandler(
          authUrl: authLink.uri,
          codeQueryParam: codeQueryParam,
          useVirtualDisplay: useVirtualDisplay,
          appBar: appBar,
        ),
      ),
    );
  }
}
