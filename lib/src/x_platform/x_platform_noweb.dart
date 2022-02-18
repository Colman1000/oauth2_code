import 'dart:io';

import 'x_platform_stub.dart';

class XPlatform implements XPlatformStub {
  static bool isAndroid = Platform.isAndroid;

  static bool isIOS = Platform.isIOS;

  static bool isWeb = false;
}
