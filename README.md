<h1 align="center">OAuth2 Code</h1>


## Features

An OAuth2 that gets and returns the auth code for Google, Facebook, LinkedIn and Twitter implemented
for [Veegil](https://veegil.com). The low level implementation is based on
the [flutter_web_auth](https://pub.dev/packages/flutter_web_auth) package.


It also provides some social UI buttons for use within your app.

<br>
![Image](https://github.com/Colman1000/veegil_oauth2/blob/main/lib/images/phone_screen.png)

-----

## Getting started

Add the dependency in pubsec.yaml file.

```yaml
dart
  dependencies:
    flutter:
      sdk: flutter
    oauth2_code: any
```

## Usage

To authenticate a user using your custom client:

```dart
import 'package:oauth2_code/veegil_oauth2.dart';

/// Create your custom client 

/// Use the [getAuthCode] if you provider supports customSchemes for example `com.example.app://auth`
/// If not, you'd want to implement the [getAuthCodeWithWebView] and intercept the code manually
/// 
class MyCustomOAuthClient extends OAuthClient {
  MyCustomOAuthClient(AuthLink authLink, {
    String? customScheme,
  }) : super(
    authLink,
    codeQueryParam: 'auth_code',
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
    return Uri
        .parse(result)
        .queryParameters[codeQueryParam];
  }

  @override
  Future<String?> getAuthCodeWithWebView(BuildContext context, {
    bool useVirtualDisplay = false,
    PreferredSizeWidget? appBar,
  }) async {
    // ...
  }
}
```

// Use the custom client or the already provided clients like the [GoogleOAuthClient] as shown below

```dart

final client = GoogleOAuthClient(
  AuthLink(/*...*/),
);

final code = await client.getAuthCode();

// do whatever you with with the auth code
```

## Setup

Setup works as for any Flutter plugin, expect the Android and Web caveats outlined below:

### Android

In order to capture the callback url, the following `activity` needs to be added to
your `AndroidManifest.xml`. Be sure to relpace `YOUR_CALLBACK_URL_SCHEME_HERE` with your actual
callback url scheme.

```xml

<manifest>
    <application>

        <activity android:name="com.linusu.flutter_web_auth.CallbackActivity">
            <intent-filter android:label="flutter_web_auth">
                <action android:name="android.intent.action.VIEW" />
                <category android:name="android.intent.category.DEFAULT" />
                <category android:name="android.intent.category.BROWSABLE" />
                <data android:scheme="YOUR_CALLBACK_URL_SCHEME_HERE" />
            </intent-filter>
        </activity>

    </application>
</manifest>
```

### Web

On the Web platform an endpoint needs to be created that captures the callback URL and sends it to
the application using the JavaScript `postMessage()` method. In the `./web` folder of the project,
create an HTML file with the name e.g. `auth.html` with content:

```html
<!DOCTYPE html>
<title>Authentication complete</title>
<p>Authentication is complete. If this does not happen automatically, please
    close the window.
    <script>
  window.opener.postMessage({
    'flutter-web-auth': window.location.href
  }, window.location.origin);
  window.close();
    </script>
```

Redirection URL passed to the authentication service must be the same as the URL on which the
application is running (schema, host, port if necessary) and the path must point to created HTML
file, `/auth.html` in this case. The `callbackUrlScheme` parameter of the `authenticate()` method
does not take into account, so it is possible to use a schema for native platforms in the code.

For the Sign in with Apple in web_message response mode, postMessage from https://appleid.apple.com
is also captured, and the authorization object is returned as a URL fragment encoded as a query
string (for compatibility with other providers).

----

# OAuth2Buttons

```dart

import '';

//For google Button
OAuth2Button(
onTap: () {  //... }, //ontap handler
mini: true //Whether to render circular button (mini) or rectangular button
buttonType: OAuthButtonType.google, // Button type for different type buttons
iconColor: Colors.black,  // for change icons colors
),  
```


## Button Types

- Facebook
- Google
- Twitter
- Linkedin
- Whatsapp
- Apple
- Github
- Phone
- Email


## Contributing
Pull requests are very welcome. For major changes, please open an issue first to discuss what you would like to change.