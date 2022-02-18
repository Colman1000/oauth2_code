import 'package:flutter/material.dart';

import '../auth_link.dart';

abstract class OAuthClient {
  const OAuthClient(
    this.authLink, {
    this.codeQueryParam = 'code',
    this.customScheme,
  });

  final AuthLink authLink;
  final String? customScheme;
  final String codeQueryParam;

  Future<String?> getAuthCode();

  Future<String?> getAuthCodeWithWebView(
    BuildContext context, {
    bool useVirtualDisplay = false,
    PreferredSizeWidget? appBar,
  });
}
