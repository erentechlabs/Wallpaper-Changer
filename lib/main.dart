import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_changer/pages/HomePage.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpaper Changer',
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.light(scheme: FlexScheme.mandyRed,  appBarOpacity: 1.0, transparentStatusBar: true, useMaterial3: true),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.mandyRed, appBarOpacity: 1.0, transparentStatusBar: true, useMaterial3: true),
      home: HomePage(),
    );
  }
}
