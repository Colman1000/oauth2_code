import './x_platform/xplatform.dart';

class AuthLink {
  AuthLink({
    String androidClientID = '',
    String iOSClientID = '',
    String webClientID = '',
    String androidRedirectUri = '',
    String iOSRedirectUri = '',
    String webRedirectUri = '',
    String baseUri = '',
    String scope = '',
    this.overrideUri,
  })  : _androidClientID = androidClientID,
        _iOSClientID = iOSClientID,
        _webClientID = webClientID,
        _androidRedirectUri = androidRedirectUri,
        _iOSRedirectUri = iOSRedirectUri,
        _webRedirectUri = webRedirectUri,
        _baseUri = baseUri,
        _scope = scope;

  final String _androidClientID;
  final String _iOSClientID;
  final String _webClientID;

  final String _androidRedirectUri;
  final String _iOSRedirectUri;
  final String _webRedirectUri;

  final String _baseUri;
  final String _scope;

  final String Function(
    String baseUri,
    String clientID,
    String redirectUri,
    String scope,
  )? overrideUri;

  String get uri =>
      overrideUri?.call(_baseUri, clientID, redirectUri, _scope) ??
      "$_baseUri?redirect_uri=$redirectUri&client_id=$clientID&scope=$_scope&prompt=consent&response_type=code&access_type=offline&code_challenge=challenge&code_challenge_method=plain";

  String get clientID => XPlatform.isAndroid
      ? _androidClientID
      : XPlatform.isIOS
          ? _iOSClientID
          : _webClientID;

  String get redirectUri => XPlatform.isAndroid
      ? _androidRedirectUri
      : XPlatform.isIOS
          ? _iOSRedirectUri
          : _webRedirectUri;
}
