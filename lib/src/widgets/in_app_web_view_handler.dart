import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Class will fetch code from the user
/// It will show web view so that user can access the auth page.
@immutable
class InAppWebViewHandler extends StatefulWidget {
  const InAppWebViewHandler({
    Key? key,
    required this.authUrl,
    this.codeQueryParam = 'code',
    this.appBar,
    this.useVirtualDisplay = false,
  }) : super(key: key);

  final String authUrl;
  final String codeQueryParam;
  final PreferredSizeWidget? appBar;
  final bool useVirtualDisplay;

  @override
  State createState() => _InAppWebViewHandlerState();
}

class _InAppWebViewHandlerState extends State<InAppWebViewHandler> {
  WebViewController? webViewController;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid && widget.useVirtualDisplay) {
      WebView.platform = AndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: Builder(
        builder: (BuildContext context) {
          return SafeArea(
            child: WebView(
              initialUrl: widget.authUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController controller) async {
                webViewController = controller;
              },
              navigationDelegate: (NavigationRequest request) async {
                final _code = Uri.parse(request.url)
                    .queryParameters[widget.codeQueryParam];

                if (_code != null && _code.isNotEmpty) {
                  NavigationDecision.prevent;
                  Navigator.of(context).pop(_code);
                }

                return NavigationDecision.navigate;
              },
              gestureNavigationEnabled: false,
            ),
          );
        },
      ),
    );
  }
}
