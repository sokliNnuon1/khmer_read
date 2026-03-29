import 'package:flutter/material.dart';
import 'package:khmer_read/module/Setting/Settingscreen.dart';
import 'package:khmer_read/module/Simple/FloatingHeaderExample.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String settings = '/settings';
  static const String simpleone = '/simpleone';
  
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Add the Home/Settings route here so it works on startup
      case home:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
        
      case simpleone:
        return MaterialPageRoute(builder: (_) => const FloatingHeaderExample());
        
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("No route defined for ${settings.name}"),
            ),
          ),
        );
    }
  }
}