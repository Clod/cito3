// Import necessary packages
import 'package:flutter/foundation.dart' show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:sip_ua/sip_ua.dart';

// Import local files
import 'src/about.dart';
import 'src/callscreen.dart';
import 'src/dialpad.dart';
import 'src/register.dart';

// Main function
// Este es el main que hay que correr
void main() {
  // Override default target platform for WebRTC on desktop
  if (WebRTC.platformIsDesktop) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }

  // Run the app
  runApp(MyApp());
}

// Define a type for the page content builder
typedef PageContentBuilder = Widget Function([SIPUAHelper? helper, Object? arguments]);

// MyApp class
class MyApp extends StatelessWidget {
  // Create an instance of SIPUAHelper (función de biblioteca)
  final SIPUAHelper _helper = SIPUAHelper();

  // Define routes for different screens
  Map<String, PageContentBuilder> routes = {
    // Página con la botonera
    '/': ([SIPUAHelper? helper, Object? arguments]) => DialPadWidget(helper),
    // Página de registro
    '/register': ([SIPUAHelper? helper, Object? arguments]) => RegisterWidget(helper),
    // Página para mostrar llamado entrante
    '/callscreen': ([SIPUAHelper? helper, Object? arguments]) => CallScreenWidget(helper, arguments as Call?),
    // About...
    '/about': ([SIPUAHelper? helper, Object? arguments]) => AboutWidget(),
  };

  // Generate route based on settings
  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    final String? name = settings.name;
    final PageContentBuilder? pageContentBuilder = routes[name!];

    // Check if the page content builder exists
    if (pageContentBuilder != null) {
      if (settings.arguments != null) {
        // Build route with arguments
        final Route route = MaterialPageRoute<Widget>(
            builder: (context) => pageContentBuilder(_helper, settings.arguments));
        return route;
      } else {
        // Build route without arguments
        final Route route = MaterialPageRoute<Widget>(
            builder: (context) => pageContentBuilder(_helper));
        return route;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      onGenerateRoute: _onGenerateRoute,
    );
  }
}